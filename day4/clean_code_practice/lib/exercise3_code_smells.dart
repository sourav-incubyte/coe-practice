import 'package:flutter/material.dart';

// EXERCISE 3: Code Smells - God Widget & Deep Nesting
// PROBLEM: One widget doing too much, deeply nested code
// TASK: Break into smaller, focused components

// ===== GOD WIDGET (Before) =====
class ProductPageWidget extends StatefulWidget {
  const ProductPageWidget({super.key});

  @override
  State<ProductPageWidget> createState() => _ProductPageWidgetState();
}

class _ProductPageWidgetState extends State<ProductPageWidget> {
  String productName = 'Sample Product';
  double price = 29.99;
  int quantity = 1;
  bool isFavorite = false;
  bool isLoading = false;
  List<String> reviews = ['Great!', 'Awesome!', 'Love it!'];
  String selectedSize = 'M';
  List<String> sizes = ['S', 'M', 'L', 'XL'];
  String selectedColor = 'Red';
  List<String> colors = ['Red', 'Blue', 'Green'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              color: Colors.grey[200],
              child: const Center(
                child: Icon(Icons.image, size: 100, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$$price',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Select Size:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: sizes
                        .map(
                          (size) => ChoiceChip(
                            label: Text(size),
                            selected: selectedSize == size,
                            onSelected: (selected) {
                              setState(() {
                                selectedSize = size;
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Select Color:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: colors
                        .map(
                          (color) => ChoiceChip(
                            label: Text(color),
                            selected: selectedColor == color,
                            onSelected: (selected) {
                              setState(() {
                                selectedColor = color;
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: quantity > 1
                            ? () {
                                setState(() {
                                  quantity--;
                                });
                              }
                            : null,
                      ),
                      Text('$quantity'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              setState(() => isLoading = true);
                              Future.delayed(const Duration(seconds: 2), () {
                                setState(() => isLoading = false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Added to cart!'),
                                  ),
                                );
                              });
                            },
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Add to Cart'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Reviews:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...reviews.map(
                    (review) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(review),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== REFACTORED (After) =====
// Breaking the god widget into focused components

class CleanProductPage extends StatefulWidget {
  const CleanProductPage({super.key});

  @override
  State<CleanProductPage> createState() => _CleanProductPageState();
}

class _CleanProductPageState extends State<CleanProductPage> {
  String productName = 'Sample Product';
  double price = 29.99;
  int quantity = 1;
  bool isFavorite = false;
  bool isLoading = false;
  List<String> reviews = ['Great!', 'Awesome!', 'Love it!'];
  String selectedSize = 'M';
  String selectedColor = 'Red';

  void toggleFavorite() {
    setState(() => isFavorite = !isFavorite);
  }

  void updateQuantity(int delta) {
    setState(() {
      quantity = (quantity + delta).clamp(1, 10);
    });
  }

  Future<void> addToCart() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => isLoading = false);
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Added to cart!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
        actions: [
          FavoriteButton(isFavorite: isFavorite, onToggle: toggleFavorite),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProductImage(),
            ProductDetails(
              productName: productName,
              price: price,
              selectedSize: selectedSize,
              onSizeSelected: (size) => setState(() => selectedSize = size),
              selectedColor: selectedColor,
              onColorSelected: (color) => setState(() => selectedColor = color),
              quantity: quantity,
              onQuantityChange: updateQuantity,
              isLoading: isLoading,
              onAddToCart: addToCart,
            ),
            ProductReviews(reviews: reviews),
          ],
        ),
      ),
    );
  }
}

// Extracted focused components
class ProductImage extends StatelessWidget {
  const ProductImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.image, size: 100, color: Colors.grey),
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onToggle;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
      onPressed: onToggle,
    );
  }
}

class ProductDetails extends StatelessWidget {
  final String productName;
  final double price;
  final String selectedSize;
  final ValueChanged<String> onSizeSelected;
  final String selectedColor;
  final ValueChanged<String> onColorSelected;
  final int quantity;
  final ValueChanged<int> onQuantityChange;
  final bool isLoading;
  final VoidCallback onAddToCart;

  const ProductDetails({
    super.key,
    required this.productName,
    required this.price,
    required this.selectedSize,
    required this.onSizeSelected,
    required this.selectedColor,
    required this.onColorSelected,
    required this.quantity,
    required this.onQuantityChange,
    required this.isLoading,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductTitle(name: productName, price: price),
          SizeSelector(
            selectedSize: selectedSize,
            onSizeSelected: onSizeSelected,
          ),
          ColorSelector(
            selectedColor: selectedColor,
            onColorSelected: onColorSelected,
          ),
          QuantitySelector(
            quantity: quantity,
            onQuantityChange: onQuantityChange,
          ),
          AddToCartButton(isLoading: isLoading, onPressed: onAddToCart),
        ],
      ),
    );
  }
}

class ProductTitle extends StatelessWidget {
  final String name;
  final double price;

  const ProductTitle({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          '\$$price',
          style: const TextStyle(
            fontSize: 20,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class SizeSelector extends StatelessWidget {
  final String selectedSize;
  final ValueChanged<String> onSizeSelected;

  const SizeSelector({
    super.key,
    required this.selectedSize,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = ['S', 'M', 'L', 'XL'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Size:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: sizes
              .map(
                (size) => ChoiceChip(
                  label: Text(size),
                  selected: selectedSize == size,
                  onSelected: (_) => onSizeSelected(size),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class ColorSelector extends StatelessWidget {
  final String selectedColor;
  final ValueChanged<String> onColorSelected;

  const ColorSelector({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ['Red', 'Blue', 'Green'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Color:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: colors
              .map(
                (color) => ChoiceChip(
                  label: Text(color),
                  selected: selectedColor == color,
                  onSelected: (_) => onColorSelected(color),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onQuantityChange;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onQuantityChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: quantity > 1 ? () => onQuantityChange(-1) : null,
        ),
        Text('$quantity'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => onQuantityChange(1),
        ),
      ],
    );
  }
}

class AddToCartButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const AddToCartButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const CircularProgressIndicator()
            : const Text('Add to Cart'),
      ),
    );
  }
}

class ProductReviews extends StatelessWidget {
  final List<String> reviews;

  const ProductReviews({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reviews:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...reviews.map((review) => ReviewCard(review: review)),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        child: Padding(padding: const EdgeInsets.all(8), child: Text(review)),
      ),
    );
  }
}

// ===== DEMO APP =====
class CodeSmellsExerciseApp extends StatelessWidget {
  const CodeSmellsExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Smells Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const CleanProductPage(),
    );
  }
}
