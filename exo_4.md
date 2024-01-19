## Exercice 4

SimpleToken contract  (not standard)

### Setup
You can start from the exo_1_solution implementation of contract and tests.

### What is asked

Create a smart contract that keep a registry of user and their corresponding balance (i.e. amount of token). The smart contract allows to transfer some funds between users and provides a "on-chain" view to query the balance of a user. For testing reason, the smart contract must support an "admin" role which can create and destroy tokens.

- Add a `transfer` entrypoint which allows anyone to send some assets of his balance to an other user
- Add a `balance_of` view which allows anyone to query the balance of a user
- Add a `mint` entrypoint which allows the admin of the contract to create some assets and assign them to a user
- Add a `burn` entrypoint which allows the admin of the contract to remove some assets from a user 


- the test must check success and failure of entrypoints 


### Hints


### Solution
- lib/exo_4_solution.mligo
- test/exo_4_solution.test.mligo