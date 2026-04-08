// ISP CORRECTION: Split fat interfaces into focused, client-specific interfaces

// CORRECTION: Small, focused interfaces
abstract class Workable {
  void work();
}

abstract class Eatable {
  void eat();
}

abstract class Sleepable {
  void sleep();
}

abstract class Attendable {
  void attendMeeting();
}

abstract class CodeReviewable {
  void codeReview();
}

abstract class Documentable {
  void writeDocumentation();
}

abstract class Manageable {
  void manageTeam();
}

abstract class Accountable {
  void doAccounting();
}

// CORRECTION: Classes implement only interfaces they need
class Programmer
    implements
        Workable,
        Eatable,
        Sleepable,
        Attendable,
        CodeReviewable,
        Documentable {
  @override
  void work() {
    print('Programmer is coding');
  }

  @override
  void eat() {
    print('Programmer is eating lunch');
  }

  @override
  void sleep() {
    print('Programmer is sleeping');
  }

  @override
  void attendMeeting() {
    print('Programmer attending team meeting');
  }

  @override
  void codeReview() {
    print('Programmer reviewing code');
  }

  @override
  void writeDocumentation() {
    print('Programmer writing documentation');
  }
}

class Manager
    implements
        Workable,
        Eatable,
        Sleepable,
        Attendable,
        Documentable,
        Manageable {
  @override
  void work() {
    print('Manager is managing projects');
  }

  @override
  void eat() {
    print('Manager is eating lunch');
  }

  @override
  void sleep() {
    print('Manager is sleeping');
  }

  @override
  void attendMeeting() {
    print('Manager attending executive meeting');
  }

  @override
  void writeDocumentation() {
    print('Manager writing project documentation');
  }

  @override
  void manageTeam() {
    print('Manager managing team');
  }
}

class Accountant
    implements
        Workable,
        Eatable,
        Sleepable,
        Attendable,
        Documentable,
        Accountable {
  @override
  void work() {
    print('Accountant is managing finances');
  }

  @override
  void eat() {
    print('Accountant is eating lunch');
  }

  @override
  void sleep() {
    print('Accountant is sleeping');
  }

  @override
  void attendMeeting() {
    print('Accountant attending finance meeting');
  }

  @override
  void writeDocumentation() {
    print('Accountant writing financial reports');
  }

  @override
  void doAccounting() {
    print('Accountant doing accounting work');
  }
}

// Usage example showing ISP compliance
void main() {
  print('=== Interface Segregation Principle Correction ===');

  final programmer = Programmer();
  final manager = Manager();
  final accountant = Accountant();

  // Each worker only implements interfaces they actually need
  print('Programmer:');
  programmer.work();
  programmer.codeReview();

  print('Manager:');
  manager.work();
  manager.manageTeam();

  print('Accountant:');
  accountant.work();
  accountant.doAccounting();

  print(
    '\nSOLUTION: Small, focused interfaces prevent unnecessary method implementations',
  );
  print('ISP FIXED: Clients depend only on interfaces they actually use');
}
