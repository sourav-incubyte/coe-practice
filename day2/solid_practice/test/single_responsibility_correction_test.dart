import 'package:solid_practice/principles/single_responsibility/correction.dart';
import 'package:test/test.dart';

void main() {
  group('Single Responsibility Principle - User', () {
    test('User should validate correctly', () {
      final user = User(id: '1', name: 'John Doe', email: 'john@example.com');
      expect(user.isValid(), true);
    });

    test('User should fail validation with empty name', () {
      final user = User(id: '1', name: '', email: 'john@example.com');
      expect(user.isValid(), false);
    });

    test('User should fail validation with invalid email', () {
      final user = User(id: '1', name: 'John Doe', email: 'invalid-email');
      expect(user.isValid(), false);
    });

    test('User should convert to JSON correctly', () {
      final user = User(id: '1', name: 'John Doe', email: 'john@example.com');
      final json = user.toJson();
      expect(
        json,
        '{"id": "1", "name": "John Doe", "email": "john@example.com"}',
      );
    });
  });

  group('Single Responsibility Principle - UserService', () {
    test('UserService should fetch user data', () async {
      final service = UserService();
      final user = await service.getUser('1');
      expect(user.id, '1');
      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
    });
  });

  group('Single Responsibility Principle - UserStatusService', () {
    test('UserStatusService should calculate VIP status for John', () {
      final user = User(id: '1', name: 'John Doe', email: 'john@example.com');
      final status = UserStatusService.calculateStatus(user);
      expect(status, 'VIP User');
    });

    test('UserStatusService should calculate regular status for non-John', () {
      final user = User(id: '1', name: 'Jane Doe', email: 'jane@example.com');
      final status = UserStatusService.calculateStatus(user);
      expect(status, 'Regular User');
    });
  });

  group('Single Responsibility Principle - UserProfilePresenter', () {
    test('UserProfilePresenter should display loading state', () {
      final user = User(id: '1', name: 'John Doe', email: 'john@example.com');
      final display = UserProfilePresenter.displayUser(user, true, '');
      expect(display, 'Loading...');
    });

    test('UserProfilePresenter should display error message', () {
      final user = User(id: '1', name: 'John Doe', email: 'john@example.com');
      final display = UserProfilePresenter.displayUser(
        user,
        false,
        'Error loading',
      );
      expect(display, 'Error loading');
    });

    test('UserProfilePresenter should display user info', () {
      final user = User(id: '1', name: 'John Doe', email: 'john@example.com');
      final display = UserProfilePresenter.displayUser(user, false, '');
      expect(display, contains('Name: John Doe'));
      expect(display, contains('Email: john@example.com'));
      expect(display, contains('Status: VIP User'));
    });
  });

  group('Single Responsibility Principle - UserProfileController', () {
    test('UserProfileController should load user successfully', () async {
      final controller = UserProfileController();
      await controller.loadUser('1');
      final display = controller.getDisplay();
      expect(display, contains('Name: John Doe'));
    });

    test('UserProfileController should show no user before loading', () {
      final controller = UserProfileController();
      final display = controller.getDisplay();
      expect(display, 'No user loaded');
    });
  });
}
