/// Simple calculator class for testing practice
///
/// WHAT IS MUTATION TESTING?
/// ==========================
/// Mutation testing is a technique to evaluate the quality of your tests.
/// It works by making small changes (mutations) to your code and checking if
/// your tests detect these changes.
///
/// EXAMPLE: If you have code `return a + b;`, a mutation might change it to
/// `return a - b;`. If your tests still pass, they didn't detect the mutation,
/// meaning your test coverage is weak. If tests fail, the mutation was "killed".
///
/// COMMON MUTATIONS:
/// - Arithmetic: + → -, * → /, etc.
/// - Comparison: > → >=, == → !=, etc.
/// - Logical: && → ||, ! → noop
/// - Conditional: if → else, remove condition
/// - Return: return different value
///
/// WHY IT MATTERS:
/// - Identifies weak test coverage
/// - Helps find untested code paths
/// - Improves test quality
/// - Detects redundant tests
class Calculator {
  /// Adds two numbers
  ///
  /// POTENTIAL MUTATIONS:
  /// - Change + to -: return a - b; (tests should fail)
  /// - Change + to *: return a * b; (tests should fail)
  /// - Change + to /: return a / b; (tests should fail)
  /// - Return 0: return 0; (tests should fail)
  ///
  /// HOW TESTS KILL MUTATIONS:
  /// - Testing add(2, 3) expects 5
  /// - If mutated to subtract, returns -1, test fails ✓
  /// - If mutated to multiply, returns 6, test fails ✓
  int add(int a, int b) {
    return a + b;
  }

  /// Subtracts b from a
  ///
  /// POTENTIAL MUTATIONS:
  /// - Change - to +: return a + b; (tests should fail)
  /// - Change - to *: return a * b; (tests should fail)
  int subtract(int a, int b) {
    return a - b;
  }

  /// Multiplies two numbers
  ///
  /// POTENTIAL MUTATIONS:
  /// - Change * to +: return a + b; (tests should fail)
  /// - Change * to /: return a / b; (tests should fail)
  /// - Change * to -: return a - b; (tests should fail)
  int multiply(int a, int b) {
    return a * b;
  }

  /// Divides a by b
  ///
  /// POTENTIAL MUTATIONS:
  /// - Change / to *: return a * b; (tests should fail)
  /// - Remove zero check: if (b != 0) (tests should fail for division by zero)
  /// - Change == to !=: if (b != 0) (tests should fail)
  double divide(int a, int b) {
    if (b == 0) {
      throw ArgumentError('Cannot divide by zero');
    }
    return a / b;
  }

  /// Returns the maximum of two numbers
  ///
  /// POTENTIAL MUTATIONS:
  /// - Change > to >=: if (a >= b) (might not be caught by all tests)
  /// - Change > to <: if (a < b) (tests should fail)
  /// - Change > to <=: if (a <= b) (tests should fail)
  /// - Swap return values: return b; else return a; (tests should fail)
  /// - Remove else: return a; (tests should fail when b > a)
  int max(int a, int b) {
    if (a > b) {
      return a;
    } else {
      return b;
    }
  }

  /// Returns the minimum of two numbers
  ///
  /// POTENTIAL MUTATIONS:
  /// - Change < to >: if (a > b) (tests should fail)
  /// - Change < to <=: if (a <= b) (might not be caught by all tests)
  /// - Swap return values: return b; else return a; (tests should fail)
  int min(int a, int b) {
    if (a < b) {
      return a;
    } else {
      return b;
    }
  }

  /// Checks if a number is even
  ///
  /// POTENTIAL MUTATIONS:
  /// - Change == to !=: return number % 2 != 0; (tests should fail)
  /// - Change 2 to 1: return number % 1 == 0; (always true, tests should fail)
  /// - Change 2 to 3: return number % 3 == 0; (tests should fail)
  /// - Return true: return true; (tests should fail for odd numbers)
  /// - Return false: return false; (tests should fail for even numbers)
  bool isEven(int number) {
    return number % 2 == 0;
  }

  /// Calculates the factorial of a number
  ///
  /// POTENTIAL MUTATIONS:
  /// - Change < to <=: if (n <= 0) (tests should fail for n=0)
  /// - Change * to +: return n + factorial(n - 1); (tests should fail)
  /// - Change - to +: return n * factorial(n + 1); (infinite loop, tests timeout)
  /// - Remove base case: if (n == 0 || n == 1) (infinite loop, tests timeout)
  /// - Return 0: return 0; (tests should fail)
  int factorial(int n) {
    if (n < 0) {
      throw ArgumentError('Factorial is not defined for negative numbers');
    }
    if (n == 0 || n == 1) {
      return 1;
    }
    return n * factorial(n - 1);
  }

  /// Calculates the nth Fibonacci number
  ///
  /// POTENTIAL MUTATIONS:
  /// - Change + to -: return fibonacci(n - 1) - fibonacci(n - 2); (tests should fail)
  /// - Change - to +: return fibonacci(n + 1) + fibonacci(n - 2); (tests should fail)
  /// - Swap calls: return fibonacci(n - 2) + fibonacci(n - 1); (same result, might survive)
  /// - Change 0 to 1: if (n == 1) return 0; (tests should fail)
  /// - Change 1 to 0: if (n == 0) return 1; (tests should fail)
  int fibonacci(int n) {
    if (n < 0) {
      throw ArgumentError('Fibonacci is not defined for negative numbers');
    }
    if (n == 0) return 0;
    if (n == 1) return 1;
    return fibonacci(n - 1) + fibonacci(n - 2);
  }
}
