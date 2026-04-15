// ISP VIOLATION: Fat interface that forces clients to implement unnecessary methods

// VIOLATION: Too many responsibilities in one interface
abstract class Worker {
  void work();
  void eat();
  void sleep();
  void attendMeeting();
  void codeReview();
  void writeDocumentation();
  void manageTeam();
  void doAccounting();
}

class Programmer implements Worker {
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

  @override
  void manageTeam() {
    // VIOLATION: Programmer doesn't manage team but forced to implement
    throw Exception('Programmers cannot manage team');
  }

  @override
  void doAccounting() {
    // VIOLATION: Programmer doesn't do accounting but forced to implement
    throw Exception('Programmers cannot do accounting');
  }
}

class Manager implements Worker {
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
  void codeReview() {
    // VIOLATION: Manager doesn't code review but forced to implement
    throw Exception('Managers cannot do code review');
  }

  @override
  void writeDocumentation() {
    print('Manager writing project documentation');
  }

  @override
  void manageTeam() {
    print('Manager managing team');
  }

  @override
  void doAccounting() {
    // VIOLATION: Manager doesn't do accounting but forced to implement
    throw Exception('Managers cannot do accounting');
  }
}

class Accountant implements Worker {
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
  void codeReview() {
    // VIOLATION: Accountant doesn't code review but forced to implement
    throw Exception('Accountants cannot do code review');
  }

  @override
  void writeDocumentation() {
    print('Accountant writing financial reports');
  }

  @override
  void manageTeam() {
    // VIOLATION: Accountant doesn't manage team but forced to implement
    throw Exception('Accountants cannot manage team');
  }

  @override
  void doAccounting() {
    print('Accountant doing accounting work');
  }
}

// Usage example showing ISP violations
void main() {
  print('=== Interface Segregation Principle Violation ===');

  List<Worker> workers = [Programmer(), Manager(), Accountant()];

  for (Worker worker in workers) {
    print('\n--- ${worker.runtimeType} ---');
    try {
      worker.work();
      worker.eat();
      worker.sleep();
      worker.attendMeeting();
      worker.codeReview();
      worker.writeDocumentation();
      worker.manageTeam();
      worker.doAccounting();
    } catch (e) {
      print('Error: $e');
    }
  }

  print(
    '\nPROBLEM: Fat interface forces clients to implement unnecessary methods',
  );
  print(
    'ISP VIOLATION: Each worker is forced to implement methods they don\'t use',
  );
}
