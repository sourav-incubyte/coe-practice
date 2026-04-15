// SRP CORRECTION: Separated responsibilities

// Data model - single responsibility
class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  // Single responsibility: data validation
  bool isValid() {
    return name.isNotEmpty && email.contains('@');
  }

  // Single responsibility: data formatting
  String toJson() {
    return '{"id": "$id", "name": "$name", "email": "$email"}';
  }
}

// Service layer - single responsibility for data operations
class UserService {
  // Single responsibility: data fetching
  Future<User> getUser(String id) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate API call
    return User(id: id, name: 'John Doe', email: 'john@example.com');
  }
}

// Business logic - single responsibility for status calculation
class UserStatusService {
  // Single responsibility: business rules
  static String calculateStatus(User user) {
    if (user.name.contains('John')) return 'VIP User';
    return 'Regular User';
  }
}

// UI layer - single responsibility for presentation
class UserProfilePresenter {
  // Single responsibility: UI formatting
  static String displayUser(User user, bool isLoading, String errorMessage) {
    if (isLoading) return 'Loading...';
    if (errorMessage.isNotEmpty) return errorMessage;

    final status = UserStatusService.calculateStatus(user);
    return 'Name: ${user.name}\nEmail: ${user.email}\nStatus: $status';
  }
}

// Controller - single responsibility for coordination
class UserProfileController {
  final UserService _userService = UserService();
  User? _user;
  bool _isLoading = false;
  String _errorMessage = '';

  // Single responsibility: state management
  Future<void> loadUser(String id) async {
    _isLoading = true;
    _errorMessage = '';

    try {
      _user = await _userService.getUser(id);
    } catch (e) {
      _errorMessage = 'Failed to load user: $e';
    } finally {
      _isLoading = false;
    }
  }

  // Single responsibility: state access
  String getDisplay() {
    if (_user == null) return 'No user loaded';
    return UserProfilePresenter.displayUser(_user!, _isLoading, _errorMessage);
  }
}
