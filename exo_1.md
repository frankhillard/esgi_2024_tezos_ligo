## Exercice 1

Counter contract 

### Setup
You can start from the counter contract implementation of documentation.

### What is asked
- modify the reset entrypoint  so that only admin is allowed to invoke Reset entrypoint.
- modify sotrage to integrate an admin role

- Add tests (success and failure)

### Hints
- Use `List.fold`

### Solution
lib/exo_2_solution.mligo
test/exo_2_solution.test.mligo