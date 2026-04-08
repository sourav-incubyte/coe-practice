// DIP CORRECTION: Both high-level and low-level modules depend on abstractions

// Abstraction (interface) for notification
abstract class INotificationSender {
  void send(String recipient, String message);
}

// Low-level module implementing the abstraction
class EmailSender implements INotificationSender {
  @override
  void send(String recipient, String message) {
    print('Sending email to: $recipient');
    print('Message: $message');
    print('Email sent successfully!');
  }
}

// Low-level module implementing the abstraction
class SmsSender implements INotificationSender {
  @override
  void send(String recipient, String message) {
    print('Sending SMS to: $recipient');
    print('Message: $message');
    print('SMS sent successfully!');
  }
}

// Low-level module implementing the abstraction
class PushNotificationSender implements INotificationSender {
  @override
  void send(String recipient, String message) {
    print('Sending push notification to: $recipient');
    print('Message: $message');
    print('Push notification sent successfully!');
  }
}

// CORRECTION: High-level module depends on abstraction, not concrete classes
class NotificationService {
  final INotificationSender _emailSender;
  final INotificationSender _smsSender;
  final INotificationSender _pushSender;

  // Dependency injection through constructor
  NotificationService({
    required INotificationSender emailSender,
    required INotificationSender smsSender,
    required INotificationSender pushSender,
  }) : _emailSender = emailSender,
       _smsSender = smsSender,
       _pushSender = pushSender;

  void sendWelcomeNotification(String userEmail) {
    _emailSender.send(userEmail, 'Welcome! Welcome to our platform!');
  }

  void sendAlertNotification(String userPhone) {
    _smsSender.send(userPhone, 'Security alert: New login detected');
  }

  void sendPromotion(String userEmail, String userPhone) {
    _emailSender.send(
      userEmail,
      'Special Offer! Check out our latest promotions!',
    );
    _smsSender.send(userPhone, 'Special offer just for you!');
  }

  void sendPushNotification(String deviceToken) {
    _pushSender.send(deviceToken, 'You have a new message!');
  }
}

// Mock implementation for testing
class MockNotificationSender implements INotificationSender {
  final List<String> sentMessages = [];

  @override
  void send(String recipient, String message) {
    sentMessages.add('To: $recipient, Message: $message');
    print('Mock: Would send to $recipient: $message');
  }
}

// Usage example showing DIP compliance
void main() {
  print('=== Dependency Inversion Principle Correction ===');

  print('\n--- Real Implementation ---');
  // Create concrete implementations
  final emailSender = EmailSender();
  final smsSender = SmsSender();
  final pushSender = PushNotificationSender();

  // Inject dependencies
  final notificationService = NotificationService(
    emailSender: emailSender,
    smsSender: smsSender,
    pushSender: pushSender,
  );

  // Use service
  notificationService.sendWelcomeNotification('user@example.com');
  notificationService.sendAlertNotification('+1234567890');

  print('\n--- Easy to Switch Implementations ---');
  // Can easily switch to different implementations
  final testEmailSender = MockNotificationSender();
  final testNotificationService2 = NotificationService(
    emailSender: testEmailSender,
    smsSender: smsSender,
    pushSender: pushSender,
  );

  testNotificationService2.sendWelcomeNotification('test@example.com');

  print('\n--- Easy to Test with Mocks ---');
  final mockEmailSender = MockNotificationSender();
  final mockSmsSender = MockNotificationSender();
  final mockPushSender = MockNotificationSender();

  final testNotificationService = NotificationService(
    emailSender: mockEmailSender,
    smsSender: mockSmsSender,
    pushSender: mockPushSender,
  );

  // Test with mocks
  testNotificationService.sendWelcomeNotification('test@example.com');

  print('\nSOLUTION:');
  print('1. High-level modules depend on abstractions');
  print('2. Low-level modules implement abstractions');
  print('3. Dependencies injected through constructor');
  print('4. Easy to test with mock implementations');
  print('5. Easy to switch implementations');
  print('DIP FIXED: Both levels depend on abstractions');
}
