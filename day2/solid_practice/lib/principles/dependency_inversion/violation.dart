// DIP VIOLATION: High-level module depends on low-level module

// Low-level module
class EmailSender {
  void sendEmail(String to, String subject, String body) {
    print('Sending email to: $to');
    print('Subject: $subject');
    print('Body: $body');
    print('Email sent successfully!');
  }
}

// Low-level module
class SmsSender {
  void sendSms(String to, String message) {
    print('Sending SMS to: $to');
    print('Message: $message');
    print('SMS sent successfully!');
  }
}

// VIOLATION: High-level NotificationService depends on concrete implementations
class NotificationService {
  final EmailSender _emailSender = EmailSender();
  final SmsSender _smsSender = SmsSender();

  void sendWelcomeEmail(String userEmail) {
    _emailSender.sendEmail(userEmail, 'Welcome!', 'Welcome to our platform!');
  }

  void sendAlertSms(String userPhone) {
    _smsSender.sendSms(userPhone, 'Security alert: New login detected');
  }

  void sendPromotion(String userEmail, String userPhone) {
    _emailSender.sendEmail(
      userEmail,
      'Special Offer!',
      'Check out our latest promotions!',
    );
    _smsSender.sendSms(userPhone, 'Special offer just for you!');
  }
}

// Usage example showing DIP violations
void main() {
  print('=== Dependency Inversion Principle Violation ===');

  final notificationService = NotificationService();
  notificationService.sendWelcomeEmail('user@example.com');
  notificationService.sendAlertSms('+1234567890');

  print('\nPROBLEMS:');
  print('1. NotificationService tightly coupled to EmailSender and SmsSender');
  print('2. Hard to test - cannot mock dependencies');
  print('3. Hard to change implementations - requires code changes');
  print('DIP VIOLATION: High-level modules depend on low-level modules');
}
