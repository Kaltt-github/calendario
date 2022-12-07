// ignore_for_file: file_names, avoid_print

import 'package:calendario/classes/enums.dart';
import 'package:calendario/classes/events.dart';
// TODO
/*
// Config
  
  // Vars
  late String name;
  late String description;
  late Tag tag;
  late Icon icon;
  late int color;
  late int priority;
  late List<String> shared;
  late bool isLazy;
  late bool isNotLazy;
  late DateTime start;
  late DateTime end;
  late Lapse length;
  late bool fullDay;
  late List<Task> tasks;
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

void main() {
  testFatherConfig();
  print("Fin del test");
}
