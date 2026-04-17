---
name: flutter-test-patterns
description: Write senior-level Flutter widget tests using proven patterns. Use this skill when the user asks to write tests, add widget tests, test a Flutter widget, or improve test coverage. Triggers on phrases like "write tests for this widget", "add golden tests", "test all states", "interaction test", "widget test", or any mention of flutter_test_patterns.
---

# Flutter Test Patterns

A toolbox of senior-level widget testing patterns for Flutter. Uses the `flutter_test_patterns` package to reduce boilerplate while keeping tests explicit, composable, and isolated.

## Setup

First, confirm the package is in `dev_dependencies`:

```yaml
dev_dependencies:
  flutter_test_patterns: ^latest
```

> Always use the latest version. Check the current version at [pub.dev/packages/flutter_test_patterns](https://pub.dev/packages/flutter_test_patterns).

If missing, add it and run:

```bash
flutter pub get
```

---

## The 3 Patterns — When to Use Which

| Pattern | Use When |
|---|---|
| **Golden Variants** | Widget has multiple visual states (primary, disabled, hover, dark mode) |
| **Interaction Contracts** | Widget has reusable behaviors (tappable, validates on blur, dismissible) |
| **State Matrix** | Widget renders across data states (loading, error, data, empty) |

---

## Pattern 1: Golden Variants

Use for widgets with multiple **visual** variants. Generates deterministic golden files per variant in a single test block.

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_patterns/flutter_test_patterns.dart';

void main() {
  testWidgets('Button golden variants', (tester) async {
    await goldenVariants(
      tester,
      'button',
      variants: {
        'primary':  () => Button.primary(label: 'Submit'),
        'disabled': () => Button.disabled(label: 'Submit'),
        'loading':  () => Button.loading(),
      },
    );
  });
}
```

**Golden files are saved as:** `goldens/button_primary.png`, `goldens/button_disabled.png`, etc.

**Update goldens after UI changes:**
```bash
flutter test --update-goldens
```

---

## Pattern 2: Interaction Contracts

Use for widgets with **behavioral** expectations that should be enforced consistently.

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_patterns/flutter_test_patterns.dart';

void main() {
  testWidgets('Button satisfies tappable contract', (tester) async {
    var tapped = false;

    await verifyContract(
      tester,
      contract: tappableContract(onTap: () => tapped = true),
      widget: Button.primary(
        label: 'Submit',
        onPressed: () => tapped = true,
      ),
    );

    expect(tapped, isTrue);
  });
}
```

**Common built-in contracts:**
- `tappableContract` — verifies onTap/onPressed fires
- `validatesOnBlurContract` — verifies validation triggers on focus loss
- `dismissibleContract` — verifies widget can be dismissed

---

## Pattern 3: State Matrix

Use when a widget renders differently based on **data state**.

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_patterns/flutter_test_patterns.dart';

void main() {
  testWidgets('UserCard state matrix', (tester) async {
    await stateMatrix(
      tester,
      'user_card',
      states: {
        'loading': () => UserCard.loading(),
        'error':   () => UserCard.error(message: 'Failed to load'),
        'empty':   () => UserCard.empty(),
        'data':    () => UserCard(user: User.mock()),
      },
    );
  });
}
```

---

## Step-by-Step Workflow

When a user asks to write tests for a widget:

### Step 1 — Read the widget
Read the widget file to understand:
- What visual variants exist → candidate for **Golden Variants**
- What callbacks/interactions it exposes → candidate for **Interaction Contracts**
- Whether it accepts state (loading/error/data/empty) → candidate for **State Matrix**

### Step 2 — Choose patterns
A widget can use multiple patterns.

### Step 3 — Generate the test file
Place test files in the matching `test/` directory:
```
lib/widgets/user_card.dart   →  test/widgets/user_card_test.dart
lib/screens/home_screen.dart →  test/screens/home_screen_test.dart
```

### Step 4 — Run tests
```bash
flutter test test/widgets/user_card_test.dart
```

For golden tests, generate goldens first:
```bash
flutter test --update-goldens test/widgets/user_card_test.dart
```

---

## Tips

- Never use a `BaseTest` class — composition over inheritance
- Each test should be fully independent — no shared mutable state between tests
- Prefer explicit widget construction in tests over helpers that hide setup
- Name golden files descriptively: `button_primary`, not `button_1` 
- Always run `flutter test --update-goldens` after intentional UI changes
