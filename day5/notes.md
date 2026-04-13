# Error Handling in Dart and Flutter

Error handling in Dart and Flutter is a multi-layered process. Because Flutter apps deal with both synchronous logic (calculating a value) and asynchronous logic (fetching data from an API), you need a strategy that covers both.

Here is a comprehensive guide to error handling strategies, ranging from basic to advanced.

## 1. The Fundamentals: Exception vs Error

Before choosing a strategy, you must understand the difference between these two in Dart:

- **Exception**: Intended for conditions that a program should be able to handle (e.g., `SocketException` when the internet is down, `FormatException` when parsing JSON). You should catch these.
- **Error**: Intended for programmatic failures that should not happen (e.g., `RangeError`, `TypeError`, `OutOfMemoryError`). These indicate a bug in your code. You should fix these, not catch them.

## 2. Basic Strategy: Try-Catch-Finally

The standard way to handle exceptions is the try-catch block.

```dart
try {
  var result = performRiskyOperation();
} on SocketException catch (e) {
  // Handle specific exception (e.g., No Internet)
  print('Network error: $e');
} catch (e) {
  // Handle any other unexpected exception
  print('Unknown error: $e');
} finally {
  // Always executes (e.g., closing a database connection or stopping a loader)
  stopLoadingIndicator();
}
```

**Pro Tip**: Always use `on SpecificException` before the general `catch (e)` to handle known failure points gracefully.

## 3. Asynchronous Error Handling

Since most Flutter apps rely on `Future` and `Stream`, standard try-catch blocks only work if you use async/await.

### Using async/await

```dart
Future<void> fetchData() async {
  try {
    final data = await apiService.getData();
  } catch (e) {
    print('Caught async error: $e');
  }
}
```

### Using .catchError() (Fluent style)

If you aren't using await, use the `.catchError` method:

```dart
apiService.getData().then((data) {
  print(data);
}).catchError((error) {
  print('Error occurred: $error');
});
```

## 4. Advanced Strategy: Functional Error Handling (The "Either" Pattern)

In large-scale professional apps, try-catch can lead to "Pyramid of Doom" code and makes it easy to forget to handle an error.

**The Strategy**: Instead of throwing an exception, return a Result object that contains either the Failure or the Success value.

Using a package like `fpdart` or `dartz`, you can use the Either type:

```dart
// Left is usually the Error, Right is the Success (think "Right is correct")
Future<Either<Failure, User>> getUser() async {
  try {
    final user = await api.fetchUser();
    return Right(user);
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}

// Usage in UI
final result = await getUser();
result.fold(
  (failure) => showSnackBar(failure.message), // Handle error
  (user) => navigateToProfile(user),          // Handle success
);
```

**Benefit**: The compiler forces you to handle the error case, making your app significantly more robust.

## 5. Flutter UI Error Handling

Handling the error in the logic is only half the battle; you must communicate it to the user.

### State-Driven UI

Use a state management library (Bloc, Riverpod, Provider) to track the status of an operation:

- **LoadingState** → Show `CircularProgressIndicator`
- **SuccessState** → Show the data
- **ErrorState** → Show an error widget with a "Retry" button.

### Global Error Widgets

To prevent the "Red Screen of Death" in production, override the default error widget:

```dart
void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Center(
        child: Text("Something went wrong. Please restart the app."),
      ),
    );
  };
  runApp(MyApp());
}
```

## 6. Global Exception Catching (The Safety Net)

Some errors happen outside of your try-catch blocks (e.g., inside a timer or a background isolate).

### Framework Errors

```dart
FlutterError.onError = (details) {
  FlutterError.presentError(details);
  // Log to Firebase Crashlytics or Sentry here
  Crashlytics.instance.recordFlutterError(details);
};
```

### Asynchronous/Platform Errors

For errors that happen outside the Flutter framework (like a platform channel crash):

```dart
PlatformDispatcher.instance.onError = (error, stack) {
  // Log global asynchronous errors
  print('Global error: $error');
  return true; // Error handled
};
```

## Summary Table: Which strategy to use?

| Scenario | Recommended Strategy | Tool/Pattern |
|----------|---------------------|--------------|
| Simple, local logic | Try-Catch | `try { ... } catch (e) { ... }` |
| API / Database calls | Functional Handling | `Either<Failure, Success>` (fpdart) |
| UI Feedback | State Management | Loading → Error → Success |
| Uncaught Crashes | Global Observers | PlatformDispatcher / Crashlytics |
| Production Safety | Custom Error Widget | `ErrorWidget.builder` |