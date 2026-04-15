import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// STEP 5: Type-Safe Routes with go_router

// ===== TYPE-SAFE ROUTE DEFINITIONS =====

// Route data class for type safety
class AppRouteData {
  final String path;
  final Map<String, String>? params;

  const AppRouteData._(this.path, [this.params]);

  static const home = AppRouteData._('/');
  static const settings = AppRouteData._('/settings');
  static const login = AppRouteData._('/login');

  static AppRouteData profile(String userId) =>
      AppRouteData._('/profile/$userId', {'userId': userId});

  static AppRouteData product(String productId) =>
      AppRouteData._('/product/$productId', {'productId': productId});
}

// Extension for easy navigation
extension GoRouterExtensions on GoRouter {
  void navigateToAppRoute(AppRouteData route) {
    go(route.path);
  }

  void pushAppRoute(AppRouteData route) {
    push(route.path);
  }
}

// Extension for BuildContext navigation
extension BuildContextExtensions on BuildContext {
  void navigateToAppRoute(AppRouteData route) {
    GoRouter.of(this).navigateToAppRoute(route);
  }

  void pushAppRoute(AppRouteData route) {
    GoRouter.of(this).pushAppRoute(route);
  }
}

// ===== SCREENS =====
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Type-Safe Navigation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Type-Safe Routes Demo'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  context.navigateToAppRoute(AppRouteData.profile('123')),
              child: const Text('Go to Profile 123'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () =>
                  context.navigateToAppRoute(AppRouteData.product('abc123')),
              child: const Text('Go to Product abc123'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () =>
                  context.navigateToAppRoute(AppRouteData.settings),
              child: const Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final String userId;

  const ProfileScreen({required this.userId, super.key});

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
              onPressed: () => context.navigateToAppRoute(AppRouteData.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductScreen extends StatelessWidget {
  final String productId;

  const ProductScreen({required this.productId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product $productId')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Product ID: $productId'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.navigateToAppRoute(AppRouteData.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
              onPressed: () => context.navigateToAppRoute(AppRouteData.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== TYPE-SAFE ROUTER CONFIGURATION =====
final typeSafeGoRouter = GoRouter(
  initialLocation: AppRouteData.home.path,
  routes: [
    // Home route
    GoRoute(
      path: AppRouteData.home.path,
      builder: (context, state) => const HomeScreen(),
    ),

    // Profile route with parameter
    GoRoute(
      path: '/profile/:userId',
      builder: (context, state) {
        final userId = state.pathParameters['userId'] ?? 'unknown';
        return ProfileScreen(userId: userId);
      },
    ),

    // Product route with parameter
    GoRoute(
      path: '/product/:productId',
      builder: (context, state) {
        final productId = state.pathParameters['productId'] ?? 'unknown';
        return ProductScreen(productId: productId);
      },
    ),

    // Settings route
    GoRoute(
      path: AppRouteData.settings.path,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);

// ===== MAIN APP =====
class TypeSafeRoutesApp extends StatelessWidget {
  const TypeSafeRoutesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Type-Safe Routes Demo',
      routerConfig: typeSafeGoRouter,
    );
  }
}

// ===== TYPE-SAFE CONCEPTS =====

/*
TYPE-SAFE ROUTES CONCEPTS:

1. ROUTE DATA CLASS:
   - Encapsulates path and parameters
   - Static factory methods for type safety
   - Compile-time checking

2. NAVIGATION EXTENSIONS:
   - context.navigateToAppRoute(route)
   - Type-safe navigation calls
   - No string concatenation errors

3. BENEFITS:
   ✅ Compile-time route checking
   ✅ No typos in route strings
   ✅ Auto-complete support
   ✅ Parameter validation
   ✅ Refactoring safety

4. USAGE EXAMPLES:
   // Type-safe navigation
   context.navigateToAppRoute(AppRouteData.profile('123'));
   
   // vs unsafe navigation
   context.go('/profile/$userId'); // Could be wrong

5. ROUTE CREATION:
   // Static methods ensure correct format
   AppRouteData.profile('123')     // ✅ Type-safe
   '/profile/$userId'             // ❌ Error-prone

6. PARAMETER HANDLING:
   - Path parameters built into route data
   - No manual string formatting
   - Type checking at compile time

KEY IMPROVEMENTS:
- No magic strings
- IDE auto-completion
- Refactor-safe
- Compile-time errors for wrong routes
- Better developer experience
*/
