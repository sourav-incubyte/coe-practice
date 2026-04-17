import 'package:fizzbuzz/fizzbuzz.dart';
import 'package:test/test.dart';

void main() {
  test('fizzbuzz returns number as string', () {
    expect(fizzbuzz(1), '1');
  });

  test('fizzbuzz returns fizz for multiples of 3', () {
    expect(fizzbuzz(3), 'fizz');
  });
  
  test('fizzbuzz returns buzz for multiples of 5', () {
    expect(fizzbuzz(5), 'buzz');
  });
  
  test('fizzbuzz returns fizzbuzz for multiples of 3 and 5', () {
    expect(fizzbuzz(15), 'fizzbuzz');
  });

}
