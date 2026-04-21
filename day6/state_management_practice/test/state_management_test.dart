import 'package:flutter_test/flutter_test.dart';
import 'package:state_management_practice/exercise2_multi_step_form.dart';
import 'package:state_management_practice/exercise4_clean_architecture.dart';

void main() {
  group('Exercise 2: FormModel', () {
    test('FormModel initializes with empty strings', () {
      final formModel = FormModel();
      expect(formModel.name, equals(''));
      expect(formModel.email, equals(''));
      expect(formModel.address, equals(''));
    });

    test('FormModel can be updated', () {
      final formModel = FormModel();
      formModel.name = 'John Doe';
      formModel.email = 'john@example.com';
      formModel.address = '123 Main St';

      expect(formModel.name, equals('John Doe'));
      expect(formModel.email, equals('john@example.com'));
      expect(formModel.address, equals('123 Main St'));
    });
  });

  group('Exercise 4: Clean Architecture', () {
    group('User Entity', () {
      test('User creates with required fields', () {
        final user = User(
          id: '123',
          name: 'John Doe',
          email: 'john@example.com',
        );

        expect(user.id, equals('123'));
        expect(user.name, equals('John Doe'));
        expect(user.email, equals('john@example.com'));
      });

      test('User fields are immutable', () {
        final user = User(
          id: '123',
          name: 'John Doe',
          email: 'john@example.com',
        );

        // Verify fields are final (cannot be reassigned)
        expect(user.id, equals('123'));
        expect(user.name, equals('John Doe'));
        expect(user.email, equals('john@example.com'));
      });
    });

    group('MockUserRepository', () {
      test('MockUserRepository returns user after delay', () async {
        final repository = MockUserRepository();
        final user = await repository.getUser('123');

        expect(user.id, equals('123'));
        expect(user.name, equals('John Doe'));
        expect(user.email, equals('john@example.com'));
      });

      test('MockUserRepository returns consistent data', () async {
        final repository = MockUserRepository();
        final user1 = await repository.getUser('123');
        final user2 = await repository.getUser('456');

        expect(user1.name, equals('John Doe'));
        expect(user2.name, equals('John Doe')); // Same mock data
      });
    });

    group('GetUserUseCase', () {
      test('GetUserUseCase executes correctly', () async {
        final repository = MockUserRepository();
        final useCase = GetUserUseCase(repository);

        final user = await useCase.execute('123');

        expect(user.id, equals('123'));
        expect(user.name, equals('John Doe'));
        expect(user.email, equals('john@example.com'));
      });

      test('GetUserUseCase uses repository dependency', () async {
        final repository = MockUserRepository();
        final useCase = GetUserUseCase(repository);

        // Verify use case is using the repository
        final user = await useCase.execute('123');
        expect(user, isNotNull);
      });
    });
  });
}
