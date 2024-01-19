SHELL := /bin/bash

help:
	@grep -E '^[ a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

ifndef LIGO
LIGO=docker run --platform linux/amd64 -u $(id -u):$(id -g) --rm -v "$(PWD)":"$(PWD)" -w "$(PWD)" ligolang/ligo:1.2.0
endif
# ^ use LIGO en var bin if configured, otherwise use docker

compile = $(LIGO) compile contract  --project-root ./src ./src/$(1) -o ./compiled/$(2) $(3) 
# ^ Compile contracts to Michelson or Micheline

test = @$(LIGO) run test $(project_root) ./test/$(1)
# ^ run given test file


.PHONY: test compile
compile: ## compile contracts to Michelson
	@mkdir -p compiled
	@$(call compile,counter.mligo,counter.tz, -m C)
	@$(call compile,exo_1.mligo,exo_1.tz, -m C)
	@$(call compile,exo_2.mligo,exo_2.tz, -m C)


test: ## run tests (SUITE=asset_approve make test)
ifndef SUITE
	@$(call test,counter.test.mligo)
	@$(call test,exo_1.test.mligo)
	@$(call test,exo_2.test.mligo)

else
	@$(call test,$(SUITE).test.mligo)
endif