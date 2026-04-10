import 'package:flutter/material.dart';

// EXERCISE 5: DRY Principle & Avoiding Duplication
// PROBLEM: Repeated code patterns
// TASK: Extract into reusable utilities

// ===== VIOLATING DRY (Before) =====
class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(child: Text('J')),
            title: const Text('John Doe'),
            subtitle: const Text('john@example.com'),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
          ),
          ListTile(
            leading: const CircleAvatar(child: Text('J')),
            title: const Text('Jane Smith'),
            subtitle: const Text('jane@example.com'),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
          ),
          ListTile(
            leading: const CircleAvatar(child: Text('B')),
            title: const Text('Bob Johnson'),
            subtitle: const Text('bob@example.com'),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.shopping_bag)),
            title: const Text('Product 1'),
            subtitle: const Text('\$10.00'),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
          ),
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.shopping_bag)),
            title: const Text('Product 2'),
            subtitle: const Text('\$20.00'),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

// ===== DRY COMPLIANT (After) =====

// Reusable widget component
class ListItemTile extends StatelessWidget {
  final Widget leading;
  final String title;
  final String subtitle;
  final VoidCallback onEdit;

  const ListItemTile({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: onEdit,
      ),
    );
  }
}

// Reusable data model
class ListItem {
  final String id;
  final String title;
  final String subtitle;
  final Widget avatar;

  ListItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.avatar,
  });
}

// Reusable list widget
class GenericListScreen extends StatelessWidget {
  final String title;
  final List<ListItem> items;
  final ValueChanged<String> onEdit;

  const GenericListScreen({
    super.key,
    required this.title,
    required this.items,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListItemTile(
            leading: item.avatar,
            title: item.title,
            subtitle: item.subtitle,
            onEdit: () => onEdit(item.id),
          );
        },
      ),
    );
  }
}

// Utility functions
class ListUtils {
  static List<ListItem> mapUsersToListItems(List<Map<String, dynamic>> users) {
    return users.map((user) {
      return ListItem(
        id: user['id'],
        title: user['name'],
        subtitle: user['email'],
        avatar: CircleAvatar(child: Text(user['name'][0])),
      );
    }).toList();
  }

  static List<ListItem> mapProductsToListItems(List<Map<String, dynamic>> products) {
    return products.map((product) {
      return ListItem(
        id: product['id'],
        title: product['name'],
        subtitle: '\$${product['price']}',
        avatar: const CircleAvatar(child: Icon(Icons.shopping_bag)),
      );
    }).toList();
  }
}

// ===== DEMO APP =====
class DryPrincipleExerciseApp extends StatelessWidget {
  const DryPrincipleExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    final users = [
      {'id': '1', 'name': 'John Doe', 'email': 'john@example.com'},
      {'id': '2', 'name': 'Jane Smith', 'email': 'jane@example.com'},
      {'id': '3', 'name': 'Bob Johnson', 'email': 'bob@example.com'},
    ];

    final products = [
      {'id': 'p1', 'name': 'Product 1', 'price': 10.00},
      {'id': 'p2', 'name': 'Product 2', 'price': 20.00},
      {'id': 'p3', 'name': 'Product 3', 'price': 30.00},
    ];

    return MaterialApp(
      title: 'DRY Principle Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: DryPrincipleScreen(
        users: users,
        products: products,
      ),
    );
  }
}

class DryPrincipleScreen extends StatelessWidget {
  final List<Map<String, dynamic>> users;
  final List<Map<String, dynamic>> products;

  const DryPrincipleScreen({
    super.key,
    required this.users,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5: DRY Principle'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'DRY Principle - Don\'t Repeat Yourself',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'BEFORE: Repeated ListTile code',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            const SizedBox(height: 10),
            const Text('UserListScreen: Custom ListTile x3'),
            const Text('ProductListScreen: Custom ListTile x2'),
            const SizedBox(height: 20),
            const Text(
              'AFTER: Reusable components',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
            const SizedBox(height: 10),
            const Text('ListItemTile: Single reusable component'),
            const Text('GenericListScreen: Generic list implementation'),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Example: Generic List Component',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(text: 'Users'),
                        Tab(text: 'Products'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          GenericListScreen(
                            title: 'Users',
                            items: ListUtils.mapUsersToListItems(users),
                            onEdit: (id) => print('Edit user: $id'),
                          ),
                          GenericListScreen(
                            title: 'Products',
                            items: ListUtils.mapProductsToListItems(products),
                            onEdit: (id) => print('Edit product: $id'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
