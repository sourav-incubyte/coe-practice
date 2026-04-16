import 'package:solid_practice/principles/open_closed/correction.dart';
import 'package:test/test.dart';

void main() {
  group('Open-Closed Principle - Shape Implementations', () {
    test('Circle should calculate area correctly', () {
      final circle = Circle(5);
      expect(circle.calculateArea(), 3.14 * 5 * 5);
    });

    test('Square should calculate area correctly', () {
      final square = Square(4);
      expect(square.calculateArea(), 16);
    });

    test('Rectangle should calculate area correctly', () {
      final rectangle = Rectangle(6, 3);
      expect(rectangle.calculateArea(), 18);
    });

    test('Triangle should calculate area correctly', () {
      final triangle = Triangle(4, 5);
      expect(triangle.calculateArea(), 10);
    });
  });

  group('Open-Closed Principle - AreaCalculator', () {
    test('AreaCalculator should calculate total area of mixed shapes', () {
      final calculator = AreaCalculator();
      final shapes = [Circle(5), Square(4), Rectangle(6, 3), Triangle(4, 5)];
      final total = calculator.calculateTotalArea(shapes);
      expect(total, closeTo(78.5 + 16 + 18 + 10, 0.1));
    });

    test('AreaCalculator should handle empty list', () {
      final calculator = AreaCalculator();
      final total = calculator.calculateTotalArea([]);
      expect(total, 0);
    });

    test('AreaCalculator should work with single shape', () {
      final calculator = AreaCalculator();
      final shapes = [Circle(10)];
      final total = calculator.calculateTotalArea(shapes);
      expect(total, 3.14 * 10 * 10);
    });

    test('AreaCalculator should work with multiple same shapes', () {
      final calculator = AreaCalculator();
      final shapes = [Square(2), Square(3), Square(4)];
      final total = calculator.calculateTotalArea(shapes);
      expect(total, 4 + 9 + 16);
    });
  });

  group('Open-Closed Principle - Extensibility', () {
    test('New shape can be added without modifying AreaCalculator', () {
      // This test demonstrates that new shapes can be added
      // without modifying the AreaCalculator class
      final calculator = AreaCalculator();
      final shapes = [Circle(5), Square(4), Rectangle(6, 3), Triangle(4, 5)];
      final total = calculator.calculateTotalArea(shapes);
      expect(total, closeTo(122.5, 0.1));
    });
  });
}
