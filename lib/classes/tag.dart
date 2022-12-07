import 'package:calendario/classes/funs.dart';
import 'time.dart';
import 'enums.dart';
import 'events.dart';
import 'task.dart';

class Tag {
  late String id;
  late DateTime lastUpadte;
  late final FromType from;
  late final String owner;
  late String name;
  late Icon icon;
  late int color;
  late int priority;
  late List<String> shared;
  late bool lazy;
  late DateTime start;
  late Lapse length;
  late bool fullDay;
  late List<Task> tasks;
  late List<Lapse> anticipations;
  late Lapse pospositionLimit;
  late Delay reminderDelay;
  late Delay repeatDelay;
  late Lapse repeatLimit;

  Tag(
      this.id,
      this.lastUpadte,
      this.from,
      this.owner,
      this.name,
      this.icon,
      this.color,
      this.priority,
      this.shared,
      this.lazy,
      this.start,
      this.length,
      this.fullDay,
      this.tasks,
      this.anticipations,
      this.pospositionLimit,
      this.reminderDelay,
      this.repeatDelay,
      this.repeatLimit);

  Tag.newTag(
      this.lastUpadte,
      this.from,
      this.owner,
      this.name,
      this.icon,
      this.color,
      this.priority,
      this.shared,
      this.lazy,
      this.start,
      this.length,
      this.fullDay,
      this.tasks,
      this.anticipations,
      this.pospositionLimit,
      this.reminderDelay,
      this.repeatDelay,
      this.repeatLimit) {
    id = buildId();
  }

  static Tag appTag() => Tag(
      "0",
      DateTime.now(),
      FromType.app,
      "Calendario",
      "Default",
      Icon.calendar,
      30,
      5,
      [],
      false,
      DateTime.now(),
      Lapse(days: 1),
      false,
      [],
      [],
      Lapse(),
      Delay(),
      Delay(),
      Lapse());

  void applyOn(Event e) {
    return; // WAITING FOR EVENT TEST
    e.icon = icon;
    e.color = color;
    e.priority = priority;
    e.shared = shared;
    e.start = start;
    e.length = length;
    e.fullDay = fullDay;
    e.tasks.addAll(tasks);
    for (Lapse a in anticipations) {
      e.addAnticipationByLapse(a);
    }
    e.pospositionLimit = pospositionLimit;
    e.reminderDelay = reminderDelay;
    e.repeatDelay = repeatDelay;
    e.repeatLimit = repeatLimit;
    e.isLazy = lazy;
  }

  Tag clone() => Tag(
      id,
      lastUpadte,
      from,
      owner,
      name,
      icon,
      color,
      priority,
      shared,
      lazy,
      start,
      length,
      fullDay,
      tasks,
      anticipations,
      pospositionLimit,
      reminderDelay,
      repeatDelay,
      repeatLimit);
}
