import 'package:calendario/classes/funs.dart';

class Task {
  late String id;
  late int position;
  late String description;
  late bool isComplete;

  Task(this.id, this.position, this.description, this.isComplete);
  Task.newTask(this.position, this.description, this.isComplete) {
    id = buildId();
  }
}
