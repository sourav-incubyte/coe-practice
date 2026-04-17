import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_patterns/flutter_test_patterns.dart';
import 'package:navigation_practice/step1_navigation_comparison.dart' as step1;
import 'package:navigation_practice/step2_declarative_routing.dart' as step2;
import 'package:navigation_practice/step3_migration_exercise.dart' as step3;
import 'package:navigation_practice/step4_go_router_basics.dart' as step4;
import 'package:navigation_practice/step5_type_safe_routes.dart' as step5;
import 'package:navigation_practice/step6_deep_links.dart' as step6;
import 'package:navigation_practice/step7_route_guards.dart' as step7;
import 'package:navigation_practice/step9_edge_cases.dart' as step9;

void main() {
  group('Navigator Comparison - Step 1', () {
    testWidgets('Navigator 1.0 golden variants', (tester) async {
      await goldenVariants(
        tester,
        'navigator_1_0',
        variants: {
          'home': () => step1.Navigator1Example(),
          'profile': () => MaterialApp(home: step1.ProfileScreen1()),
        },
      );
    });

    testWidgets('Navigator 2.0 golden variants', (tester) async {
      await goldenVariants(
        tester,
        'navigator_2_0',
        variants: {
          'home': () => step1.Navigator2Example(),
          'profile': () => MaterialApp(home: step1.ProfileScreen2()),
        },
      );
    });

    test('AppRoute creates correct paths', () {
      final homeRoute = step1.AppRoute.home();
      final profileRoute = step1.AppRoute.profile();
      expect(homeRoute.location, equals('/home'));
      expect(profileRoute.location, equals('/profile'));
    });
  });

  group('Declarative Routing - Step 2', () {
    testWidgets('Declarative routing golden variants', (tester) async {
      await goldenVariants(
        tester,
        'declarative_routing',
        variants: {
          'home': () => MaterialApp(
            home: step2.HomeScreen(
              onNavigateToProfile: (_) {},
              onNavigateToSettings: () {},
            ),
          ),
          'profile': () => MaterialApp(
            home: step2.ProfileScreen(userId: '123', onGoBack: () {}),
          ),
          'settings': () =>
              MaterialApp(home: step2.SettingsScreen(onGoBack: () {})),
          'notFound': () =>
              MaterialApp(home: step2.NotFoundScreen(onGoHome: () {})),
        },
      );
    });

    test('AppRoute creates correct paths', () {
      final homeRoute = step2.AppRoute.home();
      final settingsRoute = step2.AppRoute.settings();
      final unknownRoute = step2.AppRoute.unknown();
      final profileRoute = step2.AppRoute.profile('123');
      expect(homeRoute.location, equals('/home'));
      expect(settingsRoute.location, equals('/settings'));
      expect(unknownRoute.location, equals('/404'));
      expect(profileRoute.location, equals('/profile'));
    });
  });

  group('Migration Exercise - Step 3', () {
    testWidgets('Original app golden variants', (tester) async {
      await goldenVariants(
        tester,
        'original_app',
        variants: {
          'home': () => step3.OriginalApp(),
          'profile': () =>
              MaterialApp(home: step3.OriginalProfileScreen(userId: '123')),
          'settings': () => MaterialApp(home: step3.OriginalSettingsScreen()),
        },
      );
    });

    testWidgets('Migrated app golden variants', (tester) async {
      await goldenVariants(
        tester,
        'migrated_app',
        variants: {
          'home': () => step3.MigratedApp(),
          'profile': () =>
              MaterialApp(home: step3.MigratedProfileScreen(userId: '123')),
          'settings': () => MaterialApp(home: step3.MigratedSettingsScreen()),
        },
      );
    });

    test('AppRoutes constants are defined', () {
      expect(step3.AppRoutes.home, equals('/'));
      expect(step3.AppRoutes.profile, equals('/profile'));
      expect(step3.AppRoutes.settings, equals('/settings'));
    });
  });

  group('Deep Links - Step 6', () {
    testWidgets('Deep link app golden variants', (tester) async {
      await goldenVariants(
        tester,
        'deep_links',
        variants: {
          'home': () => const step6.DeepLinkApp(),
          'profile': () =>
              MaterialApp(home: const step6.ProfileScreen(userId: '123')),
          'product': () =>
              MaterialApp(home: const step6.ProductScreen(productId: 'abc123')),
          'share': () => MaterialApp(
            home: const step6.ShareScreen(type: 'profile', id: '456'),
          ),
        },
      );
    });

    test('DeepLinkRoutes constants are defined', () {
      expect(step6.DeepLinkRoutes.home, equals('/'));
      expect(step6.DeepLinkRoutes.profile, equals('/profile/:userId'));
      expect(step6.DeepLinkRoutes.product, equals('/product/:productId'));
      expect(step6.DeepLinkRoutes.share, equals('/share/:type/:id'));
    });
  });

  group('Route Guards - Step 7', () {
    test('AuthService initial state', () {
      expect(step7.AuthService.isLoggedIn, isFalse);
      expect(step7.AuthService.currentUser, isNull);
    });

    test('AuthService login and logout', () {
      step7.AuthService.login('testuser');
      expect(step7.AuthService.isLoggedIn, isTrue);
      expect(step7.AuthService.currentUser, equals('testuser'));

      step7.AuthService.logout();
      expect(step7.AuthService.isLoggedIn, isFalse);
      expect(step7.AuthService.currentUser, isNull);
    });
  });

  group('Edge Cases - Step 9', () {
    testWidgets('Edge case app golden variants', (tester) async {
      await goldenVariants(
        tester,
        'edge_cases',
        variants: {
          'home': () => const step9.EdgeCaseApp(),
          'profile': () =>
              MaterialApp(home: const step9.ProfileScreen(userId: '123')),
          'profile_empty': () =>
              MaterialApp(home: const step9.ProfileScreen(userId: '')),
          'settings': () => MaterialApp(home: const step9.SettingsScreen()),
          'notFound': () => MaterialApp(
            home: const step9.NotFoundScreen(attemptedRoute: '/invalid'),
          ),
        },
      );
    });

    test('EdgeCaseRoutes constants are defined', () {
      expect(step9.EdgeCaseRoutes.home, equals('/'));
      expect(step9.EdgeCaseRoutes.profile, equals('/profile/:userId'));
      expect(step9.EdgeCaseRoutes.settings, equals('/settings'));
      expect(step9.EdgeCaseRoutes.notFound, equals('/404'));
    });

    test('NavigationErrorHandler validates user IDs', () {
      expect(step9.NavigationErrorHandler.isValidUserId('123'), isTrue);
      expect(step9.NavigationErrorHandler.isValidUserId(''), isFalse);
      expect(step9.NavigationErrorHandler.isValidUserId('a' * 51), isFalse);
      expect(step9.NavigationErrorHandler.isValidUserId('test<'), isFalse);
    });

    test('NavigationErrorHandler handles invalid routes', () {
      expect(
        step9.NavigationErrorHandler.handleInvalidRoute(''),
        equals('/404?error=empty'),
      );
      expect(
        step9.NavigationErrorHandler.handleInvalidRoute('../test'),
        equals('/404?error=invalid'),
      );
      expect(
        step9.NavigationErrorHandler.handleInvalidRoute('a' * 101),
        equals('/404?error=too_long'),
      );
      expect(step9.NavigationErrorHandler.handleInvalidRoute('/valid'), isNull);
    });
  });

  group('Go Router Basics - Step 4', () {
    testWidgets('Go Router golden variants', (tester) async {
      await goldenVariants(
        tester,
        'go_router',
        variants: {
          'home': () => MaterialApp(home: const step4.HomeScreen()),
          'profile': () =>
              MaterialApp(home: const step4.ProfileScreen(userId: '123')),
          'settings': () => MaterialApp(home: const step4.SettingsScreen()),
          'login': () => MaterialApp(home: const step4.LoginScreen()),
        },
      );
    });

    testWidgets('HomeScreen renders correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(home: const step4.HomeScreen()));

      expect(find.text('go_router Basics'), findsOneWidget);
      expect(find.text('Go to Profile 123'), findsOneWidget);
      expect(find.text('Go to Settings'), findsOneWidget);
    });

    testWidgets('ProfileScreen renders with userId', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: const step4.ProfileScreen(userId: '123')),
      );

      expect(find.text('Profile 123 - go_router'), findsOneWidget);
      expect(find.text('Profile ID: 123'), findsOneWidget);
      expect(find.text('Go Home'), findsOneWidget);
    });

    testWidgets('SettingsScreen renders correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(home: const step4.SettingsScreen()));

      expect(find.text('Settings - go_router'), findsOneWidget);
      expect(find.text('Settings Screen'), findsOneWidget);
      expect(find.text('Go Home'), findsOneWidget);
    });

    testWidgets('LoginScreen renders correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(home: const step4.LoginScreen()));

      expect(find.text('Login - go_router'), findsOneWidget);
      expect(find.text('Login Screen'), findsOneWidget);
      expect(find.text('Please log in to continue'), findsOneWidget);
    });
  });

  group('Type-Safe Routes - Step 5', () {
    test('AppRouteData creates correct paths', () {
      expect(step5.AppRouteData.home.path, equals('/'));
      expect(step5.AppRouteData.settings.path, equals('/settings'));
      expect(step5.AppRouteData.login.path, equals('/login'));
      expect(step5.AppRouteData.profile('123').path, equals('/profile/123'));
      expect(
        step5.AppRouteData.product('abc123').path,
        equals('/product/abc123'),
      );
    });

    testWidgets('Type-Safe Routes golden variants', (tester) async {
      await goldenVariants(
        tester,
        'type_safe_routes',
        variants: {
          'home': () => MaterialApp(home: const step5.HomeScreen()),
          'profile': () =>
              MaterialApp(home: const step5.ProfileScreen(userId: '123')),
          'product': () =>
              MaterialApp(home: const step5.ProductScreen(productId: 'abc123')),
          'settings': () => MaterialApp(home: const step5.SettingsScreen()),
        },
      );
    });

    testWidgets('HomeScreen renders correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(home: const step5.HomeScreen()));

      expect(find.text('Type-Safe Navigation'), findsOneWidget);
      expect(find.text('Type-Safe Routes Demo'), findsOneWidget);
      expect(find.text('Go to Profile 123'), findsOneWidget);
      expect(find.text('Go to Product abc123'), findsOneWidget);
      expect(find.text('Go to Settings'), findsOneWidget);
    });

    testWidgets('ProfileScreen renders with userId', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: const step5.ProfileScreen(userId: '123')),
      );

      expect(find.text('Profile 123'), findsOneWidget);
      expect(find.text('Profile ID: 123'), findsOneWidget);
      expect(find.text('Go Home'), findsOneWidget);
    });

    testWidgets('ProductScreen renders with productId', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: const step5.ProductScreen(productId: 'abc123')),
      );

      expect(find.text('Product abc123'), findsOneWidget);
      expect(find.text('Product ID: abc123'), findsOneWidget);
      expect(find.text('Go Home'), findsOneWidget);
    });

    testWidgets('SettingsScreen renders correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(home: const step5.SettingsScreen()));

      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Settings Screen'), findsOneWidget);
      expect(find.text('Go Home'), findsOneWidget);
    });
  });
}
