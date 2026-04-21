import 'package:test/test.dart';
import 'package:mutation_practice/calculator.dart';

/// Test file for Calculator class with mutation testing comments
///
/// MUTATION TESTING IN PRACTICE:
/// ==============================
/// Each test below is designed to "kill" specific mutations in the code.
/// A mutation is "killed" when the test fails after the code is mutated.
///
/// Example:
/// Original code: return a + b;
/// Mutated code: return a - b;
/// Test: expect(calculator.add(2, 3), equals(5));
/// Result: Test expects 5, but mutated code returns -1 → Test fails ✓ (mutation killed)
///
/// If a test passes after mutation, the mutation "survived" → weak test coverage
void main() {
  group('Calculator Tests', () {
    final calculator = Calculator();

    group('add', () {
      // This test kills mutations like:
      // - return a - b; (would return -1 instead of 5)
      // - return a * b; (would return 6 instead of 5)
      // - return a / b; (would return 0 instead of 5)
      test('adds two positive numbers', () {
        expect(calculator.add(2, 3), equals(5));
      });

      // This test kills mutations like:
      // - return a - b; (would return 8 instead of 2)
      // - return a * b; (would return -15 instead of 2)
      test('adds positive and negative numbers', () {
        expect(calculator.add(5, -3), equals(2));
      });

      // This test kills mutations like:
      // - return a - b; (would return 1 instead of -5)
      // - return a * b; (would return 6 instead of -5)
      test('adds two negative numbers', () {
        expect(calculator.add(-2, -3), equals(-5));
      });

      // These tests kill mutations like:
      // - return a - b; (would return 5 instead of 5 for first case, but fail for others)
      // - return a * b; (would return 0 instead of 5)
      test('adds zero', () {
        expect(calculator.add(5, 0), equals(5));
        expect(calculator.add(0, 5), equals(5));
        expect(calculator.add(0, 0), equals(0));
      });
    });

    group('subtract', () {
      // This test kills mutations like:
      // - return a + b; (would return 8 instead of 2)
      // - return a * b; (would return 15 instead of 2)
      test('subtracts two positive numbers', () {
        expect(calculator.subtract(5, 3), equals(2));
      });

      // This test kills mutations like:
      // - return a + b; (would return 2 instead of 8)
      // - return a * b; (would return -15 instead of 8)
      test('subtracts positive and negative numbers', () {
        expect(calculator.subtract(5, -3), equals(8));
      });

      // This test kills mutations like:
      // - return a + b; (would return -8 instead of -2)
      // - return a * b; (would return 15 instead of -2)
      test('subtracts two negative numbers', () {
        expect(calculator.subtract(-5, -3), equals(-2));
      });

      // These tests kill mutations like:
      // - return a + b; (would return 5 instead of 5 for first, but fail for second)
      // - return a * b; (would return 0 instead of 5)
      test('subtracts zero', () {
        expect(calculator.subtract(5, 0), equals(5));
        expect(calculator.subtract(0, 5), equals(-5));
        expect(calculator.subtract(0, 0), equals(0));
      });
    });

    group('multiply', () {
      // This test kills mutations like:
      // - return a + b; (would return 7 instead of 12)
      // - return a / b; (would return 0 instead of 12)
      test('multiplies two positive numbers', () {
        expect(calculator.multiply(3, 4), equals(12));
      });

      // This test kills mutations like:
      // - return a + b; (would return -1 instead of -12)
      // - return a / b; (would return -0 instead of -12)
      test('multiplies positive and negative numbers', () {
        expect(calculator.multiply(3, -4), equals(-12));
      });

      // This test kills mutations like:
      // - return a + b; (would return -7 instead of 12)
      // - return a / b; (would return 0 instead of 12)
      test('multiplies two negative numbers', () {
        expect(calculator.multiply(-3, -4), equals(12));
      });

      // These tests kill mutations like:
      // - return a + b; (would return 5 instead of 0)
      // - return a / b; (would cause division by zero error)
      test('multiplies by zero', () {
        expect(calculator.multiply(5, 0), equals(0));
        expect(calculator.multiply(0, 5), equals(0));
        expect(calculator.multiply(0, 0), equals(0));
      });

      // These tests kill mutations like:
      // - return a + b; (would return 6 instead of 5)
      // - return a / b; (would return 5 instead of 5 for first, might survive)
      test('multiplies by one', () {
        expect(calculator.multiply(5, 1), equals(5));
        expect(calculator.multiply(1, 5), equals(5));
      });
    });

    group('divide', () {
      // This test kills mutations like:
      // - return a * b; (would return 20 instead of 5.0)
      // - return a + b; (would return 12 instead of 5.0)
      test('divides two positive numbers', () {
        expect(calculator.divide(10, 2), equals(5.0));
      });

      // This test kills mutations like:
      // - return a * b; (would return -20 instead of -5.0)
      // - return a + b; (would return 8 instead of -5.0)
      test('divides positive and negative numbers', () {
        expect(calculator.divide(10, -2), equals(-5.0));
      });

      // This test kills mutations like:
      // - return a * b; (would return 20 instead of 5.0)
      // - return a + b; (would return -12 instead of 5.0)
      test('divides two negative numbers', () {
        expect(calculator.divide(-10, -2), equals(5.0));
      });

      // This test kills mutations like:
      // - return a * b; (would return 5 instead of 5.0, type mismatch)
      // - return a + b; (would return 6 instead of 5.0)
      test('divides by one', () {
        expect(calculator.divide(5, 1), equals(5.0));
      });

      // This test kills mutations like:
      // - if (b != 0) (would not throw error, test fails)
      // - Remove throw statement (would not throw error, test fails)
      test('throws error when dividing by zero', () {
        expect(() => calculator.divide(10, 0), throwsArgumentError);
      });
    });

    group('max', () {
      // This test kills mutations like:
      // - if (a < b) (would return 3 instead of 5)
      // - if (a <= b) (would return 3 instead of 5)
      // - Swap return values (would return 3 instead of 5)
      test('returns first number when greater', () {
        expect(calculator.max(5, 3), equals(5));
      });

      // This test kills mutations like:
      // - if (a > b) (would return 3 instead of 5)
      // - if (a >= b) (might not be caught, returns 5 either way)
      // - Swap return values (would return 3 instead of 5)
      test('returns second number when greater', () {
        expect(calculator.max(3, 5), equals(5));
      });

      // This test kills mutations like:
      // - if (a > b) (still returns 5, mutation survives)
      // - if (a >= b) (still returns 5, mutation survives)
      // - Swap return values (still returns 5, mutation survives)
      // Note: This test might not kill all mutations when values are equal
      test('returns first number when equal', () {
        expect(calculator.max(5, 5), equals(5));
      });

      // These tests kill mutations like:
      // - if (a > b) (would return -5 instead of -3 for first)
      // - Swap return values (would return -5 instead of -3 for first)
      test('handles negative numbers', () {
        expect(calculator.max(-3, -5), equals(-3));
        expect(calculator.max(-5, -3), equals(-3));
      });

      // These tests kill mutations like:
      // - if (a > b) (would return 0 instead of 5 for second)
      // - Swap return values (would return 0 instead of 5 for second)
      test('handles zero', () {
        expect(calculator.max(0, 5), equals(5));
        expect(calculator.max(5, 0), equals(5));
        expect(calculator.max(0, 0), equals(0));
      });
    });

    group('min', () {
      // This test kills mutations like:
      // - if (a > b) (would return 5 instead of 3)
      // - if (a >= b) (would return 5 instead of 3)
      // - Swap return values (would return 5 instead of 3)
      test('returns first number when smaller', () {
        expect(calculator.min(3, 5), equals(3));
      });

      // This test kills mutations like:
      // - if (a < b) (would return 5 instead of 3)
      // - if (a <= b) (might not be caught, returns 3 either way)
      // - Swap return values (would return 5 instead of 3)
      test('returns second number when smaller', () {
        expect(calculator.min(5, 3), equals(3));
      });

      // This test kills mutations like:
      // - if (a < b) (still returns 5, mutation survives)
      // - if (a <= b) (still returns 5, mutation survives)
      // - Swap return values (still returns 5, mutation survives)
      // Note: This test might not kill all mutations when values are equal
      test('returns first number when equal', () {
        expect(calculator.min(5, 5), equals(5));
      });

      // These tests kill mutations like:
      // - if (a < b) (would return -3 instead of -5 for first)
      // - Swap return values (would return -3 instead of -5 for first)
      test('handles negative numbers', () {
        expect(calculator.min(-3, -5), equals(-5));
        expect(calculator.min(-5, -3), equals(-5));
      });

      // These tests kill mutations like:
      // - if (a < b) (would return 5 instead of 0 for second)
      // - Swap return values (would return 5 instead of 0 for second)
      test('handles zero', () {
        expect(calculator.min(0, 5), equals(0));
        expect(calculator.min(5, 0), equals(0));
        expect(calculator.min(0, 0), equals(0));
      });
    });

    group('isEven', () {
      // These tests kill mutations like:
      // - return number % 2 != 0; (would return false instead of true)
      // - return false; (would return false instead of true)
      // - number % 1 == 0 (always true, but test expects true for even only)
      test('returns true for even numbers', () {
        expect(calculator.isEven(2), isTrue);
        expect(calculator.isEven(4), isTrue);
        expect(calculator.isEven(0), isTrue);
        expect(calculator.isEven(-2), isTrue);
      });

      // These tests kill mutations like:
      // - return number % 2 != 0; (would return true instead of false)
      // - return true; (would return true instead of false)
      // - number % 1 == 0 (always true, test expects false)
      test('returns false for odd numbers', () {
        expect(calculator.isEven(1), isFalse);
        expect(calculator.isEven(3), isFalse);
        expect(calculator.isEven(-1), isFalse);
      });
    });

    group('factorial', () {
      // This test kills mutations like:
      // - if (n <= 0) (would skip base case, infinite loop or wrong result)
      // - return 0; (would return 0 instead of 1)
      test('calculates factorial of 0', () {
        expect(calculator.factorial(0), equals(1));
      });

      // This test kills mutations like:
      // - if (n == 0 || n == 1) (would skip base case, infinite loop)
      // - return 0; (would return 0 instead of 1)
      test('calculates factorial of 1', () {
        expect(calculator.factorial(1), equals(1));
      });

      // This test kills mutations like:
      // - return n + factorial(n - 1); (would return 15 instead of 120)
      // - return n * factorial(n + 1); (infinite loop, test timeout)
      // - Remove base case (infinite loop, test timeout)
      test('calculates factorial of 5', () {
        expect(calculator.factorial(5), equals(120));
      });

      // This test kills mutations like:
      // - return n + factorial(n - 1); (would return wrong result)
      // - return 0; (would return 0 instead of 3628800)
      test('calculates factorial of 10', () {
        expect(calculator.factorial(10), equals(3628800));
      });

      // This test kills mutations like:
      // - if (n > 0) (would not throw error for negative, test fails)
      // - Remove throw statement (would not throw error, test fails)
      test('throws error for negative numbers', () {
        expect(() => calculator.factorial(-1), throwsArgumentError);
      });
    });

    group('fibonacci', () {
      // This test kills mutations like:
      // - if (n == 1) return 0; (would return 0 instead of 0, mutation survives)
      // - if (n == 0) return 1; (would return 1 instead of 0)
      test('calculates fibonacci of 0', () {
        expect(calculator.fibonacci(0), equals(0));
      });

      // This test kills mutations like:
      // - if (n == 0) return 1; (would return 1 instead of 1, mutation survives)
      // - if (n == 1) return 0; (would return 0 instead of 1)
      test('calculates fibonacci of 1', () {
        expect(calculator.fibonacci(1), equals(1));
      });

      // This test kills mutations like:
      // - return fibonacci(n - 1) - fibonacci(n - 2); (would return wrong result)
      // - return fibonacci(n + 1) + fibonacci(n - 2); (would return wrong result)
      // - Remove base cases (infinite loop, test timeout)
      test('calculates fibonacci of 5', () {
        expect(calculator.fibonacci(5), equals(5));
      });

      // This test kills mutations like:
      // - return fibonacci(n - 1) - fibonacci(n - 2); (would return wrong result)
      // - return 0; (would return 0 instead of 55)
      test('calculates fibonacci of 10', () {
        expect(calculator.fibonacci(10), equals(55));
      });

      // This test kills mutations like:
      // - if (n > 0) (would not throw error for negative, test fails)
      // - Remove throw statement (would not throw error, test fails)
      test('throws error for negative numbers', () {
        expect(() => calculator.fibonacci(-1), throwsArgumentError);
      });
    });
  });
}
