import 'package:flutter/material.dart';

// STEP 1: Simple Navigator 1.0 vs 2.0 Comparison

// ===== NAVIGATOR 1.0 (Imperative) =====
class Navigator1App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigator 1.0',
      home: HomeScreen1(),
    );
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

// ===== NAVIGATOR 2.0 (Simple Declarative) =====

// Simple route configuration
class AppRoutes {
  static const String home = '/';
  static const String profile = '/profile';
}

class Navigator2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigator 2.0',
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => HomeScreen2(),
        AppRoutes.profile: (context) => ProfileScreen2(),
      },
      onGenerateRoute: (settings) {
        // Simple declarative routing
        if (settings.name == AppRoutes.profile) {
          return MaterialPageRoute(builder: (context) => ProfileScreen2());
        }
        return null;
      },
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
                // DECLARATIVE: We navigate by route name
                Navigator.pushNamed(context, AppRoutes.profile);
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
                // DECLARATIVE: We navigate by route name
                Navigator.pushNamedAndRemoveUntil(
                  context, 
                  AppRoutes.home, 
                  (route) => false,
                );
              },
              child: Text('Go Back (2.0)'),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== COMPARISON SUMMARY =====

/*
NAVIGATOR 1.0 (Imperative):
- You directly command: Navigator.push(context, route)
- You manually create MaterialPageRoute
- URL doesn't update automatically
- No deep linking support
- Hard to test navigation state

NAVIGATOR 2.0 (Declarative):
- You declare routes: MaterialApp(routes: {...})
- You navigate by name: Navigator.pushNamed(context, '/profile')
- URL updates automatically (with proper setup)
- Built-in deep linking support
- Easy to test navigation state

KEY DIFFERENCE:
1.0: "Push this specific widget" (Command-based)
2.0: "Navigate to this named route" (Configuration-based)

ADVANTAGES OF 2.0:
✅ URL-based navigation
✅ Deep linking support
✅ Testable navigation state
✅ Centralized route configuration
✅ Browser back button support
*/
