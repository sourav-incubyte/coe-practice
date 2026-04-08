// LSP VIOLATION: Subtypes cannot be substituted for base types

class Rectangle {
  double width;
  double height;

  Rectangle(this.width, this.height);

  void setWidth(double width) {
    this.width = width;
  }

  void setHeight(double height) {
    this.height = height;
  }

  double getArea() {
    return width * height;
  }
}

// VIOLATION: Square breaks LSP because it cannot be substituted for Rectangle
class Square extends Rectangle {
  Square(double size) : super(size, size);

  @override
  void setWidth(double width) {
    super.setWidth(width);
    super.setHeight(width); // Square must maintain equal sides
  }

  @override
  void setHeight(double height) {
    super.setHeight(height);
    super.setWidth(height); // Square must maintain equal sides
  }
}

// Usage example showing LSP violation
void main() {
  print('=== Rectangle/Square LSP Violation ===');

  // This works fine with Rectangle
  Rectangle rect = Rectangle(5, 4);
  rect.setWidth(10);
  print('Rectangle area: ${rect.getArea()}'); // Expected: 10 * 4 = 40

  // This breaks with Square substitution
  Rectangle square = Square(5);
  square.setWidth(10);
  print(
    'Square area: ${square.getArea()}',
  ); // Expected: 10 * 5 = 50, but actual: 10 * 10 = 100
  print('PROBLEM: Square behavior is inconsistent with Rectangle expectations');
  print(
    'LSP Violation: Square cannot be substituted for Rectangle without breaking behavior',
  );
}
