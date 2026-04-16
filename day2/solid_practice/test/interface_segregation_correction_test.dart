import 'package:solid_practice/principles/interface_segregation/correction.dart';
import 'package:test/test.dart';

void main() {
  group('Interface Segregation Principle - Programmer', () {
    test('Programmer implements Workable interface', () {
      final programmer = Programmer();
      expect(programmer, isA<Workable>());
    });

    test('Programmer implements Eatable interface', () {
      final programmer = Programmer();
      expect(programmer, isA<Eatable>());
    });

    test('Programmer implements Sleepable interface', () {
      final programmer = Programmer();
      expect(programmer, isA<Sleepable>());
    });

    test('Programmer implements Attendable interface', () {
      final programmer = Programmer();
      expect(programmer, isA<Attendable>());
    });

    test('Programmer implements CodeReviewable interface', () {
      final programmer = Programmer();
      expect(programmer, isA<CodeReviewable>());
    });

    test('Programmer implements Documentable interface', () {
      final programmer = Programmer();
      expect(programmer, isA<Documentable>());
    });

    test('Programmer does not implement Manageable', () {
      final programmer = Programmer();
      expect(programmer, isNot(isA<Manageable>()));
    });

    test('Programmer does not implement Accountable', () {
      final programmer = Programmer();
      expect(programmer, isNot(isA<Accountable>()));
    });
  });

  group('Interface Segregation Principle - Manager', () {
    test('Manager implements Workable interface', () {
      final manager = Manager();
      expect(manager, isA<Workable>());
    });

    test('Manager implements Manageable interface', () {
      final manager = Manager();
      expect(manager, isA<Manageable>());
    });

    test('Manager does not implement CodeReviewable', () {
      final manager = Manager();
      expect(manager, isNot(isA<CodeReviewable>()));
    });

    test('Manager does not implement Accountable', () {
      final manager = Manager();
      expect(manager, isNot(isA<Accountable>()));
    });
  });

  group('Interface Segregation Principle - Accountant', () {
    test('Accountant implements Workable interface', () {
      final accountant = Accountant();
      expect(accountant, isA<Workable>());
    });

    test('Accountant implements Accountable interface', () {
      final accountant = Accountant();
      expect(accountant, isA<Accountable>());
    });

    test('Accountant does not implement CodeReviewable', () {
      final accountant = Accountant();
      expect(accountant, isNot(isA<CodeReviewable>()));
    });

    test('Accountant does not implement Manageable', () {
      final accountant = Accountant();
      expect(accountant, isNot(isA<Manageable>()));
    });
  });

  group('Interface Segregation Principle - Focused Interfaces', () {
    test('Each interface has a single responsibility', () {
      // Workable - work related
      // Eatable - eating related
      // Sleepable - sleeping related
      // Attendable - meeting related
      // CodeReviewable - code review related
      // Documentable - documentation related
      // Manageable - management related
      // Accountable - accounting related

      // Each class only implements what it needs
      final programmer = Programmer();
      final manager = Manager();
      final accountant = Accountant();

      // Common interfaces
      expect(programmer, isA<Workable>());
      expect(manager, isA<Workable>());
      expect(accountant, isA<Workable>());

      // Specialized interfaces
      expect(programmer, isA<CodeReviewable>());
      expect(manager, isA<Manageable>());
      expect(accountant, isA<Accountable>());
    });
  });

  group('Interface Segregation Principle - No Unnecessary Methods', () {
    test('Programmer is not forced to implement manageTeam', () {
      // Programmer doesn't need to implement manageTeam
      // because it doesn't implement Manageable interface
      final programmer = Programmer();
      expect(programmer, isNot(isA<Manageable>()));
    });

    test('Manager is not forced to implement codeReview', () {
      // Manager doesn't need to implement codeReview
      // because it doesn't implement CodeReviewable interface
      final manager = Manager();
      expect(manager, isNot(isA<CodeReviewable>()));
    });

    test('Accountant is not forced to implement manageTeam', () {
      // Accountant doesn't need to implement manageTeam
      // because it doesn't implement Manageable interface
      final accountant = Accountant();
      expect(accountant, isNot(isA<Manageable>()));
    });
  });
}
