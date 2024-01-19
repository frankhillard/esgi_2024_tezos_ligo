## Exercice 3

Vote contract 

### Setup
You can start from the exo_1_solution implementation of contract and tests.

### What is asked

- The result of the vote must be available for anyone.
- Only the admin can reset the poll
- The vote finishes after 6 votes.

- the test must check success and failure of Vote entrypoint 


### Hints
Obvious rules of a voting contract:
- a voter can only vote once
- a voter can vote only for a candidate
- a voter can vote only if the vote is not over

- the result must be an optional

### Solution
- lib/exo_3_solution.mligo
- test/exo_3_solution.test.mligo