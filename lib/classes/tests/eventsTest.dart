// ignore_for_file: file_names, avoid_print

import 'package:calendario/classes/enums.dart';
import 'package:calendario/classes/events.dart';
import 'package:calendario/classes/tag.dart';
import 'package:calendario/classes/time.dart';

void testFatherConfig() {
  EventFather e = EventFather.newEvent(FromType.owned, "abc@gmail.com");
  /*
  late String id;
  late DateTime lastUpadte;
  late final FromType from;
  late final EventType type;
  late final String owner;
  late final Event father;
  */
  print(e.id);
  print(e.lastUpadte);
  print(e.type);
  print(e.owner);
  print(e.father.id);
}

void testFatherVars() {
  var x = EventFather.newEvent(FromType.owned, 'owner')
    ..name = 'Nombre'
    ..description = 'Descripcion'
    ..tag = (Tag.appTag()..color = 300)
    ..icon = Icon.calendar
    ..priority = 5
    ..shared.addAll(['share 1', 'sahre5'])
    ..start = DateTime(2020, 10, 6, 10);
  print(x.start);
  print(x.end);
  x.end = DateTime(2020, 10, 8, 5);
  print(x.start);
  print(x.end);
  x.length = Lapse(days: 2, hours: 1);
  print(x.start);
  print(x.end);
  x.isFullDay = true;
  print(x.start);
  print(x.end);
  x.end = DateTime(2020, 9, 6, 7);
  print(x.start);
  print(x.end);
}

void testAnticipation() {
  var e = EventFather.newEvent(FromType.owned, "wawa");
  e.start = DateTime(2022, 10, 5);
  e.addAnticipationByDate(DateTime(2022, 10, 4));
  e.addAnticipationByLapse(Lapse(days: 2, hours: 1));
  e.addAnticipationByLapse(Lapse(days: -3, hours: -2));
  e.addAnticipationByLapse(Lapse(days: -3, hours: -3));
  e.addAnticipationByLapse(Lapse(days: -3, hours: -4));
  e.removeAnticipationByDate(DateTime(2022, 10, 4));
  e.removeAnticipationByLapse(Lapse(days: -3, hours: -3));
}

void show(List<EventChild> rs) {
  print('items ${rs.length}');
  for (EventChild r in rs) {
    print('${r.start} - ${r.end}');
  }
  print('-----------------------------------------------------------------');
}

void testReminders() {
  var e = EventFather.newEvent(FromType.owned, 'abc');

  e.reminderDelay = Delay(type: DelayType.hour, amount: 1);
  show(e.reminders);
  e.reminderDelay = Delay(type: DelayType.hour, amount: 2);
  show(e.reminders);
  e.reminderDelay = Delay(type: DelayType.hour, amount: 1);
  show(e.reminders);
}

void testRepeats() {
  var e = EventFather.newEvent(FromType.owned, 'abc');
  e.repeatDelay = Delay(type: DelayType.month, amount: 4);
  show(e.repeats);
  e.repeatDelay = Delay(type: DelayType.month, amount: 6);
  show(e.repeats);
  e.repeatDelay = Delay(type: DelayType.day, amount: 2);
  show(e.repeats);
  e.repeatLimit = Lapse(days: 20);
  show(e.repeats);
  var a = Lapse(months: 2).applyOn(e.start);
  e.repeatLimitDate = a;
  show(e.repeats);
}

void testPostposition() {
  var e = EventFather.newEvent(FromType.owned, 'abc');
  print(e.start);
  e.postpositionLimit = Lapse(months: 1);
  print(e.postpositionLimitDate);
  e.postpositionLimitDate = Lapse(months: 2).applyOn(e.start);
  print(e.postpositionLimit);
  print('postposed');
  print(e.postposed);
  print(e.postpositionLeft);
  print(e.postpose(Lapse(days: 6)));
  print(e.postpositionLeft);
  print(e.postpose(Lapse(months: 1)));
  print(e.postpositionLeft);
  print(e.postpose(Lapse(months: 1)));
  print(e.postpositionLeft);
}

void main() {
  var e = EventFather.newEvent(FromType.owned, 'abc');
  //testFatherConfig();
  //testFatherVars();
  //testAnticipation();
  //testReminders();
  //testRepeats();
  //testPostposition();
  e.repeatDelay = Delay(type: DelayType.week, amount: 1);
  e.repeatLimit = Lapse(months: 1);
  e.addAnticipationByLapse(Lapse(hours: 4));
  e.length = Lapse(hours: 1);
  e.reminderDelay = Delay(type: DelayType.minute, amount: 5);
  e.length = Lapse(hours: 2);
  e.postpositionLimit = Lapse(days: 4);
  e.postpose(Lapse(days: 1));
  e.repeats.first.postpose(Lapse(hours: 5));
  print(e.toString());
  print('////////////////////////////');
  print("Fin del test");
}
