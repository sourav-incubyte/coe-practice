import 'dart:async';
import 'package:solid_practice/principles/single_responsibility/violation.dart';
import 'package:solid_practice/principles/single_responsibility/correction.dart';
import 'package:solid_practice/principles/open_closed/violation.dart'
    as ocp_violation;
import 'package:solid_practice/principles/open_closed/correction.dart'
    as ocp_correction;
import 'package:solid_practice/principles/liskov_substitution/violation.dart'
    as lsp_violation;
import 'package:solid_practice/principles/liskov_substitution/correction.dart'
    as lsp_correction;
import 'package:solid_practice/principles/interface_segregation/violation.dart'
    as isp_violation;
import 'package:solid_practice/principles/interface_segregation/correction.dart'
    as isp_correction;
import 'package:solid_practice/principles/dependency_inversion/violation.dart'
    as dip_violation;
import 'package:solid_practice/principles/dependency_inversion/correction.dart'
    as dip_correction;

Future<void> main(List<String> arguments) async {
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
    'Fixed: Separated into User model, UserService, UserStatusService, Presenter, Controller\n',
  );

  print('3. Open-Closed Principle - Violation Example:');
  ocp_violation.main();
  print('Issues: Must modify existing classes to add new shapes\n');

  print('4. Open-Closed Principle - Correction Example:');
  ocp_correction.main();
  print('Fixed: Open for extension, closed for modification\n');

  print('5. Liskov Substitution Principle - Violation Example:');
  lsp_violation.main();
  print('Issues: Subtypes cannot be substituted without breaking behavior\n');

  print('6. Liskov Substitution Principle - Correction Example:');
  lsp_correction.main();
  print('Fixed: Proper abstractions enable safe substitution\n');

  print('7. Interface Segregation Principle - Violation Example:');
  isp_violation.main();
  print(
    'Issues: Fat interface forces clients to implement unnecessary methods\n',
  );

  print('8. Interface Segregation Principle - Correction Example:');
  isp_correction.main();
  print(
    'Fixed: Small, focused interfaces prevent unnecessary implementations\n',
  );

  print('9. Dependency Inversion Principle - Violation Example:');
  dip_violation.main();
  print('Issues: High-level modules depend on low-level modules\n');

  print('10. Dependency Inversion Principle - Correction Example:');
  dip_correction.main();
  print('Fixed: Both levels depend on abstractions');
}
