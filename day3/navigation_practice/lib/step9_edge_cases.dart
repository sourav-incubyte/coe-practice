import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// STEP 9: Handling Navigation Edge Cases

// ===== EDGE CASE HANDLING =====
class EdgeCaseRoutes {
  static const String home = '/';
  static const String profile = '/profile/:userId';
  static const String settings = '/settings';
  static const String notFound = '/404';
}

// ===== SCREENS =====
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edge Cases Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Navigation Edge Cases'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/profile/123'),
              child: const Text('Valid Profile'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go('/profile/'),
              child: const Text('Empty Profile ID'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go('/invalid-route'),
              child: const Text('Invalid Route'),
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
            const SizedBox(height: 10),
            if (userId.isEmpty)
              const Text(
                'Error: Empty profile ID',
                style: TextStyle(color: Colors.red),
              )
            else
              const Text('Profile loaded successfully'),
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
      appBar: AppBar(title: const Text('Settings')),
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

class NotFoundScreen extends StatelessWidget {
  final String? attemptedRoute;

  const NotFoundScreen({this.attemptedRoute, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('404 - Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 20),
            const Text('Page Not Found', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            if (attemptedRoute != null) Text('Attempted: $attemptedRoute'),
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

// ===== ERROR HANDLING MIDDLEWARE =====
class NavigationErrorHandler {
  static String? handleInvalidRoute(String path) {
    // Log the error
    print('Navigation Error: Invalid route - $path');

    // Handle specific error cases
    if (path.isEmpty) {
      print('Error: Empty route path');
      return '/404?error=empty';
    }

    if (path.contains('..')) {
      print('Error: Potential directory traversal');
      return '/404?error=invalid';
    }

    if (path.length > 100) {
      print('Error: Route path too long');
      return '/404?error=too_long';
    }

    return null; // No specific error
  }

  static bool isValidUserId(String userId) {
    if (userId.isEmpty) return false;
    if (userId.length > 50) return false;
    if (userId.contains(RegExp(r'[<>]'))) return false;
    return true;
  }
}

// ===== EDGE CASE ROUTER CONFIGURATION =====
final edgeCaseGoRouter = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) {
    // Handle 404 and navigation errors
    return NotFoundScreen(attemptedRoute: state.uri.path);
  },
  redirect: (context, state) {
    // Handle invalid routes before they reach the router
    final error = NavigationErrorHandler.handleInvalidRoute(state.uri.path);
    if (error != null) {
      return error;
    }

    // Validate profile parameters
    if (state.uri.path.startsWith('/profile/')) {
      final userId = state.uri.pathSegments.length > 1
          ? state.uri.pathSegments.last
          : '';

      if (!NavigationErrorHandler.isValidUserId(userId)) {
        return '/404?error=invalid_user';
      }
    }

    return null; // No redirect needed
  },
  routes: [
    // Home route
    GoRoute(
      path: EdgeCaseRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),

    // Profile route with validation
    GoRoute(
      path: EdgeCaseRoutes.profile,
      builder: (context, state) {
        final userId = state.pathParameters['userId'] ?? 'unknown';
        return ProfileScreen(userId: userId);
      },
    ),

    // Settings route
    GoRoute(
      path: EdgeCaseRoutes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),

    // 404 route
    GoRoute(
      path: EdgeCaseRoutes.notFound,
      builder: (context, state) {
        final error = state.uri.queryParameters['error'];
        return NotFoundScreen(attemptedRoute: '404 Error: $error');
      },
    ),
  ],
);

// ===== MAIN APP WITH EDGE CASE HANDLING =====
class EdgeCaseApp extends StatelessWidget {
  const EdgeCaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Edge Cases Demo',
      routerConfig: edgeCaseGoRouter,
    );
  }
}

// ===== BACK BUTTON HANDLING =====
class BackButtonHandler extends StatefulWidget {
  final Widget child;

  const BackButtonHandler({required this.child, super.key});

  @override
  State<BackButtonHandler> createState() => _BackButtonHandlerState();
}

class _BackButtonHandlerState extends State<BackButtonHandler> {
  DateTime? _lastPressedTime;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    // Determine if pop is allowed
    bool canPop = false;

    // Handle double back press (exit app)
    if (_lastPressedTime != null &&
        now.difference(_lastPressedTime!).inSeconds < 2) {
      print('Exiting app (double back press)');
      canPop = true; // Allow pop (exit)
    } else {
      _lastPressedTime = now;

      // Handle normal back navigation
      final router = GoRouter.of(context);
      if (router.canPop()) {
        print('Normal back navigation');
        canPop = true;
      } else {
        print('Cannot pop from root');
        canPop = false; // Don't allow pop from root
      }
    }

    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPop) {
        if (didPop) {
          print('Back navigation successful');
        } else {
          print('Back navigation blocked');
        }
      },
      child: widget.child,
    );
  }
}

// ===== EDGE CASE CONCEPTS =====

/*
NAVIGATION EDGE CASES:

1. 404 HANDLING:
   - errorBuilder in GoRouter
   - Custom 404 screen
   - Error logging and reporting

2. INVALID ROUTES:
   - Redirect logic for invalid paths
   - Parameter validation
   - Security checks (path traversal)

3. BACK BUTTON HANDLING:
   - PopScope for back button control
   - Double back press to exit
   - Conditional back navigation

4. PARAMETER VALIDATION:
   - Empty parameter checks
   - Length validation
   - Special character validation
   - Type validation

5. ERROR SCENARIOS:
   - Empty route paths
   - Invalid user IDs
   - Route path too long
   - Directory traversal attempts
   - Special characters in parameters

6. HANDLING STRATEGIES:

   GRACEFUL DEGRADATION:
   - Show helpful error messages
   - Provide navigation options
   - Log errors for debugging
   - Maintain app stability

   USER FEEDBACK:
   - Clear error messages
   - Suggested actions
   - Way to recover
   - Contact support options

   SECURITY:
   - Input sanitization
   - Path traversal prevention
   - Parameter validation
   - Error message sanitization

7. TESTING EDGE CASES:
   - Navigate to empty routes
   - Invalid parameter formats
   - Extremely long routes
   - Special characters
   - Rapid back button presses
   - Network failures during navigation

8. BEST PRACTICES:
   ✅ Always handle 404 cases
   ✅ Validate input parameters
   ✅ Provide clear error messages
   ✅ Log navigation errors
   ✅ Handle back button properly
   ✅ Test edge cases thoroughly

COMMON EDGE CASES:
- /profile/ (empty user ID)
- /invalid-route (non-existent route)
- ../../../etc/pass (path traversal)
- /profile/<script> (XSS attempt)
- Very long route paths
- Special characters in parameters
- Double back button press
- Back button on root screen

IMPLEMENTATION TIPS:
- Use errorBuilder for 404 handling
- Implement redirect for validation
- Use PopScope for back button control
- Log all navigation errors
- Test with malformed inputs
*/
