import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// STEP 4: go_router Package Basics

// ===== ROUTE DEFINITIONS =====
// Type-safe route paths
class AppRoutes {
  static const String home = '/';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String login = '/login';
}

// ===== SCREENS =====
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home - go_router')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('go_router Basics'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/profile/123'),
              child: const Text('Go to Profile 123'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go('/settings'),
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
      appBar: AppBar(title: Text('Profile $userId - go_router')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Profile ID: $userId'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/'),
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
      appBar: AppBar(title: const Text('Settings - go_router')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Settings Screen'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login - go_router')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login Screen'),
            SizedBox(height: 20),
            Text('Please log in to continue'),
          ],
        ),
      ),
    );
  }
}

// ===== GO_ROUTER CONFIGURATION =====
final goRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    // Home route
    GoRoute(
      path: AppRoutes.home,
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
    
    // Settings route
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    
    // Login route
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);

// ===== MAIN APP =====
class GoRouterApp extends StatelessWidget {
  const GoRouterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'go_router Demo',
      routerConfig: goRouter,
    );
  }
}

// ===== GO_ROUTER CONCEPTS =====

/*
GO_ROUTER BASICS:

1. ROUTE DEFINITION:
   - Use GoRoute with path and builder
   - Path parameters: /profile/:userId
   - Query parameters: /profile?id=123

2. NAVIGATION:
   - context.go('/path') - Replace current route
   - context.push('/path') - Add new route
   - context.pop() - Go back

3. PARAMETER EXTRACTION:
   - Path parameters: state.pathParameters['userId']
   - Query parameters: state.uri.queryParameters['id']

4. CONFIGURATION:
   - GoRouter with routes list
   - MaterialApp.router with routerConfig

5. BENEFITS OVER MANUAL 2.0:
   ✅ Simpler syntax
   ✅ Built-in parameter parsing
   ✅ Type safety with constants
   ✅ Better error handling
   ✅ Nested route support
   ✅ Route guards (redirects)

KEY DIFFERENCES:
- No need for RouteInformationParser
- No need for RouterDelegate
- Built-in parameter handling
- Cleaner route definitions
- Better TypeScript-like safety

USAGE EXAMPLES:
context.go('/profile/123')     // Navigate with path parameter
context.push('/settings')         // Push new route
context.pop()                    // Go back
context.goNamed('profile')       // If using named routes
*/
