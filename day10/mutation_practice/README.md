# Calculator Testing Practice

A simple Dart project for practicing testing with a calculator implementation.

## Project Structure

- `lib/calculator.dart` - Calculator class with various functions and detailed mutation testing comments
- `test/calculator_test.dart` - Comprehensive tests with comments explaining how they kill mutations

## What is Mutation Testing?

Mutation testing is a technique to evaluate the quality of your tests by making small changes (mutations) to your code and checking if your tests detect these changes.

### How It Works

1. **Original Code**: `return a + b;`
2. **Mutated Code**: `return a - b;` (mutation: changed + to -)
3. **Run Tests**: If tests still pass, the mutation "survived" → weak test coverage
4. **Run Tests**: If tests fail, the mutation was "killed" → good test coverage

### Example

```dart
// Original code
int add(int a, int b) {
  return a + b;  // Returns 5 when called with add(2, 3)
}

// Mutated code (mutation: + → -)
int add(int a, int b) {
  return a - b;  // Returns -1 when called with add(2, 3)
}

// Test
test('adds two positive numbers', () {
  expect(calculator.add(2, 3), equals(5));
});

// Result: Test expects 5, but mutated code returns -1
// → Test fails ✓ (mutation killed)
```

### Common Mutations

- **Arithmetic**: `+ → -`, `* → /`, `/ → *`
- **Comparison**: `> → >=`, `== → !=`, `< → <=`
- **Logical**: `&& → ||`, `! → noop`
- **Conditional**: `if → else`, remove condition
- **Return**: Return different value (0, false, etc.)

### Why Mutation Testing Matters

- **Identifies weak test coverage**: Find code paths not tested
- **Improves test quality**: Write tests that catch bugs
- **Detects redundant tests**: Tests that don't actually verify behavior
- **Builds confidence**: High mutation score = robust tests

## Running Tests

Run the unit tests:
```bash
dart test
```

## Calculator Functions

The calculator includes the following functions with detailed mutation testing comments:
- `add` - Adds two numbers
- `subtract` - Subtracts two numbers
- `multiply` - Multiplies two numbers
- `divide` - Divides two numbers (throws error on division by zero)
- `max` - Returns the maximum of two numbers
- `min` - Returns the minimum of two numbers
- `isEven` - Checks if a number is even
- `factorial` - Calculates factorial
- `fibonacci` - Calculates the nth Fibonacci number

## Learning Mutation Testing

Each function in `calculator.dart` includes comments showing:
- What mutations could be made to that function
- How the tests should detect (kill) those mutations
- Why certain tests are needed to catch specific mutations

Each test in `calculator_test.dart` includes comments showing:
- Which specific mutations that test kills
- What would happen if the code were mutated
- Why the test would fail (or in some cases, why it might not)

## Testing Practice

This project provides a good foundation for practicing:
- Unit testing
- Edge case testing
- Error handling testing
- Recursive function testing
- **Mutation testing concepts** (understanding what makes tests effective)
