import 'dart:async';
import 'package:solid_practice/principles/single_responsibility/violation.dart';
import 'package:solid_practice/principles/single_responsibility/correction.dart';

Future<void> main() async {
  print('=== SOLID Principles Practice ===\n');

  print('1. Single Responsibility Principle - Violation Example:');
  final violationWidget = UserProfileWidget();
  violationWidget.loadUser('123');

  // Wait for the async operation to complete
  await Future.delayed(Duration(seconds: 2));
  print(violationWidget.displayUser());
  print(
    'Issues: Widget handles data fetching, business logic, UI, validation, formatting\n',
  );

  print('2. Single Responsibility Principle - Correction Example:');
  final controller = UserProfileController();
  await controller.loadUser('123');
  print(controller.getDisplay());
  print(
    'Fixed: Separated into User model, UserService, UserStatusService, Presenter, Controller',
  );
}
