import 'package:flutter_test/flutter_test.dart';

// Import step files for testing
import '../lib/step1_navigation_comparison.dart';

void main() {
  group('Navigation Practice Tests', () {
    testWidgets('Step 1: Navigator 1.0 vs 2.0 Comparison', (
      WidgetTester tester,
    ) async {
      // Test Navigator 1.0
      await tester.pumpWidget(Navigator1Example());
      expect(find.text('Navigator 1.0 - Home'), findsOneWidget);
      expect(find.text('This is Navigator 1.0 (Imperative)'), findsOneWidget);

      // Test navigation to profile
      await tester.tap(find.text('Go to Profile (1.0)'));
      await tester.pumpAndSettle();
      expect(find.text('Navigator 1.0 - Profile'), findsOneWidget);

      // Test Navigator 2.0
      await tester.pumpWidget(Navigator2Example());
      expect(find.text('Navigator 2.0 - Home'), findsOneWidget);
      expect(find.text('This is Navigator 2.0 (Declarative)'), findsOneWidget);

      // Test navigation to profile
      await tester.tap(find.text('Go to Profile (2.0)'));
      await tester.pumpAndSettle();
      expect(find.text('Navigator 2.0 - Profile'), findsOneWidget);

      // Test navigation back
      await tester.tap(find.text('Go Back (2.0)'));
      await tester.pumpAndSettle();
      expect(find.text('Navigator 2.0 - Home'), findsOneWidget);
    });
  });
}
