// ignore_for_file: file_names, avoid_print

import 'package:calendario/classes/enums.dart';
import 'package:calendario/classes/events.dart';
import 'package:calendario/classes/tag.dart';
import 'package:calendario/classes/time.dart';
// TODO
/*
  // Status
  late bool isComplete;
  late bool isUncomplete;
  late bool isActive;
  late bool isInactive;
  late bool isExpired;
  late bool isUnexpired;
  // Anticipation
  late List<EventAnticipation> anticipations;
  external bool isLastAnticipation();
  external void addAnticipationByDate(DateTime date);
  external addAnticipationByLapse(Lapse date);
  // Posposition
  late Lapse pospositionLimit;
  late DateTime pospositionLimitDate;
  late Lapse pospositionPosposed;
  late Lapse pospositionLapseLeft;
  late EventPosposition posposition;
  late bool isPosposed;
  external bool isLastPosposition();
  external bool pospose(Lapse lapse);

  // Reminder
  late List<EventReminder> reminders;
  late Delay reminderDelay;
  external bool isLastReminder();
  // Repeat
  late List<EventRepeat> repeats;
  late Delay repeatDelay;
  late Lapse repeatLimit;
  late DateTime repeatLimitDate;
  external bool isLastRepeat();
  // Functions
  external List<Event> selfAndChildren();
*/

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
  /*
  // Vars
  late List<Task> tasks;
  */
  var x = EventFather.newEvent(FromType.owned, 'owner')
    ..fullDay = true
    ..name = 'Nombre'
    ..description = 'Descripcion'
    ..tag = (Tag.appTag()..color = 300)
    ..icon = Icon.calendar
    ..priority = 5
    ..shared = ['share 1', 'sahre5']
    ..start = DateTime(2020, 10, 6, 10);
  print(x.start);
  print(x.end);
  x.end = DateTime(2020, 10, 8, 5);
  print(x.start);
  print(x.end);
  x.length = Lapse(days: 2, hours: 1);
  print(x.start);
  print(x.end);
  x.fullDay = true;
  print(x.start);
  print(x.end);
  x.end = DateTime(2020, 9, 6, 7);
  print(x.start);
  print(x.end);
}

void main() {
  //testFatherConfig();
  testFatherVars();
  print("Fin del test");
}
