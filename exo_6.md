## Exercice 6

Vesting contract (locked tokens)

### Setup
You will need the "FA2" token implementation from Ligolang registry.

### What is asked

Create a smart contract that distributes funds to beneficiaries on a period of time. Funds are frozen during a probatory period then available on time basis (proportionnaly to the period duration). Funds are implemented as a FA2 token. 

The administrator of the contract must own the required amount of tokens to be able to `start` the contract. 

The `start` entrypoint transfers vested tokens to the contract, and set the starting time and the vesting starting time.

The beneficiaries are specified at the creation of the contract, with their corresponding promised amounts of token.

The vesting duration, and probatory period duration are specified at the creation of the contract.

The FA2 token (address and token_id) that is used to represent funds must be specified at the creation of the contract. 


Available funds can be claimed by a beneficiary. The `claim` entrypoint transfers available amount of tokens to the beneficiary.

A `kill` entrypoint callable only by the administrator must be implemented to be able to retrieve funds, and pay beneficiaries (on time elpased basis).  


Obviously, 
- a non-beneficiary cannot claim and receive funds
- a beneficiary cannot claim and receive more funds than promised

The tests must check success and failure of entrypoints 


### Hints

The `claim` entrypoint transfers available funds to the beneficiary (caller) by invoking the `Transfer` entrypoint of the FA2 token.



### Solution
- lib/exo_6_solution.mligo
- test/exo_6_solution.test.mligo