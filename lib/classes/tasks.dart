import 'package:calendario/classes/funs.dart';

import 'events.dart';

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

class TaskList {
  final List<Task> _tasks = [];
  final Event event;

  TaskList(this.event);

  bool Function(Task it) _byId(String id) => (it) => it.id == id;

  void _refreshPositions({String? id}) {
    if (id != null) {
      Task t = _tasks.firstWhere(_byId(id));
      int keep = _tasks.indexWhere(_byId(id));
      for (Task it in _tasks) {
        if (it.position >= keep) {
          it.position++;
        }
      }
      t.position = keep;
    }
    _tasks.sort((a, b) => a.position.compareTo(b.position));
    for (int i = 0; i < _tasks.length; i++) {
      _tasks[i].position = i;
    }
    event.notifyChanges();
  }

  void incorporate(Task task) {
    var aux = _tasks.where(_byId(task.id));
    if (aux.isEmpty) {
      _tasks.add(task);
    } else {
      aux.first
        ..description = task.description
        ..isComplete = task.isComplete
        ..position = task.position;
      task = aux.first;
    }
    _refreshPositions(id: task.id);
  }

  void incorporateAll(List<Task> tasks) {
    for (Task it in tasks) {
      incorporate(it);
    }
  }

  void removeAt(int position) {
    _tasks.removeAt(position);
    _refreshPositions();
  }

  void removeId(String id) {
    _tasks.removeWhere((it) => it.id == id);
    _refreshPositions();
  }

  void updateById(String id,
      {int? position, String? description, bool? isComplete}) {
    Task task = _tasks.firstWhere(_byId(id));
    if (position != null) {
      task.position = position;
      _refreshPositions(id: task.id);
      event.notifyChanges();
    }
    if (description != null) {
      task.description = description;
      event.notifyChanges();
    }
    if (isComplete != null) {
      task.isComplete = isComplete;
      event.notifyChanges();
    }
  }

  void updateAt(int position, {String? description, bool? isComplete}) {
    updateById(_tasks[position].id,
        description: description, isComplete: isComplete);
  }

  void clear() {
    _tasks.clear();
    event.notifyChanges();
  }

  Task operator [](int index) {
    Task task;
    try {
      task = _tasks[index];
    } catch (e) {
      task = _tasks.last;
    }
    return Task(task.id, task.position, task.description, task.isComplete);
  }

  void operator []=(int index, Task value) {
    updateAt(index,
        description: value.description, isComplete: value.isComplete);
  }

  int get size => _tasks.length;

  void addTask(Task task) {
    task.position = size;
    incorporate(task);
  }

  void addNewTask(String description) =>
      addTask(Task.newTask(0, description, false));

  List<Task> toList() {
    List<Task> list = [];
    for (int i = 0; i < _tasks.length; i++) {
      list.add(this[i]);
    }
    return list;
  }
}
