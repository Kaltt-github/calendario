// ignore_for_file: file_names, avoid_print

import 'package:calendario/classes/enums.dart';
import 'package:calendario/classes/tasks.dart';

import '../events.dart';

void showT(Task t) => print('${t.position} ${t.description} ${t.isComplete}');

void show(TaskList ts) {
  print('Size ${ts.size}');
  ts.toList().forEach((t) => showT(t));
  print('------------------------');
}

void main(List<String> args) {
  var e = EventFather.newEvent(FromType.owned, "abc"),
      ts = TaskList(e),
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
  ts.updateById(t2.id, position: 4, description: "Wowo?");
  show(ts);
  ts.updateAt(1, description: "meow");
  show(ts);
  ts.clear();
  show(ts);
  ts.addTask(t4);
  show(ts);
  ts.addNewTask("pipipipip");
  show(ts);
  var x = ts[1];
  showT(ts[0]);
  showT(x);
  showT(ts[2]);
  ts[0] = Task.newTask(0, 'ruuuuuu', false);
  show(ts);
  ts[1] = Task.newTask(0, 'fuuuuuu', false);
  show(ts);
  x.description = 'fofuuuuuuuuuuuuuuuuu';
  showT(x);
  showT(ts[1]);
}
