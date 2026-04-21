# COE Practice

A comprehensive Flutter practice repository covering 10 days of exercises, from basic programming concepts to advanced testing and performance optimization.

## Days Overview

### Day 1: FizzBuzz
- **Focus:** Basic programming logic and TDD
- **Content:** Classic FizzBuzz problem implementation
- **Tests:** 4 tests covering numbers, multiples of 3, multiples of 5, and multiples of both

### Day 2: SOLID Principles
- **Focus:** Software design principles
- **Content:** 
  - Single Responsibility Principle (SRP)
  - Open/Closed Principle (OCP)
  - Liskov Substitution Principle (LSP)
  - Interface Segregation Principle (ISP)
  - Dependency Inversion Principle (DIP)
- **Tests:** 64 tests covering all SOLID principles with real-world examples

### Day 3: Navigation Practice
- **Focus:** Flutter navigation patterns
- **Content:**
  - Navigator 1.0 vs 2.0
  - Declarative routing
  - Deep links
  - Route guards
  - Type-safe routes
  - Go Router
  - Edge case handling
- **Tests:** 27 tests covering various navigation scenarios and golden tests

### Day 4: Clean Code Practice
- **Focus:** Writing maintainable, readable code
- **Content:**
  - Meaningful naming
  - Single responsibility
  - Code smell refactoring
  - Self-documenting code
  - DRY (Don't Repeat Yourself) principle
  - Guard clauses
- **Tests:** 26 tests covering clean code practices and refactored components

### Day 5: Error Handling Practice
- **Focus:** Proper error handling in Flutter/Dart
- **Content:**
  - Exception vs Error fundamentals
  - Custom exception hierarchies
  - Result types and functional error handling
  - Async error handling
  - Global error handling
  - Error boundaries
- **Tests:** 38 tests covering exception classes, services, and result types

### Day 6: State Management Practice
- **Focus:** Various state management approaches
- **Content:**
  - Provider vs BLoC vs Riverpod comparison
  - Multi-step forms
  - State persistence (SharedPreferences)
  - Clean architecture with state management
  - Hydrated BLoC
- **Tests:** 8 tests covering FormModel, User entity, repository, and use cases

### Day 7: Performance Practice
- **Focus:** Flutter performance optimization
- **Content:**
  - Widget optimization (const constructors, keys)
  - ListView performance (ListView.builder vs ListView)
  - Image optimization and caching
  - Lazy loading and pagination
  - Memory profiling and dispose patterns
- **Tests:** 7 tests covering addLog function and lazy loading logic

### Day 8: My Practice App
- **Focus:** Building a complete Flutter app with CI/CD
- **Content:**
  - Environment configuration
  - App configuration management
  - Counter app implementation
  - Fastlane CI/CD setup (Android & iOS)
  - GitHub Actions integration
  - Automated build and deployment pipelines
- **Tests:** 9 tests covering AppConfig class functionality
- **CI/CD:** Fastlane lanes for testing, building, and deployment

### Day 9: Design System Practice
- **Focus:** Building reusable UI components
- **Content:**
  - Design system components (DSButton, DSTextField, DSBadge, Header)
  - Golden variant testing
  - Interaction contract testing
  - Accessibility
- **Tests:** 69 tests covering component rendering and interactions

### Day 10: Testing Practice
- **Focus:** Advanced testing techniques (Maestro E2E and Mutation testing)

#### counter_maestro
- **Focus:** E2E testing with Maestro
- **Content:**
  - Counter screen with increment/decrement
  - Input screen with form validation
  - Scroll screen with ListView
  - Swipe screen with item navigation
  - Maestro flow definitions for E2E testing
- **Tests:** Widget tests for all screens and Maestro E2E flows

#### mutation_practice
- **Focus:** Mutation testing with mutagen
- **Content:**
  - Calculator implementation
  - Mutation testing setup
- **Tests:** 41 tests covering calculator functions (add, subtract, multiply, divide, max, min, isEven, factorial, fibonacci)

## Test Coverage

All days have comprehensive test coverage:

- **Total Tests:** 293 tests across all days
- **Test Types:** Unit tests, widget tests, golden tests, interaction tests
- **All tests passing:** ✅

## Running Tests

Run all tests:
```bash
flutter test
```

Run tests for a specific day:
```bash
cd day1/fizzbuzz && flutter test
cd day2/solid_practice && flutter test
# ... etc
```

Or use Melos (if configured):
```bash
melos run test:day1
melos run test:day2
# ... etc
```

## Project Structure

```
coe-practice/
├── day1/fizzbuzz/
├── day2/solid_practice/
├── day3/navigation_practice/
├── day4/clean_code_practice/
├── day5/error_handling_practice/
├── day6/state_management_practice/
├── day7/performance_practice/
├── day8/my_practice_app/
├── day9/design_system_practice/
├── day10/
│   ├── counter_maestro/
│   └── mutation_practice/
├── melos.yaml
└── README.md
```

## Technologies Used

- Flutter
- Dart
- Melos (monorepo management)
- flutter_test
- mutagen (mutation testing)
- Maestro (E2E testing)
- Fastlane (CI/CD automation)
- GitHub Actions

