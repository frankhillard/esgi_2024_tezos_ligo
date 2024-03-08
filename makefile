SHELL := cmd

help:
	@echo off & for /f "tokens=1,* delims=#" %%i in ('findstr /R "^[a-z]\w+: ## \w+" $(MAKEFILE_LIST)') do @(if not "%%j" == "" (echo %%i : %%j))

ifndef LIGO
LIGO=docker run --platform linux/amd64 --rm -v "$(CURDIR)":"/app" -w "/app" ligolang/ligo:1.2.0
endif
# ^ use LIGO env var bin if configured, otherwise use docker

compile = $(LIGO) compile contract  --project-root ./src ./src/$(1) -o ./compiled/$(2) $(3) 
# ^ Compile contracts to Michelson or Micheline

test = @$(LIGO) run test $(project_root) ./test/$(1)
# ^ run given test file

.PHONY: test compile
compile: ## compile contracts to Michelson
	@if not exist "compiled" mkdir compiled
	@$(call compile,counter.mligo,counter.tz, -m C)
	@$(call compile,counter.mligo,counter.mligo.json, -m C --michelson-format json)

test: ## run tests (SUITE=asset_approve make test)
ifndef SUITE
	@$(call test,mToken.test.mligo)

else
	@$(call test,$(SUITE).test.mligo)
endif

deploy: deploy_deps deploy.js ## deploy exo_2

deploy.js:
	@echo Running deploy script
	@cd deploy && npm i && npm run deploy_exo2

deploy_deps:
	@echo Installing deploy script dependencies
	@cd deploy && npm install
	@echo ""
