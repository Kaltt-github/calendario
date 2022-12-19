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
  e.anticipation.addByDate(DateTime(2022, 10, 4));
  e.anticipation.addByLapse(Lapse(days: 2, hours: 1));
  e.anticipation.addByLapse(Lapse(days: -3, hours: -2));
  e.anticipation.addByLapse(Lapse(days: -3, hours: -3));
  e.anticipation.addByLapse(Lapse(days: -3, hours: -4));
  e.anticipation.removeByDate(DateTime(2022, 10, 4));
  e.anticipation.removeByLapse(Lapse(days: -3, hours: -3));
  print('ee');
}
/*

class Anticipation {
  List<EventAnticipation> events = [];
  void addByLapse(Lapse lapse)
  void addByDate(DateTime date)
  void removeByLapse(Lapse lapse)
  void removeByDate(DateTime start)
}

class Reminder {
  Delay _delay = Delay();
  List<EventReminder> events = [];
}

class Repeat {
  Delay _delay = Delay();
  Lapse _limit = Lapse();
  List<EventRepeat> events = [];
  DateTime get limitDate
}

class Postpositon {
  Lapse _limit = Lapse();
  Lapse _postposed = Lapse();
  EventPostposition event;
  Lapse get lapseLeft
  bool postpose(Lapse lapse)
}

class StatusManager {
  bool get isFather
  bool get isAnticipation 
  bool get isReminder
  bool get isRepeat 
  bool get isPostposition
  bool get hasChildren 
  bool get isPostposed
  bool get isReminded
  bool get isAnticipated
  bool get isRepeated 
  bool get isLastReminder
  bool get isLastRepeat
  bool get isLastAnticipation
  bool get isLazy
  set isLazy(bool value)
  bool get isComplete
  set isComplete(bool value)
  bool get isActive
  set isActive(bool value)
  bool get isExpired
  bool get isInDate
  bool get isLost
}

class EventFather implements Event {
  late final StatusManager status
  late final TaskList tasks
  late final Anticipation anticipation
  late final Reminder reminder
  late final Repeat repeat
  late final Postpositon postposition

  DateTime get start => status.isLazy
      ? DateTime.now()
      : DateTime(_start.year, _start.month, _start.day,
          (isFullDay) ? 0 : _start.hour, (isFullDay) ? 0 : _start.minute);
  @override
  DateTime get end => isFullDay
      ? Lapse(years: length.years, months: length.months, days: length.days)
          .applyOn(start)
      : length.applyOn(start);
  @override
  set end(DateTime value) {
    if (value.isBefore(start)) {
      start = length.invert().applyOn(value);
    } else {
      length = Lapse.between(value, start);
    }
    notifyChanges();
  }
  // Functions
  List<Event> selfAndChildren()
  void addShared(String email)
  void removeShared(String email)
  int compareTo(other)
}

class EventAnticipation extends EventChild {
  int position()
  late final StatusManager status
  late final Postpositon postposition
  set start(DateTime value) {
    lapse = Lapse.between(value, father.start);
    notifyChanges();
  }
  DateTime get end => (status.isLastAnticipation
          ? father
          : father.anticipation.events[position() + 1])
      .start;
  set end(DateTime value) {
    lapse = Lapse.between(start, value).toNegative();
  }
  set length(Lapse value) {
    end = value.applyOn(start);
  }
}

class EventReminder extends EventChild {
  int position()
  late final StatusManager status
  set start(DateTime value) {}
  DateTime get end => status.isLastReminder
      ? father.end
      : father.reminder.events[position() + 1].start;
  set end(DateTime value) {}
  set length(Lapse value) {
    end = value.applyOn(start);
  }
}

class EventRepeat extends EventChild {
  @override
  int position()
// Utility
  @override
  late final StatusManager status
  @override
  late final TaskList tasks
  @override
  late final Anticipation anticipation
  @override
  late final Reminder reminder
  @override
  late final Postpositon postposition
  DateTime get start => lapse.applyOn(father.start);
  set start(DateTime value) => length = Lapse.between(value, end);
  DateTime get end => lapse.applyOn(father.end);
  set end(DateTime value) => father.end = lapse.invert().applyOn(value);
  Lapse get length => father.length;
}

class EventPostposition extends EventChild {
  late final StatusManager status
  late final Reminder reminder
  late final Anticipation anticipation
  DateTime get start => father.postposition.postposed.applyOn(father.start);
  set start(DateTime value) => father.postposition.postpose(Lapse.between(value, start));
  Lapse get lapse => father.postposition.postposed;
  set lapse(Lapse value) => father.postposition.postposed = value;
  DateTime get end => lapse.applyOn(father.end);
  set end(DateTime value) => father.length = Lapse.between(start, value);
}

*/

void main() {
  //testFatherConfig();
  //testFatherVars();
  testAnticipation();
  print("Fin del test");
}
