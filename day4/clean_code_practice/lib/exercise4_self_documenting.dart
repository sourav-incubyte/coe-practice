import 'package:flutter/material.dart';

// EXERCISE 4: Comment Smells & Self-Documenting Code
// PROBLEM: Code needs comments to be understood
// TASK: Remove comments by improving code clarity

// ===== COMMENT SMELLS (Before) =====
class BadCode {
  // This function calculates the total price
  // It takes the price and quantity
  // Returns the total
  double calculateTotal(double price, int quantity) {
    // Multiply price by quantity
    double result = price * quantity;
    // Return the result
    return result;
  }

  // Check if user is eligible for discount
  // User must be over 18 and have more than 5 purchases
  bool isEligibleForDiscount(int age, int purchaseCount) {
    // Check age
    if (age < 18) {
      return false;
    }
    // Check purchase count
    if (purchaseCount < 5) {
      return false;
    }
    // Return true if both conditions met
    return true;
  }

  // Process payment
  // This handles the payment logic
  // Returns true if successful
  bool processPayment(double amount, String cardNumber) {
    // Validate card number
    if (cardNumber.length != 16) {
      return false;
    }
    // Validate amount
    if (amount <= 0) {
      return false;
    }
    // Process payment
    // In real app, this would call payment gateway
    return true;
  }
}

// ===== SELF-DOCUMENTING CODE (After) =====
class CleanCode {
  double calculateTotalPrice(double unitPrice, int quantity) {
    return unitPrice * quantity;
  }

  bool isUserEligibleForDiscount(int userAge, int totalPurchases) {
    return userAge >= 18 && totalPurchases >= 5;
  }

  bool isCardNumberValid(String cardNumber) {
    return cardNumber.length == 16;
  }

  bool isPaymentAmountValid(double amount) {
    return amount > 0;
  }

  bool processPayment(double amount, String cardNumber) {
    return isCardNumberValid(cardNumber) && isPaymentAmountValid(amount);
  }
}

// ===== FLUTTER WIDGET EXAMPLE =====

// BEFORE: Needs comments
class BadUserWidget extends StatelessWidget {
  final String n; // User name
  final int a; // User age
  final bool v; // Is verified

  const BadUserWidget({
    required this.n,
    required this.a,
    required this.v,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Card styling
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      // User info
      child: Column(
        children: [
          // Name
          Text(n),
          // Age
          Text('Age: $a'),
          // Verification status
          if (v) const Text('Verified'),
        ],
      ),
    );
  }
}

// AFTER: Self-documenting
class UserProfileCard extends StatelessWidget {
  final String userName;
  final int userAge;
  final bool isVerified;

  const UserProfileCard({
    required this.userName,
    required this.userAge,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userName, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('Age: $userAge'),
          if (isVerified)
            const Row(
              children: [
                Icon(Icons.verified, size: 16, color: Colors.green),
                SizedBox(width: 4),
                Text('Verified', style: TextStyle(color: Colors.green)),
              ],
            ),
        ],
      ),
    );
  }
}

// ===== DEMO APP =====
class SelfDocumentingExerciseApp extends StatelessWidget {
  const SelfDocumentingExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Self-Documenting Code Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const SelfDocumentingScreen(),
    );
  }
}

class SelfDocumentingScreen extends StatelessWidget {
  const SelfDocumentingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cleanCode = CleanCode();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4: Self-Documenting Code'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Comment Smells vs Self-Documenting Code',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'BEFORE (needs comments):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 10),
            const Text('calculateTotal(price, quantity)'),
            const Text('// This function calculates the total price'),
            const SizedBox(height: 20),
            const Text(
              'AFTER (self-documenting):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 10),
            const Text('calculateTotalPrice(unitPrice, quantity)'),
            const Text('// No comment needed - name explains itself'),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Example Results:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Total Price: \$${cleanCode.calculateTotalPrice(10.0, 3)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Eligible for Discount: ${cleanCode.isUserEligibleForDiscount(25, 6)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            const Text(
              'User Profile Card:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            UserProfileCard(
              userName: 'John Doe',
              userAge: 30,
              isVerified: true,
            ),
          ],
        ),
      ),
    );
  }
}
