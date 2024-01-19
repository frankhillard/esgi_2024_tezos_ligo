# LIGO exercices (cameligo)

## Introduction

The goal is to learn good practices of coding smart contract in cameligo. This also includes writing tests using the Test framework provided with the LIGO compiler.

This repository is intended to propose small simple exercices and also to provide a solution for them.

## Makefile

If you have cloned this repo, you can use the makefile to easily compile contract with `make compile` or run tests `make test` or run tests on a single exercice `make test SUITE=exo_1_solution`

Your starting point is the exo_1
```
make test SUITE=exo_1
```

## Exercices

| Exercice          | Name          | Difficulty | Solution                                                                     |   |   |
|-------------------|---------------|------------|------------------------------------------------------------------------------|---|---|
| [exo 1](exo_1.md) | Counter       | XS         | [contract](lib/exo_1_solution.mligo), [test](test/exo_1_solution.test.mligo)  |   |   |
| [exo 2](exo_2.md) | Counter++     | S          | [contract](lib/exo_2_solution.mligo), [test](test/exo_2_solution.test.mligo)  |   |   |
| [exo 3](exo_3.md) | Vote          | M          | [contract](lib/exo_3_solution.mligo), [test](test/exo_3_solution.test.mligo)  |   |   |
| [exo 4](exo_4.md) | SimpleToken   | M          | [contract](lib/exo_4_solution.mligo), [test](test/exo_4_solution.test.mligo)  |   |   |
| [exo 5](exo_5.md) | SimpleToken++ | S          |                                                                              |   |   |