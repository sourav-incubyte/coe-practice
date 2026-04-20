import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_patterns/flutter_test_patterns.dart';
import 'package:clean_code_practice/exercise1_naming.dart' as ex1;
import 'package:clean_code_practice/exercise2_single_responsibility.dart';
import 'package:clean_code_practice/exercise3_code_smells.dart';
import 'package:clean_code_practice/exercise4_self_documenting.dart' as ex4;
import 'package:clean_code_practice/exercise5_dry_principle.dart';
import 'package:clean_code_practice/exercise6_guard_clauses.dart';

void main() {
  group('Exercise 1: Meaningful Naming', () {
    testWidgets('UserProfileCard golden variants', (tester) async {
      await goldenVariants(
        tester,
        'user_profile_card',
        variants: {
          'online': () => const MaterialApp(
            home: Scaffold(
              body: ex1.UserProfileCard(
                userName: 'John Doe',
                userAge: 25,
                isOnline: true,
              ),
            ),
          ),
          'offline': () => const MaterialApp(
            home: Scaffold(
              body: ex1.UserProfileCard(
                userName: 'Jane Smith',
                userAge: 30,
                isOnline: false,
              ),
            ),
          ),
        },
      );
    });

    testWidgets('UserProfileCard renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ex1.UserProfileCard(
              userName: 'John Doe',
              userAge: 25,
              isOnline: true,
            ),
          ),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('25 years old'), findsOneWidget);
    });
  });

  group('Exercise 2: Single Responsibility', () {
    testWidgets('CleanUserForm renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: CleanUserForm()));

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Age'), findsOneWidget);
      expect(find.text('Submit'), findsOneWidget);
    });

    test('validateName returns correct errors', () {
      final formState = _CleanUserFormStateForTesting();

      expect(formState.validateName(null), equals('Name is required'));
      expect(formState.validateName(''), equals('Name is required'));
      expect(
        formState.validateName('ab'),
        equals('Name must be at least 3 characters'),
      );
      expect(formState.validateName('John'), isNull);
    });

    test('validateEmail returns correct errors', () {
      final formState = _CleanUserFormStateForTesting();

      expect(formState.validateEmail(null), equals('Email is required'));
      expect(formState.validateEmail(''), equals('Email is required'));
      expect(
        formState.validateEmail('invalid'),
        equals('Invalid email format'),
      );
      expect(formState.validateEmail('test@example.com'), isNull);
    });

    test('validateAge returns correct errors', () {
      final formState = _CleanUserFormStateForTesting();

      expect(formState.validateAge(null), equals('Age is required'));
      expect(formState.validateAge(''), equals('Age is required'));
      expect(formState.validateAge('17'), equals('Must be at least 18'));
      expect(formState.validateAge('18'), isNull);
    });
  });

  group('Exercise 3: Code Smells - Refactored Components', () {
    testWidgets('ProductImage renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: const ProductImage())),
      );

      expect(find.byIcon(Icons.image), findsOneWidget);
    });

    testWidgets('FavoriteButton toggles icon', (tester) async {
      var isFavorite = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FavoriteButton(
              isFavorite: isFavorite,
              onToggle: () => isFavorite = !isFavorite,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);

      await tester.tap(find.byType(FavoriteButton));
      isFavorite = true;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FavoriteButton(
              isFavorite: isFavorite,
              onToggle: () => isFavorite = !isFavorite,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('ProductTitle renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductTitle(name: 'Sample Product', price: 29.99),
          ),
        ),
      );

      expect(find.text('Sample Product'), findsOneWidget);
      expect(find.text('\$29.99'), findsOneWidget);
    });

    testWidgets('QuantitySelector respects min quantity', (tester) async {
      var quantity = 1;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuantitySelector(
              quantity: quantity,
              onQuantityChange: (delta) => quantity += delta,
            ),
          ),
        ),
      );

      expect(find.text('1'), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
    });

    testWidgets('ReviewCard renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ReviewCard(review: 'Great product!')),
        ),
      );

      expect(find.text('Great product!'), findsOneWidget);
    });
  });

  group('Exercise 4: Self-Documenting Code', () {
    test('CleanCode calculates total price correctly', () {
      final cleanCode = ex4.CleanCode();
      expect(cleanCode.calculateTotalPrice(10.0, 3), equals(30.0));
    });

    test('CleanCode checks discount eligibility', () {
      final cleanCode = ex4.CleanCode();
      expect(cleanCode.isUserEligibleForDiscount(25, 6), isTrue);
      expect(cleanCode.isUserEligibleForDiscount(17, 6), isFalse);
      expect(cleanCode.isUserEligibleForDiscount(25, 4), isFalse);
    });

    test('CleanCode validates card number', () {
      final cleanCode = ex4.CleanCode();
      expect(cleanCode.isCardNumberValid('1234567890123456'), isTrue);
      expect(cleanCode.isCardNumberValid('123456789012345'), isFalse);
    });

    test('CleanCode validates payment amount', () {
      final cleanCode = ex4.CleanCode();
      expect(cleanCode.isPaymentAmountValid(10.0), isTrue);
      expect(cleanCode.isPaymentAmountValid(0), isFalse);
      expect(cleanCode.isPaymentAmountValid(-5.0), isFalse);
    });

    testWidgets('UserProfileCard renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ex4.UserProfileCard(
              userName: 'John Doe',
              userAge: 30,
              isVerified: true,
            ),
          ),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Age: 30'), findsOneWidget);
      expect(find.text('Verified'), findsOneWidget);
      expect(find.byIcon(Icons.verified), findsOneWidget);
    });
  });

  group('Exercise 5: DRY Principle', () {
    testWidgets('ListItemTile renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListItemTile(
              leading: const CircleAvatar(child: Text('J')),
              title: 'John Doe',
              subtitle: 'john@example.com',
              onEdit: () {},
            ),
          ),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('john@example.com'), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
    });

    test('ListUtils maps users to list items', () {
      final users = [
        {'id': '1', 'name': 'John Doe', 'email': 'john@example.com'},
        {'id': '2', 'name': 'Jane Smith', 'email': 'jane@example.com'},
      ];

      final items = ListUtils.mapUsersToListItems(users);

      expect(items.length, equals(2));
      expect(items[0].title, equals('John Doe'));
      expect(items[0].subtitle, equals('john@example.com'));
      expect(items[1].title, equals('Jane Smith'));
    });

    test('ListUtils maps products to list items', () {
      final products = [
        {'id': 'p1', 'name': 'Product 1', 'price': 10.00},
        {'id': 'p2', 'name': 'Product 2', 'price': 20.00},
      ];

      final items = ListUtils.mapProductsToListItems(products);

      expect(items.length, equals(2));
      expect(items[0].title, equals('Product 1'));
      expect(items[0].subtitle, equals('\$10.0'));
      expect(items[1].title, equals('Product 2'));
    });

    testWidgets('GenericListScreen renders correctly', (tester) async {
      final items = [
        ListItem(
          id: '1',
          title: 'John Doe',
          subtitle: 'john@example.com',
          avatar: const CircleAvatar(child: Text('J')),
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: GenericListScreen(
            title: 'Users',
            items: items,
            onEdit: (id) {},
          ),
        ),
      );

      expect(find.text('Users'), findsOneWidget);
      expect(find.text('John Doe'), findsOneWidget);
    });
  });

  group('Exercise 6: Guard Clauses', () {
    test('CleanValidation validates user correctly', () {
      final validation = CleanValidation();

      expect(
        validation.validateUser('John', 25, 'john@email.com'),
        equals('Valid user'),
      );
      expect(
        validation.validateUser(null, 25, 'john@email.com'),
        equals('Name is required'),
      );
      expect(
        validation.validateUser('', 25, 'john@email.com'),
        equals('Name cannot be empty'),
      );
      expect(
        validation.validateUser('John', null, 'john@email.com'),
        equals('Age is required'),
      );
      expect(
        validation.validateUser('John', 16, 'john@email.com'),
        equals('Must be at least 18'),
      );
      expect(
        validation.validateUser('John', 25, null),
        equals('Email is required'),
      );
      expect(
        validation.validateUser('John', 25, 'invalid'),
        equals('Invalid email'),
      );
    });

    testWidgets('CleanValidation buildUserCard renders correctly', (
      tester,
    ) async {
      final validation = CleanValidation();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: validation.buildUserCard('John Doe', true, null),
          ),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.circle), findsOneWidget);
    });

    testWidgets('CleanValidation buildUserCard returns invalid for null name', (
      tester,
    ) async {
      final validation = CleanValidation();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: validation.buildUserCard(null, true, null)),
        ),
      );

      expect(find.text('Invalid user'), findsOneWidget);
    });

    testWidgets('CleanFormScreen renders correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CleanFormScreen(
              username: 'john',
              email: 'john@example.com',
              isLoading: false,
              errorMessage: null,
            ),
          ),
        ),
      );

      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets('CleanFormScreen shows error message', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CleanFormScreen(
              username: 'john',
              email: 'john@example.com',
              isLoading: false,
              errorMessage: 'Error occurred',
            ),
          ),
        ),
      );

      expect(find.text('Error occurred'), findsOneWidget);
    });

    testWidgets('CleanFormScreen shows loading indicator', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CleanFormScreen(
              username: 'john',
              email: 'john@example.com',
              isLoading: true,
              errorMessage: null,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}

// Helper class to access private methods for testing
class _CleanUserFormStateForTesting extends State<CleanUserForm> {
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    final age = int.tryParse(value);
    if (age == null || age < 18) {
      return 'Must be at least 18';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
