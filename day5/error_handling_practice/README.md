# Error Handling Patterns & Custom Exceptions

This Flutter project contains hands-on exercises for learning error handling strategies and custom exceptions in Dart and Flutter.

## 📚 Exercises

### Exercise 1: Exception vs Error
- Understand the difference between Exception and Error in Dart
- Learn when to catch exceptions vs fix errors
- Handle network failures, validation errors, and more

### Exercise 2: Custom Exception Hierarchy
- Create domain-specific exception types
- Build exception hierarchies for your app
- Follow naming conventions for custom exceptions

### Exercise 3: Result Types and Functional Error Handling
- Implement Result/Either pattern
- Avoid "Pyramid of Doom" with functional error handling
- Learn type-safe error handling

### Exercise 4: Async Error Handling and Streams
- Handle errors in async code with async/await
- Catch errors in streams with onError
- Use Completer for manual async operations

### Exercise 5: Global Error Handling Strategies
- Implement FlutterError.onError for framework errors
- Use PlatformDispatcher.onError for async errors
- Build custom error logging services

### Exercise 6: Error Boundary Widgets
- Create error boundary widgets to isolate errors
- Implement SafeBuilder for safe widget construction
- Show user-friendly error messages

## 🚀 Getting Started

### Run the Exercise Selector
```bash
cd error_handling_practice
flutter run
```

Once the app launches, you'll see a list of all exercises. Simply tap on any exercise to open it directly - no command line flags needed!

## 🎯 Success Criteria

By completing these exercises, you will learn to:
- Understand Exception vs Error in Dart
- Create custom exception hierarchy appropriately
- Name exceptions following conventions
- Use custom exceptions over generic ones when appropriate
- Implement Result types for functional error handling
- Handle async errors and stream errors correctly
- Implement global error handling
- Create error boundary widgets
- Integrate error logging (Sentry/Crashlytics)
- Provide user-friendly error messages
- Build complete error handling framework

## 📁 Project Structure

```
error_handling_practice/
├── lib/
│   ├── main.dart                          # Exercise selector
│   ├── exercise1_exception_vs_error.dart  # Exception vs Error fundamentals
│   ├── exercise2_custom_exceptions.dart   # Custom exception hierarchy
│   ├── exercise3_result_types.dart        # Result types and functional error handling
│   ├── exercise4_async_error_handling.dart # Async error handling and streams
│   ├── exercise5_global_error_handling.dart # Global error handling strategies
│   └── exercise6_error_boundary.dart      # Error boundary widgets
└── test/
    └── widget_test.dart                   # Widget tests
```

## 💡 Learning Tips

1. **Compare Patterns**: Each exercise shows different error handling patterns
2. **Understand the Problem**: Read the "PROBLEM" section to understand the issue
3. **Study the Solution**: Review the implementation to see the fix
4. **Test the Code**: Use the interactive demos to test error handling
5. **Apply the Pattern**: Use these patterns in your own projects

## 🔧 Additional Resources

- [Dart Error Handling](https://dart.dev/guides/libraries/futures-error-handling)
- [Flutter Error Handling](https://docs.flutter.dev/testing/errors)
- [Effective Dart: Error Handling](https://dart.dev/guides/language/effective-dart/errors)
- [Sentry for Flutter](https://docs.sentry.io/platforms/flutter/)
- [Firebase Crashlytics](https://firebase.google.com/docs/crashlytics)
