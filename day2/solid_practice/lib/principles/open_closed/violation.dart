// OCP VIOLATION: Modifying existing code for new requirements

class Shape {
  String type;
  double dimension;

  Shape(this.type, this.dimension);
}

class AreaCalculator {
  // VIOLATION: Must modify this method every time a new shape is added
  double calculateArea(Shape shape) {
    if (shape.type == 'circle') {
      return 3.14 * shape.dimension * shape.dimension; // dimension = radius
    } else if (shape.type == 'square') {
      return shape.dimension * shape.dimension; // dimension = side
    } else if (shape.type == 'rectangle') {
      // VIOLATION: Had to modify existing code to add rectangle support
      return shape.dimension *
          shape.dimension *
          0.5; // dimension = width, assume height = width/2
    } else if (shape.type == 'triangle') {
      // VIOLATION: Had to modify existing code again for triangle
      return 0.5 *
          shape.dimension *
          shape.dimension; // dimension = base, assume height = base
    }
    return 0;
  }
}

// Usage example showing the problem
void main() {
  final calculator = AreaCalculator();

  final circle = Shape('circle', 5);
  final square = Shape('square', 4);
  final rectangle = Shape('rectangle', 6);
  final triangle = Shape('triangle', 4);

  print('Circle area: ${calculator.calculateArea(circle)}');
  print('Square area: ${calculator.calculateArea(square)}');
  print('Rectangle area: ${calculator.calculateArea(rectangle)}');
  print('Triangle area: ${calculator.calculateArea(triangle)}');

  // PROBLEM: To add a new shape, we must modify existing AreaCalculator class
  // This violates the Open-Closed Principle
}
