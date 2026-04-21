import 'package:flutter_test/flutter_test.dart';
import 'package:error_handling_practice/exercise2_custom_exceptions.dart'
    as ex2;
import 'package:error_handling_practice/exercise3_result_types.dart';

void main() {
  group('Exercise 2: Custom Exception Hierarchy', () {
    group('AuthException', () {
      test('InvalidCredentialsException has correct message and code', () {
        final exception = ex2.InvalidCredentialsException();
        expect(exception.message, equals('Invalid username or password'));
        expect(exception.code, equals('INVALID_CREDENTIALS'));
      });

      test('AccountLockedException has correct message and code', () {
        final exception = ex2.AccountLockedException();
        expect(exception.message, equals('Account is locked'));
        expect(exception.code, equals('ACCOUNT_LOCKED'));
      });

      test('SessionExpiredException has correct message and code', () {
        final exception = ex2.SessionExpiredException();
        expect(exception.message, equals('Session has expired'));
        expect(exception.code, equals('SESSION_EXPIRED'));
      });
    });

    group('ValidationException (exercise2)', () {
      test('EmailValidationException has correct field, message and code', () {
        final exception = ex2.EmailValidationException();
        expect(exception.field, equals('email'));
        expect(exception.message, equals('Invalid email format'));
        expect(exception.code, equals('INVALID_EMAIL'));
      });

      test(
        'PasswordValidationException has correct field, message and code',
        () {
          final exception = ex2.PasswordValidationException();
          expect(exception.field, equals('password'));
          expect(
            exception.message,
            equals('Password must be at least 8 characters'),
          );
          expect(exception.code, equals('WEAK_PASSWORD'));
        },
      );

      test('AgeValidationException has correct field, message and code', () {
        final exception = ex2.AgeValidationException();
        expect(exception.field, equals('age'));
        expect(exception.message, equals('Must be at least 18 years old'));
        expect(exception.code, equals('UNDERAGE'));
      });
    });

    group('NetworkException (exercise2)', () {
      test('ConnectionException has correct message and code', () {
        final exception = ex2.ConnectionException();
        expect(exception.message, equals('No internet connection'));
        expect(exception.code, equals('NO_CONNECTION'));
      });

      test('ServerException has default message', () {
        final exception = ex2.ServerException();
        expect(exception.message, equals('Server error'));
        expect(exception.code, equals('SERVER_ERROR'));
      });

      test('ServerException accepts custom message', () {
        final exception = ex2.ServerException('Custom server error');
        expect(exception.message, equals('Custom server error'));
        expect(exception.code, equals('SERVER_ERROR'));
      });

      test('TimeoutException has correct message and code', () {
        final exception = ex2.TimeoutException();
        expect(exception.message, equals('Request timed out'));
        expect(exception.code, equals('TIMEOUT'));
      });
    });

    group('DataException', () {
      test('NotFoundException includes resource in message', () {
        final exception = ex2.NotFoundException('User');
        expect(exception.message, equals('User not found'));
        expect(exception.code, equals('NOT_FOUND'));
      });

      test('DuplicateException includes resource in message', () {
        final exception = ex2.DuplicateException('Email');
        expect(exception.message, equals('Email already exists'));
        expect(exception.code, equals('DUPLICATE'));
      });
    });

    group('AuthService', () {
      test(
        'AuthService throws InvalidCredentialsException for empty credentials',
        () {
          final service = ex2.AuthService();
          expect(
            () => service.login('', 'password'),
            throwsA(isA<ex2.InvalidCredentialsException>()),
          );
          expect(
            () => service.login('username', ''),
            throwsA(isA<ex2.InvalidCredentialsException>()),
          );
        },
      );

      test('AuthService throws AccountLockedException for locked account', () {
        final service = ex2.AuthService();
        expect(
          () => service.login('locked', 'password'),
          throwsA(isA<ex2.AccountLockedException>()),
        );
      });

      test('AuthService does not throw for valid credentials', () {
        final service = ex2.AuthService();
        expect(() => service.login('user', 'password'), returnsNormally);
      });
    });

    group('ValidationService', () {
      test(
        'ValidationService throws EmailValidationException for invalid email',
        () {
          final service = ex2.ValidationService();
          expect(
            () => service.validateEmail('invalid'),
            throwsA(isA<ex2.EmailValidationException>()),
          );
        },
      );

      test('ValidationService does not throw for valid email', () {
        final service = ex2.ValidationService();
        expect(() => service.validateEmail('valid@email.com'), returnsNormally);
      });

      test(
        'ValidationService throws PasswordValidationException for weak password',
        () {
          final service = ex2.ValidationService();
          expect(
            () => service.validatePassword('short'),
            throwsA(isA<ex2.PasswordValidationException>()),
          );
        },
      );

      test('ValidationService does not throw for strong password', () {
        final service = ex2.ValidationService();
        expect(
          () => service.validatePassword('strongpassword'),
          returnsNormally,
        );
      });

      test('ValidationService throws AgeValidationException for underage', () {
        final service = ex2.ValidationService();
        expect(
          () => service.validateAge(17),
          throwsA(isA<ex2.AgeValidationException>()),
        );
      });

      test('ValidationService does not throw for valid age', () {
        final service = ex2.ValidationService();
        expect(() => service.validateAge(18), returnsNormally);
      });
    });
  });

  group('Exercise 3: Result Types', () {
    group('Result type', () {
      test('Result.success creates Success instance', () {
        final result = Result.success('test data');
        expect(result, isA<Success>());
      });

      test('Result.failure creates Failure instance', () {
        final result = Result.failure('error message');
        expect(result, isA<Failure>());
      });

      test('Result.failure with code creates Failure with code', () {
        final result = Result.failure('error message', code: 'ERROR_CODE');
        expect(result, isA<Failure>());
        expect((result as Failure).code, equals('ERROR_CODE'));
      });
    });

    group('Success', () {
      test('Success holds data', () {
        final success = Success('test data');
        expect(success.data, equals('test data'));
      });
    });

    group('Failure', () {
      test('Failure holds message', () {
        final failure = Failure('error message');
        expect(failure.message, equals('error message'));
      });

      test('Failure can hold code', () {
        final failure = Failure('error message', code: 'ERROR_CODE');
        expect(failure.code, equals('ERROR_CODE'));
      });
    });

    group('AppFailure', () {
      test('AppFailure toString returns formatted string', () {
        final failure = NetworkFailure();
        expect(failure.toString(), equals('NETWORK_ERROR: Network error'));
      });
    });

    group('ResultExtension', () {
      test('fold calls onSuccess for Success', () {
        final result = Result.success('test data');
        final resultValue = result.fold(
          (failure) => 'error',
          (success) => success.data,
        );
        expect(resultValue, equals('test data'));
      });

      test('fold calls onFailure for Failure', () {
        final result = Result.failure('error message');
        final resultValue = result.fold(
          (failure) => failure.message,
          (success) => success.data,
        );
        expect(resultValue, equals('error message'));
      });

      test('getOrElse returns data for Success', () {
        final result = Result.success('test data');
        expect(result.getOrElse('default'), equals('test data'));
      });

      test('getOrElse returns default for Failure', () {
        final result = Result.failure('error message');
        expect(result.getOrElse('default'), equals('default'));
      });

      test('getOrNull returns data for Success', () {
        final result = Result.success('test data');
        expect(result.getOrNull(), equals('test data'));
      });

      test('getOrNull returns null for Failure', () {
        final result = Result.failure('error message');
        expect(result.getOrNull(), isNull);
      });

      test('isSuccess returns true for Success', () {
        final result = Result.success('test data');
        expect(result.isSuccess, isTrue);
        expect(result.isFailure, isFalse);
      });

      test('isFailure returns true for Failure', () {
        final result = Result.failure('error message');
        expect(result.isFailure, isTrue);
        expect(result.isSuccess, isFalse);
      });
    });

    group('UserRepositoryGood', () {
      test('getUserEmail returns success for valid user', () async {
        final repository = UserRepositoryGood();
        final result = await repository.getUserEmail('user123');
        expect(result.isSuccess, isTrue);
        expect((result as Success).data, equals('user@example.com'));
      });

      test('getUserEmail returns failure for empty userId', () async {
        final repository = UserRepositoryGood();
        final result = await repository.getUserEmail('');
        expect(result.isFailure, isTrue);
        expect((result as Failure).message, equals('User ID cannot be empty'));
        expect((result as Failure).code, equals('INVALID_ID'));
      });
    });
  });
}
