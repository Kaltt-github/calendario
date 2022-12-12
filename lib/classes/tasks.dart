import 'dart:math';

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
  final Event father;

  TaskList(this.father);

  bool Function(Task it) _byId(String id) => (it) => it.id == id;

  void _refreshPositions(String idKeep) {
    Task t = _tasks.firstWhere(_byId(idKeep));
    int keep = _tasks.indexWhere(_byId(idKeep));
    for (Task it in _tasks) {
      if (it.position >= keep) {
        it.position++;
      }
    }
    t.position = keep;
    _tasks.sort((a, b) => a.position.compareTo(b.position));
    for (int i = 0; i < _tasks.length; i++) {
      _tasks[i].position = i;
    }
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
    _refreshPositions(task.id);
  }

  void incorporateAll(List<Task> tasks) {
    for (Task it in tasks) {
      incorporate(it);
    }
  }

  void removeAt(int position) {
    _tasks.removeAt(position);
    for (var i = 0; i < _tasks.length; i++) {
      _tasks[i].position = i;
    }
  }

  void removeId(String id) => removeAt(_tasks.firstWhere(_byId(id)).position);

  void updateId(String id,
      {int? position, String? description, bool? isComplete}) {
    Task task = _tasks.firstWhere(_byId(id));
    if (position != null) {
      for (Task it in _tasks) {
        if (it.position >= position) {
          it.position++;
        }
      }
      task.position = position;
      _tasks.sort((a, b) => a.position.compareTo(b.position));
      for (int i = 0; i < _tasks.length; i++) {
        _tasks[i].position = i;
      }
    }
    if (description != null) {
      task.description = description;
    }
    if (isComplete != null) {
      task.isComplete = isComplete;
    }
  }

  void updateAt(int position, {String? description, bool? isComplete}) {
    updateId(_tasks[position].id,
        description: description, isComplete: isComplete);
  }

  void clear() {
    _tasks.clear();
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

  int size() => _tasks.length;

  void addTask(Task task) {
    task.position = size();
    incorporate(task);
  }

  void addNewTask(String description) =>
      addTask(Task.newTask(0, description, false));

  List<Task> toList() {
    List<Task> listtask = [];
    for (int i = 0; i < _tasks.length; i++) {
      listtask.add(this[i]);
    }
    return listtask;
  }
}
