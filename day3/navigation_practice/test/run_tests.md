# How to Run Tests for Each Step

## Quick Commands

### Run All Tests
```bash
cd navigation_practice
flutter test
```

### Run Specific Step Tests
```bash
# Step 1: Navigator 1.0 vs 2.0
flutter test test/step1_test.dart

# Step 2: Declarative Routing
flutter test test/step2_test.dart

# Step 3: Migration Exercise
flutter test test/step3_test.dart

# Step 4: go_router Basics
flutter test test/step4_test.dart

# Step 5: Type-Safe Routes
flutter test test/step5_test.dart

# Step 6: Deep Links
flutter test test/step6_test.dart

# Step 7: Route Guards
flutter test test/step7_test.dart

# Step 8: Navigation Testing
flutter test test/step8_test.dart

# Step 9: Edge Cases
flutter test test/step9_test.dart
```

### Run Tests with Coverage
```bash
flutter test --coverage
```

### Run Tests in Watch Mode
```bash
flutter test --watch
```

## Individual Step Testing

### Step 1: Navigator 1.0 vs 2.0
```bash
# Create test file
flutter test test/step1_test.dart

# Expected output:
// Navigator 1.0: Direct widget push
// Navigator 2.0: State-based navigation
// Both should navigate to profile screens
```

### Step 2: Declarative Routing
```bash
# Test route parsing and router delegate
flutter test test/step2_test.dart

# Expected output:
// URL parsing works correctly
// Router delegate builds correct widgets
// State changes trigger navigation
```

### Step 3: Migration Exercise
```bash
# Test 1.0 to 2.0 migration
flutter test test/step3_test.dart

# Expected output:
// Original app uses Navigator.push
// Migrated app uses Navigator.pushNamed
// Both achieve same functionality
```

### Step 4: go_router Basics
```bash
# Test go_router configuration
flutter test test/step4_test.dart

# Expected output:
// Routes configured correctly
// Navigation with context.go() works
// Parameters extracted properly
```

### Step 5: Type-Safe Routes
```bash
# Test type-safe navigation
flutter test test/step5_test.dart

# Expected output:
// Route data classes work
// Extension methods navigate correctly
// No magic strings used
```

### Step 6: Deep Links
```bash
# Test deep linking
flutter test test/step6_test.dart

# Expected output:
// Deep links parsed correctly
// Custom URL scheme works
// Parameters extracted from URLs
```

### Step 7: Route Guards
```bash
# Test authentication guards
flutter test test/step7_test.dart

# Expected output:
// Unauthenticated users redirected to login
// Authenticated users can access protected routes
// Login redirects to original destination
```

### Step 8: Navigation Testing
```bash
# Test navigation testing strategies
flutter test test/step8_test.dart

# Expected output:
// Widget tests find navigation elements
// pumpAndSettle waits for navigation
// Route transitions verified
```

### Step 9: Edge Cases
```bash
# Test error handling
flutter test test/step9_test.dart

# Expected output:
// 404 pages shown for invalid routes
// Back button handled correctly
// Invalid parameters rejected
```

## Manual Testing

### Run Individual Apps
```bash
# Step 1: Comparison
flutter run --dart-define=step=1

# Step 2: Declarative Routing
flutter run --dart-define=step=2

# Step 3: Migration
flutter run --dart-define=step=3

# Step 4: go_router
flutter run --dart-define=step=4

# Step 5: Type-Safe
flutter run --dart-define=step=5

# Step 6: Deep Links
flutter run --dart-define=step=6

# Step 7: Route Guards
flutter run --dart-define=step=7

# Step 8: Testing
flutter run --dart-define=step=8

# Step 9: Edge Cases
flutter run --dart-define=step=9
```

### Test Deep Links Manually
```bash
# Android
adb shell am start -W -a android.intent.action.VIEW -d "myapp://profile/123" com.example.navigation_practice

# iOS (simulator)
xcrun simctl openurl booted "myapp://profile/123"
```

## Test Coverage

### Generate Coverage Report
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Coverage Goals
- Each step: 80%+ coverage
- Navigation flows: 90%+ coverage
- Error handling: 100% coverage

## Debugging Tests

### Run Tests with Verbose Output
```bash
flutter test --verbose
```

### Run Specific Test
```bash
flutter test --plain-name "Step 1"
```

### Debug Failed Tests
```bash
flutter test --debug
```

## Continuous Integration

### GitHub Actions Example
```yaml
name: Test Navigation Practice
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter test
      - run: flutter test --coverage
```

## Tips for Testing

1. **Use unique keys** for navigation elements
2. **Test both directions** (forward and back navigation)
3. **Verify route parameters** are passed correctly
4. **Test edge cases** like invalid routes
5. **Mock dependencies** for isolated testing
6. **Use pumpAndSettle()** for async navigation
7. **Check URL updates** after navigation
8. **Test deep links** separately from regular navigation

## Expected Test Results

Each step should pass all tests and demonstrate:
- Correct navigation behavior
- Proper parameter handling
- Error handling for edge cases
- Performance within acceptable limits
- Accessibility compliance

Run tests frequently during development to catch issues early!
