import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

// STEP 8: Navigation Testing Strategies

// ===== SIMPLE NAVIGATION APP FOR TESTING =====
class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Navigation Testing',
      routerConfig: testGoRouter,
    );
  }
}

class TestHomeScreen extends StatelessWidget {
  const TestHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Navigation Testing'),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key('profile_button'),
              onPressed: () => context.go('/profile/123'),
              child: const Text('Go to Profile'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              key: const Key('settings_button'),
              onPressed: () => context.go('/settings'),
              child: const Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class TestProfileScreen extends StatelessWidget {
  final String userId;

  const TestProfileScreen({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile $userId')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Profile ID: $userId'),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key('back_button'),
              onPressed: () => context.go('/'),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class TestSettingsScreen extends StatelessWidget {
  const TestSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Settings Screen'),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key('home_button'),
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== ROUTER CONFIGURATION =====
final testGoRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const TestHomeScreen()),
    GoRoute(
      path: '/profile/:userId',
      builder: (context, state) {
        final userId = state.pathParameters['userId'] ?? 'unknown';
        return TestProfileScreen(userId: userId);
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const TestSettingsScreen(),
    ),
  ],
);

// ===== NAVIGATION TESTS =====
void main() {
  group('Navigation Tests', () {
    testWidgets('Home screen displays correctly', (WidgetTester tester) async {
      // Build the app
      await tester.pumpWidget(const TestApp());

      // Verify home screen is displayed
      expect(find.text('Navigation Testing'), findsOneWidget);
      expect(find.text('Test Home'), findsOneWidget);
      expect(find.byKey(const Key('profile_button')), findsOneWidget);
      expect(find.byKey(const Key('settings_button')), findsOneWidget);
    });

    testWidgets('Navigate to profile screen', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp());

      // Tap profile button
      await tester.tap(find.byKey(const Key('profile_button')));
      await tester.pumpAndSettle();

      // Verify profile screen is displayed
      expect(find.text('Profile 123'), findsOneWidget);
      expect(find.byKey(const Key('back_button')), findsOneWidget);
      expect(find.text('Profile ID: 123'), findsOneWidget);
    });

    testWidgets('Navigate to settings screen', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp());

      // Tap settings button
      await tester.tap(find.byKey(const Key('settings_button')));
      await tester.pumpAndSettle();

      // Verify settings screen is displayed
      expect(find.text('Settings'), findsOneWidget);
      expect(find.byKey(const Key('home_button')), findsOneWidget);
      expect(find.text('Settings Screen'), findsOneWidget);
    });

    testWidgets('Navigate back from profile to home', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const TestApp());

      // Navigate to profile first
      await tester.tap(find.byKey(const Key('profile_button')));
      await tester.pumpAndSettle();

      // Verify profile screen
      expect(find.text('Profile 123'), findsOneWidget);

      // Tap back button
      await tester.tap(find.byKey(const Key('back_button')));
      await tester.pumpAndSettle();

      // Verify back to home
      expect(find.text('Navigation Testing'), findsOneWidget);
      expect(find.byKey(const Key('profile_button')), findsOneWidget);
    });

    testWidgets('Navigate with different user IDs', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const TestApp());

      // Navigate to different profiles
      for (final userId in ['123', '456', '789']) {
        // Use go_router directly for testing
        GoRouter.of(
          tester.element(find.byType(TestApp)),
        ).go('/profile/$userId');
        await tester.pumpAndSettle();

        // Verify correct profile
        expect(find.text('Profile $userId'), findsOneWidget);
        expect(find.text('Profile ID: $userId'), findsOneWidget);
      }
    });

    testWidgets('URL changes correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp());

      // Get router
      final router = GoRouter.of(tester.element(find.byType(TestApp)));

      // Initial URL
      expect(router.routeInformationProvider.value.location, equals('/'));

      // Navigate to profile
      await tester.tap(find.byKey(const Key('profile_button')));
      await tester.pumpAndSettle();

      // URL should be updated
      expect(
        router.routeInformationProvider.value.location,
        equals('/profile/123'),
      );

      // Navigate to settings
      await tester.tap(find.byKey(const Key('settings_button')));
      await tester.pumpAndSettle();

      // URL should be updated
      expect(
        router.routeInformationProvider.value.location,
        equals('/settings'),
      );
    });
  });

  group('Navigation Edge Cases', () {
    testWidgets('Handle invalid route gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp());

      // Try to navigate to invalid route
      GoRouter.of(tester.element(find.byType(TestApp))).go('/invalid-route');
      await tester.pumpAndSettle();

      // Should stay on current route (home)
      expect(find.text('Navigation Testing'), findsOneWidget);
    });

    testWidgets('Handle back button correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp());

      // Navigate to profile
      await tester.tap(find.byKey(const Key('profile_button')));
      await tester.pumpAndSettle();

      expect(find.text('Profile 123'), findsOneWidget);

      // Simulate back button
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Should go back to home
      expect(find.text('Navigation Testing'), findsOneWidget);
    });
  });

  group('Navigation Performance', () {
    testWidgets('Navigation completes within reasonable time', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const TestApp());

      final stopwatch = Stopwatch()..start();

      // Navigate multiple routes
      await tester.tap(find.byKey(const Key('profile_button')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('back_button')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('settings_button')));
      await tester.pumpAndSettle();

      stopwatch.stop();

      // Navigation should complete quickly
      expect(stopwatch.elapsedMilliseconds, lessThan(1000));
    });
  });
}

// ===== TESTING CONCEPTS =====

/*
NAVIGATION TESTING STRATEGIES:

1. WIDGET TESTING:
   - Use testWidgets for navigation tests
   - pumpWidget() to render app
   - tap() to simulate user interactions
   - pumpAndSettle() to wait for navigation

2. NAVIGATION VERIFICATION:
   - Check for expected screen content
   - Verify route parameters are correct
   - Test URL changes
   - Validate button states

3. EDGE CASE TESTING:
   - Invalid routes
   - Back button behavior
   - Rapid navigation
   - Deep link handling

4. PERFORMANCE TESTING:
   - Navigation timing
   - Memory usage
   - Animation performance
   - Route building overhead

5. TESTING PATTERNS:

   BASIC NAVIGATION:
   await tester.tap(find.byKey('button_key'));
   await tester.pumpAndSettle();
   expect(find.text('Expected Text'), findsOneWidget);

   ROUTER STATE TESTING:
   final router = GoRouter.of(context);
   expect(router.routeInformationProvider.value.location, equals('/expected'));

   PARAMETER TESTING:
   GoRouter.of(context).go('/profile/123');
   expect(find.text('Profile 123'), findsOneWidget);

6. BEST PRACTICES:
   ✅ Use unique keys for navigation elements
   ✅ Test both forward and back navigation
   ✅ Verify route parameters
   ✅ Test edge cases
   ✅ Check performance
   ✅ Mock navigation dependencies

7. COMMON TEST CASES:
   - Navigate to each route
   - Navigate with parameters
   - Go back from each route
   - Handle invalid routes
   - Test deep links
   - Verify URL updates

8. ADVANCED TESTING:
   - Integration tests with real navigation
   - Mock authentication for protected routes
   - Test route guards
   - Performance benchmarking
   - Accessibility testing

TESTING TOOLS:
- flutter_test: Widget testing
- integration_test: Full app testing
- go_router_test: Router-specific testing
- golden tests: Visual regression testing

KEY POINTS:
- Test navigation flows, not just screens
- Verify both UI and route state
- Test user interactions and edge cases
- Ensure navigation is fast and reliable
*/
