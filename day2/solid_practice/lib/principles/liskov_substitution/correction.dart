// LSP CORRECTION: Subtypes can be properly substituted for base types

// CORRECTION: Use abstract base class to define contract
abstract class Shape {
  double getArea();
}

// Rectangle implementation
class Rectangle implements Shape {
  double width;
  double height;

  Rectangle(this.width, this.height);

  void setWidth(double width) {
    this.width = width;
  }

  void setHeight(double height) {
    this.height = height;
  }

  @override
  double getArea() {
    return width * height;
  }
}

// Square as separate class, not inheriting from Rectangle
class Square implements Shape {
  double side;

  Square(this.side);

  void setSide(double side) {
    this.side = side;
  }

  @override
  double getArea() {
    return side * side;
  }
}

// Usage example showing LSP compliance
void main() {
  print('=== Shape LSP Correction ===');

  List<Shape> shapes = [Rectangle(5, 4), Square(5)];

  for (Shape shape in shapes) {
    print('${shape.runtimeType} area: ${shape.getArea()}');
  }
  print('SOLUTION: All shapes can be substituted without breaking behavior');
  print(
    'LSP Fixed: Square and Rectangle implement same interface independently',
  );
}
