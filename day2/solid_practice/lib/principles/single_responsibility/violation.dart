// SRP VIOLATION: Widget doing too much
class UserProfileWidget {
  String? userId;
  String? userName;
  String? userEmail;
  bool isLoading = false;
  String errorMessage = '';

  // VIOLATION: Data fetching logic
  void loadUser(String id) {
    isLoading = true;
    try {
      // Simulate API call
      Future.delayed(Duration(seconds: 1), () {
        userId = id;
        userName = 'John Doe';
        userEmail = 'john@example.com';
        isLoading = false;
      });
    } catch (e) {
      errorMessage = 'Failed to load user';
      isLoading = false;
    }
  }

  // VIOLATION: Business logic
  String getUserStatus() {
    if (userName == null) return 'Unknown';
    if (userName!.contains('John')) return 'VIP User';
    return 'Regular User';
  }

  // VIOLATION: UI rendering logic
  String displayUser() {
    if (isLoading) return 'Loading...';
    if (errorMessage.isNotEmpty) return errorMessage;
    return 'Name: $userName\nEmail: $userEmail\nStatus: ${getUserStatus()}';
  }

  // VIOLATION: Data validation
  bool validateUser() {
    return userName != null && 
           userName!.isNotEmpty && 
           userEmail != null && 
           userEmail!.contains('@');
  }

  // VIOLATION: Data formatting
  String formatUserData() {
    return '{"id": "$userId", "name": "$userName", "email": "$userEmail"}';
  }
}
