# State Management Patterns & Architecture

This Flutter project contains hands-on exercises for learning state management patterns and clean architecture in Flutter.

## 📚 Exercises

### Exercise 1: Provider vs BLoC vs Riverpod
- Compare three popular state management approaches
- Learn decision matrix for choosing the right solution
- Understand complexity, predictability, and best use cases

### Exercise 2: Multi-Step Form
- Build a simple 2-step form with state management
- Learn to persist state across form steps
- Understand incremental model updates

### Exercise 3: State Persistence
- Persist state across app restarts using SharedPreferences
- Learn different persistence strategies (SharedPreferences, Hive, Sqflite)
- Understand fromJson/toJson workflow

### Exercise 4: Clean Architecture
- Separate presentation, domain, and data layers
- Implement Repository pattern
- Learn to avoid common architecture pitfalls

### Exercise 5: Hydrated BLoC
- Implement automatic state persistence with Hydrated BLoC
- Learn fromJson/toJson workflow for state hydration
- Understand automatic state restoration on app restart

## 🚀 Getting Started

### Run the Exercise Selector
```bash
cd state_management_practice
flutter run
```

Once the app launches, you'll see a list of all exercises. Simply tap on any exercise to open it directly - no command line flags needed!

## 🎯 Success Criteria

By completing these exercises, you will learn to:
- Compare BLoC, Provider, and Riverpod objectively
- Make informed state management decisions
- Create decision matrix for choosing solutions
- Build complex multi-step form with state
- Implement optimistic updates correctly
- Persist state with SharedPreferences
- Test state management thoroughly
- Separate presentation from business logic
- Implement repository pattern cleanly
- Avoid common state management pitfalls
- Document architecture decisions with rationale

## 📁 Project Structure

```
state_management_practice/
├── lib/
│   ├── main.dart                          # Exercise selector
│   ├── exercise1_provider_bloc_riverpod.dart  # State management comparison
│   ├── exercise2_multi_step_form.dart   # Multi-step form exercise
│   ├── exercise3_state_persistence.dart  # State persistence exercise
│   ├── exercise4_clean_architecture.dart # Clean architecture exercise
│   └── exercise5_hydrated_bloc.dart     # Hydrated BLoC exercise
└── test/
    └── widget_test.dart                   # Widget tests
```

## 💡 Learning Tips

1. **Compare Patterns**: Each exercise shows different state management patterns
2. **Understand the Problem**: Read the decision matrix to understand when to use each approach
3. **Study the Solution**: Review the implementation to see the pattern in action
4. **Test the Code**: Use the interactive demos to test state management
5. **Apply the Pattern**: Use these patterns in your own projects

## 🔧 Additional Resources

- [Provider Documentation](https://pub.dev/packages/provider)
- [BLoC Documentation](https://pub.dev/packages/flutter_bloc)
- [Riverpod Documentation](https://riverpod.dev/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Architecture](https://docs.flutter.dev/data-and-backend/state-mgmt/intro)
