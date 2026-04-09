import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// STEP 7: Route Guards and Authentication

// ===== AUTHENTICATION SERVICE =====
class AuthService {
  static bool _isLoggedIn = false;
  static String? _currentUser;

  static bool get isLoggedIn => _isLoggedIn;
  static String? get currentUser => _currentUser;

  static void login(String username) {
    _isLoggedIn = true;
    _currentUser = username;
    print('User logged in: $username');
  }

  static void logout() {
    _isLoggedIn = false;
    _currentUser = null;
    print('User logged out');
  }

  static Future<bool> checkAuth() async {
    // Simulate auth check delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _isLoggedIn;
  }
}

// ===== ROUTE GUARD HELPERS =====
class RouteGuards {
  static Future<String?> redirectIfUnauthenticated(GoRouterState state) async {
    final isAuthenticated = await AuthService.checkAuth();

    // Redirect to login if not authenticated
    if (!isAuthenticated && !state.uri.path.startsWith('/login')) {
      return '/login?redirect=${state.uri.path}';
    }

    return null; // No redirect needed
  }

  static Future<String?> redirectIfAuthenticated(GoRouterState state) async {
    final isAuthenticated = await AuthService.checkAuth();

    // Redirect to home if already authenticated
    if (isAuthenticated && state.uri.path.startsWith('/login')) {
      final redirect = state.uri.queryParameters['redirect'] ?? '/';
      return redirect;
    }

    return null; // No redirect needed
  }
}

// ===== SCREENS =====
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Protected Home'),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.logout();
              context.go('/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome ${AuthService.currentUser ?? 'Guest'}!'),
            const SizedBox(height: 20),
            const Text('This is a protected route'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/profile'),
              child: const Text('View Profile'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go('/settings'),
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Protected Profile'),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.logout();
              context.go('/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Profile for ${AuthService.currentUser ?? 'Guest'}'),
            const SizedBox(height: 20),
            const Text('This route requires authentication'),
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
      appBar: AppBar(
        title: const Text('Protected Settings'),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.logout();
              context.go('/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Settings for ${AuthService.currentUser ?? 'Guest'}'),
            const SizedBox(height: 20),
            const Text('This route requires authentication'),
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
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login Screen'),
            const SizedBox(height: 20),
            const Text('Please log in to access protected routes'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simulate login
                AuthService.login('John Doe');

                // Get redirect parameter or go to home
                final redirect = GoRouterState.of(
                  context,
                ).uri.queryParameters['redirect'];
                context.go(redirect ?? '/');
              },
              child: const Text('Login as John Doe'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Simulate login
                AuthService.login('Jane Smith');

                // Get redirect parameter or go to home
                final redirect = GoRouterState.of(
                  context,
                ).uri.queryParameters['redirect'];
                context.go(redirect ?? '/');
              },
              child: const Text('Login as Jane Smith'),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== ROUTE GUARD CONFIGURATION =====
final guardedGoRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    // Check authentication for protected routes
    final authRedirect = await RouteGuards.redirectIfUnauthenticated(state);
    if (authRedirect != null) return authRedirect;

    // Check if already logged in on login page
    final loginRedirect = await RouteGuards.redirectIfAuthenticated(state);
    if (loginRedirect != null) return loginRedirect;

    return null; // No redirect needed
  },
  routes: [
    // Public routes
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),

    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),

    // Protected routes
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),

    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);

// ===== MAIN APP WITH ROUTE GUARDS =====
class RouteGuardApp extends StatelessWidget {
  const RouteGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Route Guards Demo',
      routerConfig: guardedGoRouter,
    );
  }
}

// ===== ROUTE GUARD CONCEPTS =====

/*
ROUTE GUARDS CONCEPTS:

1. AUTHENTICATION CHECK:
   - Check user auth status before route access
   - Redirect to login if not authenticated
   - Handle login redirect after successful auth

2. REDIRECT LOGIC:
   - redirect function in GoRouter
   - Returns new route path or null
   - Async authentication checks supported

3. GUARD PATTERNS:
   - redirectIfUnauthenticated: Protect routes
   - redirectIfAuthenticated: Handle login page
   - roleBasedRedirect: Role-based access

4. FLOW:
   User tries to access /profile
   → Guard checks authentication
   → If not authenticated → Redirect to /login?redirect=/profile
   → After login → Redirect to /profile

5. BENEFITS:
   ✅ Automatic protection of routes
   ✅ Centralized auth logic
   ✅ Seamless user experience
   ✅ Deep link protection
   ✅ Consistent behavior

REDIRECT EXAMPLES:
- /profile → /login?redirect=/profile
- /settings → /login?redirect=/settings
- /login?redirect=/profile → /profile (after login)

ADVANCED GUARDS:
- Role-based access
- Feature flags
- Maintenance mode
- Beta feature access
- Geographic restrictions

IMPLEMENTATION TIPS:
- Keep guards simple and fast
- Use async for real auth checks
- Handle edge cases (network errors)
- Provide clear feedback to users
*/
