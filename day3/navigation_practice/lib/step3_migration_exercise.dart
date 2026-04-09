import 'package:flutter/material.dart';

// STEP 3: Migration from Navigator 1.0 to 2.0

// ===== ORIGINAL NAVIGATOR 1.0 APP =====
class OriginalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Original App (1.0)',
      home: OriginalHomeScreen(),
    );
  }
}

class OriginalHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Original Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Original App - Navigator 1.0'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 1.0 WAY: Direct widget push
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OriginalProfileScreen(userId: '123')),
                );
              },
              child: Text('View Profile (1.0)'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // 1.0 WAY: Direct widget push
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OriginalSettingsScreen()),
                );
              },
              child: Text('Settings (1.0)'),
            ),
          ],
        ),
      ),
    );
  }
}

class OriginalProfileScreen extends StatelessWidget {
  final String userId;
  
  const OriginalProfileScreen({required this.userId});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Original Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Profile ID: $userId'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 1.0 WAY: Direct pop
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

class OriginalSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Original Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Settings Screen'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 1.0 WAY: Direct pop
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

// ===== MIGRATED NAVIGATOR 2.0 APP =====

// Route definitions
class AppRoutes {
  static const String home = '/';
  static const String profile = '/profile';
  static const String settings = '/settings';
}

class MigratedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Migrated App (2.0)',
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => MigratedHomeScreen(),
        AppRoutes.profile: (context) => MigratedProfileScreen(),
        AppRoutes.settings: (context) => MigratedSettingsScreen(),
      },
      onGenerateRoute: (settings) {
        // Handle profile with parameters
        if (settings.name?.startsWith(AppRoutes.profile) == true) {
          final uri = Uri.parse(settings.name!);
          final userId = uri.queryParameters['id'] ?? 'unknown';
          return MaterialPageRoute(
            builder: (context) => MigratedProfileScreen(userId: userId),
          );
        }
        return null;
      },
    );
  }
}

class MigratedHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Migrated Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Migrated App - Navigator 2.0'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 2.0 WAY: Named navigation with parameters
                Navigator.pushNamed(
                  context,
                  '${AppRoutes.profile}?id=123',
                );
              },
              child: Text('View Profile (2.0)'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // 2.0 WAY: Named navigation
                Navigator.pushNamed(context, AppRoutes.settings);
              },
              child: Text('Settings (2.0)'),
            ),
          ],
        ),
      ),
    );
  }
}

class MigratedProfileScreen extends StatelessWidget {
  final String userId;
  
  const MigratedProfileScreen({this.userId = 'unknown'});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Migrated Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Profile ID: $userId'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 2.0 WAY: Named navigation back
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

class MigratedSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Migrated Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Settings Screen'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 2.0 WAY: Named navigation back
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

// ===== MIGRATION COMPARISON =====

/*
MIGRATION FROM 1.0 TO 2.0:

1. SCREEN CREATION:
   BEFORE: MaterialPageRoute(builder: (context) => ProfileScreen())
   AFTER:  Routes defined in MaterialApp.routes: {}

2. NAVIGATION:
   BEFORE: Navigator.push(context, MaterialPageRoute(...))
   AFTER:  Navigator.pushNamed(context, '/profile')

3. PARAMETERS:
   BEFORE: Pass directly to widget constructor
   AFTER: Pass via URL query parameters

4. GOING BACK:
   BEFORE: Navigator.pop(context)
   AFTER:  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false)

5. URL HANDLING:
   BEFORE: No URL support
   AFTER:  onGenerateRoute handles parameterized routes

KEY IMPROVEMENTS:
✅ URL-based navigation
✅ Deep linking support
✅ Centralized route configuration
✅ Better testability
✅ Browser back button support
✅ State restoration

MIGRATION STEPS:
1. Define route constants
2. Create route map in MaterialApp
3. Replace Navigator.push with Navigator.pushNamed
4. Handle parameters in onGenerateRoute
5. Update back navigation
*/
