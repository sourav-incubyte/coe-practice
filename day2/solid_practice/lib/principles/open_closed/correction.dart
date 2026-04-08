// OCP CORRECTION: Open for extension, closed for modification

// Abstract base class - open for extension
abstract class Shape {
  double calculateArea();
}

// Concrete implementations - extend without modifying existing code
class Circle implements Shape {
  final double radius;

  Circle(this.radius);

  @override
  double calculateArea() => 3.14 * radius * radius;
}

class Square implements Shape {
  final double side;

  Square(this.side);

  @override
  double calculateArea() => side * side;
}

// NEW SHAPE: Can add without modifying existing code
class Rectangle implements Shape {
  final double width;
  final double height;

  Rectangle(this.width, this.height);

  @override
  double calculateArea() => width * height;
}

// NEW SHAPE: Can add without modifying existing code
class Triangle implements Shape {
  final double base;
  final double height;

  Triangle(this.base, this.height);

  @override
  double calculateArea() => 0.5 * base * height;
}

// Classes that work with shapes - closed for modification
class AreaCalculator {
  // No need to modify this method for new shapes
  double calculateTotalArea(List<Shape> shapes) {
    return shapes.fold(0, (total, shape) => total + shape.calculateArea());
  }
}

// Usage example showing the solution
void main() {
  final calculator = AreaCalculator();

  // Create shapes
  final shapes = [Circle(5), Square(4), Rectangle(6, 3), Triangle(4, 5)];

  print('=== Individual Shape Areas ===');
  for (final shape in shapes) {
    print('${shape.runtimeType}: ${shape.calculateArea()}');
  }

  print('\n=== Total Area ===');
  print('Total area: ${calculator.calculateTotalArea(shapes)}');

  // SOLUTION: New shapes can be added without modifying existing classes
  // This follows the Open-Closed Principle
}
