import 'package:flutter/material.dart';

// Import all step files we use
import 'step1_navigation_comparison.dart';
import 'step2_declarative_routing.dart';
import 'step3_migration_exercise.dart';
import 'step4_go_router_basics.dart';
import 'step5_type_safe_routes.dart';
import 'step6_deep_links.dart';
import 'step7_route_guards.dart';
import 'step8_navigation_testing.dart';
import 'step9_edge_cases.dart';

void main() {
  // Get step from environment variable or command line
  const step = String.fromEnvironment('step', defaultValue: '1');

  print('Running Step $step: Navigation 2.0 & Deep Linking');

  Widget app;

  switch (step) {
    case '1':
      app = const Step1App();
      break;
    case '2':
      app = const Step2App();
      break;
    case '3':
      app = const Step3App();
      break;
    case '4':
      app = const Step4App();
      break;
    case '5':
      app = const Step5App();
      break;
    case '6':
      app = const Step6App();
      break;
    case '7':
      app = const Step7App();
      break;
    case '8':
      app = const Step8App();
      break;
    case '9':
      app = const Step9App();
      break;
    default:
      app = const Step1App(); // Default to step 1
  }

  runApp(app);
}

// Step wrapper apps - use original implementations
class Step1App extends StatelessWidget {
  const Step1App({super.key});
  @override
  Widget build(BuildContext context) => Navigator1Example();
}

class Step2App extends StatelessWidget {
  const Step2App({super.key});
  @override
  Widget build(BuildContext context) => DeclarativeRoutingApp();
}

class Step3App extends StatelessWidget {
  const Step3App({super.key});
  @override
  Widget build(BuildContext context) => MigratedApp();
}

class Step4App extends StatelessWidget {
  const Step4App({super.key});
  @override
  Widget build(BuildContext context) => const GoRouterApp();
}

class Step5App extends StatelessWidget {
  const Step5App({super.key});
  @override
  Widget build(BuildContext context) => const TypeSafeRoutesApp();
}

class Step6App extends StatelessWidget {
  const Step6App({super.key});
  @override
  Widget build(BuildContext context) => const DeepLinkApp();
}

class Step7App extends StatelessWidget {
  const Step7App({super.key});
  @override
  Widget build(BuildContext context) => const RouteGuardApp();
}

class Step8App extends StatelessWidget {
  const Step8App({super.key});
  @override
  Widget build(BuildContext context) => const TestApp();
}

class Step9App extends StatelessWidget {
  const Step9App({super.key});
  @override
  Widget build(BuildContext context) => const EdgeCaseApp();
}
