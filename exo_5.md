## Exercice 5

SimpleToken contract  (not standard)

### Setup
You can start from the exo_4_solution implementation of contract and tests.

### What is asked

In the previous exercice:

Create a smart contract that keep a registry of user and their corresponding balance (i.e. amount of token). The smart contract allows to transfer some funds between users and provides a "on-chain" view to query the balance of a user. For testing reason, the smart contract must support an "admin" role which can create and destroy tokens.

- Add a `transfer` entrypoint which allows anyone to send some assets of his balance to an other user
- Add a `balance_of` view which allows anyone to query the balance of a user
- Add a `mint` entrypoint which allows the admin of the contract to create some assets and assign them to a user
- Add a `burn` entrypoint which allows the admin of the contract to remove some assets from a user 


Additionnal feature:
- allowance feature : a user can authorize someone else to transfer some of his funds 



- the test must check success and failure of entrypoints 


### Hints


### Solution
- lib/exo_5_solution.mligo
- test/exo_5_solution.test.mligo