import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// STEP 6: Simple Deep Linking

// ===== DEEP LINK ROUTE DEFINITIONS =====
class DeepLinkRoutes {
  static const String home = '/';
  static const String profile = '/profile/:userId';
  static const String product = '/product/:productId';
  static const String share = '/share/:type/:id';
}

// ===== DEEP LINK HANDLER =====
class DeepLinkHandler {
  static void handleIncomingLink(Uri uri) {
    print('=== DEEP LINK RECEIVED ===');
    print('Scheme: ${uri.scheme}');
    print('Host: ${uri.host}');
    print('Path: ${uri.path}');
    print('Query Parameters: ${uri.queryParameters}');

    // Handle different deep link types
    switch (uri.path) {
      case '/share/profile':
        final userId = uri.queryParameters['userId'];
        print('Sharing profile: $userId');
        break;
      case '/share/product':
        final productId = uri.queryParameters['productId'];
        print('Sharing product: $productId');
        break;
      default:
        print('Unknown deep link: ${uri.path}');
    }
  }
}

// ===== SCREENS =====
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deep Links Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Deep Link Examples'),
            const SizedBox(height: 20),
            const Text('Test these deep links:'),
            const SizedBox(height: 10),
            const Text('myapp://profile/123'),
            const SizedBox(height: 5),
            const Text('myapp://product/abc123'),
            const SizedBox(height: 5),
            const Text('myapp://share/profile?userId=456'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/profile/123'),
              child: const Text('Go to Profile 123'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go('/product/abc123'),
              child: const Text('Go to Product abc123'),
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
            Text('Deep link: myapp://profile/$userId'),
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
            const SizedBox(height: 10),
            Text('Deep link: myapp://product/$productId'),
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

class ShareScreen extends StatelessWidget {
  final String type;
  final String id;

  const ShareScreen({required this.type, required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Share $type')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sharing $type with ID: $id'),
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

// ===== DEEP LINK ROUTER CONFIGURATION =====
final deepLinkGoRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Home route
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),

    // Profile route - supports deep links
    GoRoute(
      path: DeepLinkRoutes.profile,
      builder: (context, state) {
        final userId = state.pathParameters['userId'] ?? 'unknown';
        return ProfileScreen(userId: userId);
      },
    ),

    // Product route - supports deep links
    GoRoute(
      path: DeepLinkRoutes.product,
      builder: (context, state) {
        final productId = state.pathParameters['productId'] ?? 'unknown';
        return ProductScreen(productId: productId);
      },
    ),

    // Share route - supports deep links
    GoRoute(
      path: DeepLinkRoutes.share,
      builder: (context, state) {
        final type = state.pathParameters['type'] ?? 'unknown';
        final id = state.pathParameters['id'] ?? 'unknown';
        return ShareScreen(type: type, id: id);
      },
    ),
  ],
);

// ===== MAIN APP WITH DEEP LINK SUPPORT =====
class DeepLinkApp extends StatelessWidget {
  const DeepLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Deep Links Demo',
      routerConfig: deepLinkGoRouter,
    );
  }
}

// ===== DEEP LINK CONCEPTS =====

/*
DEEP LINKING CONCEPTS:

1. CUSTOM URL SCHEME:
   - myapp://profile/123
   - myapp://product/abc123
   - myapp://share/profile?userId=456

2. DEEP LINK COMPONENTS:
   - URL scheme (myapp://)
   - Host/path (/profile/123)
   - Query parameters (?id=123)

3. ROUTE HANDLING:
   - GoRoute automatically handles deep links
   - Path parameters extracted automatically
   - No additional parsing needed

4. TESTING DEEP LINKS:
   - Browser: myapp://profile/123
   - Email links: myapp://product/abc123
   - QR codes: myapp://share/profile?userId=456

5. BENEFITS:
   ✅ Direct access to specific content
   ✅ Share content via links
   ✅ Marketing campaigns
   ✅ Email integration
   ✅ Social media sharing

ANDROID SETUP (AndroidManifest.xml):
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="myapp" />
</intent-filter>

iOS SETUP (Info.plist):
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>com.example.myapp</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>myapp</string>
        </array>
    </dict>
</array>

USAGE EXAMPLES:
- User clicks link in email → Opens app to specific profile
- Share product link → Opens app to product page
- QR code scan → Opens app to specific content
- Social media post → Opens app with shared content

KEY POINTS:
- Routes automatically support deep linking
- No special handling needed in go_router
- Path parameters work out of the box
- Query parameters available via state.uri
*/
