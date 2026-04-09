import 'package:flutter/material.dart';

// STEP 1: Navigator 1.0 vs 2.0 Comparison

// ===== NAVIGATOR 1.0 (Imperative) =====
class Navigator1Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Navigator 1.0', home: HomeScreen1());
  }
}

class HomeScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Navigator 1.0 - Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is Navigator 1.0 (Imperative)'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // IMPERATIVE: We command navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen1()),
                );
              },
              child: Text('Go to Profile (1.0)'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Navigator 1.0 - Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Profile Screen - Navigator 1.0'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // IMPERATIVE: We command to go back
                Navigator.pop(context);
              },
              child: Text('Go Back (1.0)'),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== NAVIGATOR 2.0 (Declarative) =====

// Simple route class for Navigator 2.0
class AppRoute {
  final String path;

  AppRoute.home() : path = '/home';
  AppRoute.profile() : path = '/profile';

  String get location => path;
}

// Route Information Parser
class AppRouteParser extends RouteInformationParser<AppRoute> {
  @override
  Future<AppRoute> parseRouteInformation(RouteInformation info) async {
    final uri = info.uri;

    if (uri.path == '/home' || uri.path == '/') {
      return AppRoute.home();
    }
    if (uri.path == '/profile') {
      return AppRoute.profile();
    }

    return AppRoute.home(); // default
  }

  @override
  RouteInformation? restoreRouteInformation(AppRoute configuration) {
    return RouteInformation(location: configuration.location);
  }
}

// Router Delegate
class AppRouterDelegate extends RouterDelegate<AppRoute> with ChangeNotifier {
  AppRoute? _currentRoute;

  AppRoute get currentRoute => _currentRoute ?? AppRoute.home();

  @override
  Widget build(BuildContext context) {
    switch (currentRoute.path) {
      case '/home':
        return HomeScreen2();
      case '/profile':
        return ProfileScreen2();
      default:
        return HomeScreen2();
    }
  }

  @override
  Future<void> setNewRoutePath(AppRoute route) async {
    _currentRoute = route;
    notifyListeners();
  }

  @override
  Future<bool> popRoute() {
    // TODO: implement popRoute
    throw UnimplementedError();
  }
}

class Navigator2Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Navigator 2.0',
      routerDelegate: AppRouterDelegate(),
      routeInformationParser: AppRouteParser(),
    );
  }
}

class HomeScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Navigator 2.0 - Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is Navigator 2.0 (Declarative)'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // DECLARATIVE: We change state, router decides what to show
                final router = Router.of(context);
                if (router.routerDelegate is AppRouterDelegate) {
                  (router.routerDelegate as AppRouterDelegate).setNewRoutePath(
                    AppRoute.profile(),
                  );
                }
              },
              child: Text('Go to Profile (2.0)'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Navigator 2.0 - Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Profile Screen - Navigator 2.0'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // DECLARATIVE: We change state back to home
                final router = Router.of(context);
                if (router.routerDelegate is AppRouterDelegate) {
                  (router.routerDelegate as AppRouterDelegate).setNewRoutePath(
                    AppRoute.home(),
                  );
                }
              },
              child: Text('Go Back (2.0)'),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== COMPARISON NOTES =====

/*
NAVIGATOR 1.0 (Imperative):
- You directly command navigation
- Navigator.push(context, route)
- Navigator.pop(context)
- URL doesn't update automatically
- No deep linking support
- Hard to test navigation state

NAVIGATOR 2.0 (Declarative):
- You declare routing configuration
- Router.of(context).router.navigateNamed('/path')
- URL updates automatically
- Built-in deep linking support
- Easy to test navigation state

KEY DIFFERENCE:
1.0: "Push this screen" (Command)
2.0: "Navigate to /profile" (State change)
*/
