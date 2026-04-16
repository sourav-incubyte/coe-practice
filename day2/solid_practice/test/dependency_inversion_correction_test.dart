import 'package:solid_practice/principles/dependency_inversion/correction.dart';
import 'package:test/test.dart';

void main() {
  group('Dependency Inversion Principle - Notification Senders', () {
    test('EmailSender implements INotificationSender', () {
      final emailSender = EmailSender();
      expect(emailSender, isA<INotificationSender>());
    });

    test('SmsSender implements INotificationSender', () {
      final smsSender = SmsSender();
      expect(smsSender, isA<INotificationSender>());
    });

    test('PushNotificationSender implements INotificationSender', () {
      final pushSender = PushNotificationSender();
      expect(pushSender, isA<INotificationSender>());
    });
  });

  group('Dependency Inversion Principle - NotificationService', () {
    test('NotificationService depends on abstraction', () {
      final emailSender = EmailSender();
      final smsSender = SmsSender();
      final pushSender = PushNotificationSender();

      final service = NotificationService(
        emailSender: emailSender,
        smsSender: smsSender,
        pushSender: pushSender,
      );

      expect(service, isNotNull);
    });

    test('NotificationService can send welcome notification', () {
      final emailSender = EmailSender();
      final smsSender = SmsSender();
      final pushSender = PushNotificationSender();

      final service = NotificationService(
        emailSender: emailSender,
        smsSender: smsSender,
        pushSender: pushSender,
      );

      service.sendWelcomeNotification('user@example.com');
      // Should not throw
    });

    test('NotificationService can send alert notification', () {
      final emailSender = EmailSender();
      final smsSender = SmsSender();
      final pushSender = PushNotificationSender();

      final service = NotificationService(
        emailSender: emailSender,
        smsSender: smsSender,
        pushSender: pushSender,
      );

      service.sendAlertNotification('+1234567890');
      // Should not throw
    });

    test('NotificationService can send promotion', () {
      final emailSender = EmailSender();
      final smsSender = SmsSender();
      final pushSender = PushNotificationSender();

      final service = NotificationService(
        emailSender: emailSender,
        smsSender: smsSender,
        pushSender: pushSender,
      );

      service.sendPromotion('user@example.com', '+1234567890');
      // Should not throw
    });

    test('NotificationService can send push notification', () {
      final emailSender = EmailSender();
      final smsSender = SmsSender();
      final pushSender = PushNotificationSender();

      final service = NotificationService(
        emailSender: emailSender,
        smsSender: smsSender,
        pushSender: pushSender,
      );

      service.sendPushNotification('device-token-123');
      // Should not throw
    });
  });

  group('Dependency Inversion Principle - Mock Implementation', () {
    test('MockNotificationSender implements INotificationSender', () {
      final mockSender = MockNotificationSender();
      expect(mockSender, isA<INotificationSender>());
    });

    test('MockNotificationSender tracks sent messages', () {
      final mockSender = MockNotificationSender();
      mockSender.send('test@example.com', 'Test message');

      expect(mockSender.sentMessages.length, 1);
      expect(mockSender.sentMessages[0], contains('test@example.com'));
      expect(mockSender.sentMessages[0], contains('Test message'));
    });

    test('NotificationService can use mock implementations', () {
      final mockEmailSender = MockNotificationSender();
      final mockSmsSender = MockNotificationSender();
      final mockPushSender = MockNotificationSender();

      final service = NotificationService(
        emailSender: mockEmailSender,
        smsSender: mockSmsSender,
        pushSender: mockPushSender,
      );

      service.sendWelcomeNotification('test@example.com');

      expect(mockEmailSender.sentMessages.length, 1);
      expect(mockSmsSender.sentMessages.length, 0);
      expect(mockPushSender.sentMessages.length, 0);
    });

    test('NotificationService can switch implementations easily', () {
      final emailSender = EmailSender();
      final mockSmsSender = MockNotificationSender();
      final pushSender = PushNotificationSender();

      final service = NotificationService(
        emailSender: emailSender,
        smsSender: mockSmsSender,
        pushSender: pushSender,
      );

      service.sendAlertNotification('+1234567890');

      expect(mockSmsSender.sentMessages.length, 1);
    });
  });

  group('Dependency Inversion Principle - Abstraction Dependency', () {
    test('High-level module depends on abstraction', () {
      // NotificationService is high-level module
      // It depends on INotificationSender abstraction
      // Not on concrete implementations

      final mockSender = MockNotificationSender();
      final service = NotificationService(
        emailSender: mockSender,
        smsSender: mockSender,
        pushSender: mockSender,
      );

      expect(service, isNotNull);
    });

    test('Low-level modules implement abstraction', () {
      // EmailSender, SmsSender, PushNotificationSender are low-level modules
      // They implement INotificationSender abstraction

      INotificationSender emailSender = EmailSender();
      INotificationSender smsSender = SmsSender();
      INotificationSender pushSender = PushNotificationSender();

      expect(emailSender, isA<INotificationSender>());
      expect(smsSender, isA<INotificationSender>());
      expect(pushSender, isA<INotificationSender>());
    });
  });
}
