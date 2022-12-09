// ignore_for_file: file_names, avoid_print

import 'package:calendario/classes/task.dart';

void show(TaskList ts) {
  print('Size ${ts.size()}');
  ts.toList().forEach((t) {
    print('${t.position} ${t.description} ${t.isComplete}');
  });
  print('------------------------');
}

void main(List<String> args) {
  var ts = TaskList(),
      t1 = Task.newTask(0, "Des1", false),
      t2 = Task.newTask(0, "Des2", false),
      t3 = Task.newTask(0, "Des3", false),
      t4 = Task.newTask(0, "Des4", false),
      t5 = Task.newTask(0, "Des5", false);
  show(ts);
  ts.incorporate(t1);
  show(ts);
  ts.incorporate(t2);
  show(ts);
  ts.incorporateAll([t3, t4, t5]);
  show(ts);
  ts.removeAt(t3.position);
  show(ts);
  ts.removeId(t4.id);
  show(ts);
  ts.updateId(t2.id, position: 2, description: "Wowo?");
  show(ts);
  ts.updateAt(1, description: "meow");
  show(ts);
  ts.clear();
  show(ts);
  ts.addTask(t4);
  show(ts);
  ts.addNewTask("pipipipip");
  show(ts);

  /*
  Task operator [](int index)
  void operator []=(int index, Task value)
  */
}
