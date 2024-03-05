## Exercice 2

Counter contract 

### Setup
You can start from the [exo_1_solution](lib/exo_1_solution.mligo) implementation of contract and tests.

### What is asked

- Add a new entrypoint named "Increment_many" which takes a list of integer as parameter ( and the storage as 2nd parameter as usual). It updates the `value` field of the storage by computing the sum of all integer of the list and the storage value.
- Add a test 

### Hints
- Use `List.fold`

### Solution
lib/exo_2_solution.mligo
test/exo_2_solution.test.mligo