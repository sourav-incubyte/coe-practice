import 'package:solid_practice/principles/liskov_substitution/correction.dart';
import 'package:test/test.dart';

void main() {
  group('Liskov Substitution Principle - Rectangle', () {
    test('Rectangle should calculate area correctly', () {
      final rectangle = Rectangle(5, 4);
      expect(rectangle.getArea(), 20);
    });

    test('Rectangle should allow setting width and height independently', () {
      final rectangle = Rectangle(5, 4);
      rectangle.setWidth(10);
      rectangle.setHeight(6);
      expect(rectangle.width, 10);
      expect(rectangle.height, 6);
      expect(rectangle.getArea(), 60);
    });
  });

  group('Liskov Substitution Principle - Square', () {
    test('Square should calculate area correctly', () {
      final square = Square(5);
      expect(square.getArea(), 25);
    });

    test('Square should allow setting side', () {
      final square = Square(5);
      square.setSide(10);
      expect(square.side, 10);
      expect(square.getArea(), 100);
    });
  });

  group('Liskov Substitution Principle - Substitution', () {
    test('Rectangle and Square can be used interchangeably as Shape', () {
      List<Shape> shapes = [Rectangle(5, 4), Square(5)];

      for (var shape in shapes) {
        // Both can call getArea() without breaking
        expect(shape.getArea(), isA<double>());
      }
    });

    test('List of shapes calculates correct areas', () {
      List<Shape> shapes = [Rectangle(5, 4), Square(5)];

      final areas = shapes.map((s) => s.getArea()).toList();
      expect(areas[0], 20); // Rectangle
      expect(areas[1], 25); // Square
    });

    test('Shape interface ensures consistent behavior', () {
      Shape rectangle = Rectangle(5, 4);
      Shape square = Square(5);

      // Both implement the same contract
      expect(rectangle.getArea() >= 0, true);
      expect(square.getArea() >= 0, true);
    });
  });

  group('Liskov Substitution Principle - No Inheritance Issues', () {
    test('Square does not inherit from Rectangle, avoiding LSP violation', () {
      // Square and Rectangle are independent classes
      // Both implement Shape interface
      final rectangle = Rectangle(5, 4);
      final square = Square(5);

      // Rectangle can change dimensions independently
      rectangle.setWidth(10);
      expect(rectangle.width, 10);
      expect(rectangle.height, 4); // Height unchanged

      // Square only has side property
      square.setSide(10);
      expect(square.side, 10);

      // This demonstrates no LSP violation
    });
  });
}
