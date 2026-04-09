import 'package:flutter/material.dart';

// STEP 2: Declarative Routing Concepts

// ===== ROUTE DEFINITION =====
class AppRoute {
  final String path;
  final Map<String, String>? params;

  AppRoute.home() : path = '/home', params = null;
  AppRoute.profile(String id) : path = '/profile', params = {'id': id};
  AppRoute.settings() : path = '/settings', params = null;
  AppRoute.unknown() : path = '/404', params = null;

  String get location => path;
}

// ===== ROUTE INFORMATION PARSER =====
// Converts URL string to AppRoute object
class AppRouteParser extends RouteInformationParser<AppRoute> {
  @override
  Future<AppRoute> parseRouteInformation(RouteInformation info) async {
    final uri = info.uri;

    switch (uri.path) {
      case '/home':
      case '/':
        return AppRoute.home();
      case '/settings':
        return AppRoute.settings();
      case '/404':
        return AppRoute.unknown();
      default:
        if (uri.path.startsWith('/profile/')) {
          final id = uri.pathSegments.last;
          return AppRoute.profile(id);
        }
        return AppRoute.unknown();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(AppRoute configuration) {
    return RouteInformation(location: configuration.location);
  }
}

// ===== ROUTER DELEGATE =====
// Builds widgets based on current route
class AppRouterDelegate extends RouterDelegate<AppRoute> with ChangeNotifier {
  AppRoute _currentRoute = AppRoute.home();

  AppRoute get currentRoute => _currentRoute;

  @override
  Widget build(BuildContext context) {
    switch (_currentRoute.path) {
      case '/home':
        return HomeScreen(
          onNavigateToProfile: (userId) => _navigate(AppRoute.profile(userId)),
          onNavigateToSettings: () => _navigate(AppRoute.settings()),
        );
      case '/profile':
        final id = _currentRoute.params!['id']!;
        return ProfileScreen(
          userId: id,
          onGoBack: () => _navigate(AppRoute.home()),
        );
      case '/settings':
        return SettingsScreen(onGoBack: () => _navigate(AppRoute.home()));
      case '/404':
      default:
        return NotFoundScreen(onGoHome: () => _navigate(AppRoute.home()));
    }
  }

  @override
  Future<void> setNewRoutePath(AppRoute route) async {
    _currentRoute = route;
    notifyListeners();
  }

  void _navigate(AppRoute route) {
    setNewRoutePath(route);
  }

  @override
  Future<bool> popRoute() {
    if (_currentRoute.path != '/home') {
      _navigate(AppRoute.home());
      return Future.value(true);
    }
    return Future.value(false);
  }
}

// ===== SCREENS =====
class HomeScreen extends StatelessWidget {
  final Function(String) onNavigateToProfile;
  final VoidCallback onNavigateToSettings;

  const HomeScreen({
    required this.onNavigateToProfile,
    required this.onNavigateToSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home - Declarative Routing')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is Declarative Routing'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => onNavigateToProfile('123'),
              child: Text('Go to Profile 123'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => onNavigateToSettings(),
              child: Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final String userId;
  final VoidCallback onGoBack;

  const ProfileScreen({required this.userId, required this.onGoBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile - Declarative Routing')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Profile ID: $userId'),
            SizedBox(height: 20),
            ElevatedButton(onPressed: onGoBack, child: Text('Go Back Home')),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final VoidCallback onGoBack;

  const SettingsScreen({required this.onGoBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings - Declarative Routing')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Settings Screen'),
            SizedBox(height: 20),
            ElevatedButton(onPressed: onGoBack, child: Text('Go Back Home')),
          ],
        ),
      ),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  final VoidCallback onGoHome;

  const NotFoundScreen({required this.onGoHome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('404 - Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Page Not Found'),
            SizedBox(height: 20),
            ElevatedButton(onPressed: onGoHome, child: Text('Go Home')),
          ],
        ),
      ),
    );
  }
}

// ===== MAIN APP =====
class DeclarativeRoutingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Declarative Routing Demo',
      routerDelegate: AppRouterDelegate(),
      routeInformationParser: AppRouteParser(),
    );
  }
}

// ===== CONCEPTS SUMMARY =====

/*
DECLARATIVE ROUTING CONCEPTS:

1. ROUTE DEFINITION:
   - Define routes as data objects (AppRoute)
   - Include path and parameters

2. ROUTE INFORMATION PARSER:
   - Converts URL string → Route object
   - parseRouteInformation() method
   - Handles URL parsing logic

3. ROUTER DELEGATE:
   - Builds widgets based on current route
   - Manages navigation state
   - setNewRoutePath() updates state

4. NAVIGATION FLOW:
   URL changes → Parser → RouterDelegate → Widget
   
5. KEY BENEFITS:
   ✅ URL-based navigation
   ✅ Centralized routing logic
   ✅ Testable navigation state
   ✅ Deep linking support
   ✅ Browser back button support

MENTAL SHIFT:
- From: "Push this widget"
- To: "Navigate to this URL"
- Router decides what widget to show
*/
