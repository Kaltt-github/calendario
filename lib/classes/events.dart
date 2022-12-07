import 'package:calendario/classes/funs.dart';

import 'time.dart';
import 'enums.dart';
import 'tag.dart';
import 'task.dart';

class Event {
  // Config
  late String id;
  late DateTime lastUpadte;
  late final FromType from;
  late final EventType type;
  late final String owner;
  late final Event father;
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
}

class EventFather implements Event {
  // Config
  @override
  late String id;
  @override
  DateTime lastUpadte = DateTime.now();
  @override
  EventType type = EventType.father;
  @override
  late final FromType from;
  @override
  late final String owner;
  @override
  late Event father = this;
  // Vars
  @override
  String name = "New";
  @override
  String description = "";
  late Tag _tag;
  @override
  Tag get tag => _tag;
  @override
  set tag(Tag t) {
    _tag = t;
    t.applyOn(this);
  }

  @override
  late Icon icon;
  @override
  late int color;
  @override
  late int priority;
  @override
  late List<String> shared;
  bool _lazy = false;
  @override
  bool get isLazy => _lazy;
  @override
  set isLazy(bool value) {
    _lazy = value;
    if (value) {
      anticipations = [];
      reminderDelay = Delay(type: DelayType.not);
      repeatDelay = Delay(type: DelayType.not);
      pospositionLimit = Lapse();
    }
  }

  @override
  bool get isNotLazy => !isLazy;
  @override
  set isNotLazy(bool value) => isLazy = !value;
  late DateTime _start;
  @override
  DateTime get start => isLazy
      ? DateTime.now()
      : DateTime(_start.year, _start.month, _start.day,
          (fullDay) ? 0 : _start.hour, (fullDay) ? 0 : _start.minute);
  @override
  set start(DateTime value) => _start = value;
  @override
  DateTime get end => length.applyOn(start);
  @override
  set end(DateTime value) {
    if (value.isBefore(start)) {
      start = length.invert().applyOn(value);
    } else {
      length = Lapse.between(start, value);
    }
  }

  late Lapse _length;
  @override
  Lapse get length => isLazy ? Lapse(days: 1) : _length;
  @override
  set length(Lapse value) => _length = value;
  @override
  late bool fullDay;
  @override
  late List<Task> tasks;
  // Status
  @override
  late bool isComplete = false;
  @override
  bool get isUncomplete => !isComplete;
  @override
  set isUncomplete(bool value) => isComplete = !value;
  @override
  bool get isActive {
    var now = DateTime.now();
    return isUncomplete &&
        (((now.isAfter(start) || now.isAtSameMomentAs(start)) &&
                (now.isBefore(end) || now.isAtSameMomentAs(end))) ||
            isLazy);
  }

  @override
  set isActive(bool value) => isComplete = !value;
  @override
  bool get isInactive => !isActive;
  @override
  set isInactive(bool value) => isActive = !value;
  @override
  bool get isExpired =>
      isUncomplete && ((isPosposed || DateTime.now().isAfter(end)) || isLazy);
  @override
  set isExpired(bool value) {}
  @override
  bool get isUnexpired => !isExpired;
  @override
  set isUnexpired(bool value) => isExpired = !value;
  // Anticipation
  @override
  List<EventAnticipation> anticipations = [];
  @override
  bool isLastAnticipation() => false;

  @override
  void addAnticipationByDate(DateTime date) {
    addAnticipationByLapse(Lapse.between(date, start));
  }

  @override
  void addAnticipationByLapse(Lapse lapse) {
    anticipations.add(EventAnticipation(this, lapse));
  }

  // Posposition
  Lapse _pospositionLimit = Lapse();
  @override
  Lapse get pospositionLimit => _pospositionLimit;
  @override
  set pospositionLimit(Lapse value) =>
      _pospositionLimit = value.isPositive() ? value : Lapse();
  @override
  DateTime get pospositionLimitDate => pospositionLimit.applyOn(start);
  @override
  set pospositionLimitDate(DateTime value) =>
      pospositionLimit = Lapse.between(start, value);
  @override
  Lapse pospositionPosposed = Lapse();
  @override
  Lapse get pospositionLapseLeft => pospositionLimit.take(pospositionPosposed);
  @override
  set pospositionLapseLeft(Lapse value) =>
      pospositionPosposed = pospositionLimit.take(value);
  @override
  late EventPosposition posposition = EventPosposition(this, Lapse());
  @override
  bool isLastPosposition() => false;
  @override
  bool get isPosposed => pospositionPosposed.isNotEmpty();
  @override
  set isPosposed(bool value) {
    if (!value) {
      pospositionPosposed = Lapse();
    }
  }

  @override
  bool pospose(Lapse lapse) {
    var result = lapse.add(pospositionPosposed);
    if (pospositionLimit.isLessThan(result)) {
      return false;
    }
    pospositionPosposed = result;
    return true;
  }

  // Reminder
  @override
  List<EventReminder> reminders = [];
  Delay _reminderDelay = Delay();
  @override
  Delay get reminderDelay => _reminderDelay;
  @override
  set reminderDelay(Delay value) {
    _reminderDelay = value;
    for (EventRepeat r in repeats) {
      r.reminderDelay = value;
    }
    if (value.type == DelayType.not) {
      reminders = [];
      return;
    }
    Lapse l = value.toLapse();
    DateTime s = l.applyOn(start);
    int i = 0;
    while (s.isBefore(end)) {
      Lapse nl = l.multiply(i + 1);
      if (reminders.length <= i) {
        reminders.add(EventReminder(this, nl));
      } else {
        reminders[i].lapse = nl;
      }
      i++;
    }
  }

  @override
  bool isLastReminder() => false;
  // Repeat
  @override
  List<EventRepeat> repeats = [];
  Delay _repeatDelay = Delay();
  @override
  Delay get repeatDelay => _repeatDelay;
  @override
  set repeatDelay(Delay value) {
    _repeatDelay = value;
    if (value.type == DelayType.not) {
      repeats = [];
      return;
    }
    Lapse l = value.toLapse();
    DateTime s = l.applyOn(start), ld = repeatLimitDate;
    int i = 0;
    while (s.isBefore(ld) && repeats.length < 100) {
      Lapse nl = l.multiply(i + 1);
      if (repeats.length <= i) {
        repeats.add(EventRepeat(this, nl));
      } else {
        repeats[i].lapse = nl;
      }
      i++;
    }
  }

  Lapse _repeatLimit = Lapse();
  @override
  Lapse get repeatLimit => _repeatLimit;
  @override
  set repeatLimit(Lapse value) {
    _repeatLimit = value;
    repeatDelay = repeatDelay;
  }

  @override
  DateTime get repeatLimitDate => repeatLimit.isEmpty()
      ? Lapse(years: 10).applyOn(start)
      : repeatLimit.applyOn(start);
  @override
  set repeatLimitDate(DateTime value) =>
      repeatLimit = Lapse.between(start, value);
  @override
  bool isLastRepeat() => false;
  // Functions
  @override
  List<Event> selfAndChildren() {
    List<Event> result = [this];
    if (isNotLazy) {
      for (Event e in [...anticipations, ...reminders, ...repeats]) {
        result.addAll(e.selfAndChildren());
      }
      if (isPosposed) {
        result.addAll(posposition.selfAndChildren());
      }
    }
    return result;
  }

  EventFather(this.id, this.from, this.owner, this.lastUpadte, {Tag? tag}) {
    this.tag = tag ?? Tag.appTag();
    type = EventType.father;
  }

  EventFather.newEvent(this.from, this.owner, {Tag? tag}) {
    this.tag = tag ?? Tag.appTag();
    type = EventType.father;
    lastUpadte = DateTime.now();
    id = buildId();
  }
}

class EventChild implements Event {
  // Config
  @override
  String get id => father.id;
  @override
  set id(String value) => father.id = value;
  @override
  DateTime get lastUpadte => father.lastUpadte;
  @override
  set lastUpadte(DateTime value) => father.lastUpadte = value;
  @override
  FromType get from => father.from;
  @override
  set from(FromType value) => father.from = value;
  @override
  late EventType type;
  @override
  String get owner => father.owner;
  @override
  set owner(String value) => father.owner = value;
  @override
  late Event father;
// Vars
  late Lapse lapse;
  int position() => 0;
  @override
  String get name => father.name;
  @override
  set name(String value) => father.name = value;
  @override
  String get description => father.description;
  @override
  set description(String value) => father.description = value;
  @override
  Tag get tag => father.tag;
  @override
  set tag(Tag value) => father.tag = value;
  @override
  Icon get icon => father.icon;
  @override
  set icon(Icon value) => father.icon = value;
  @override
  int get color => father.color;
  @override
  set color(int value) => father.color = value;
  @override
  int get priority => father.priority;
  @override
  set priority(int value) => father.priority = value;
  @override
  List<String> get shared => father.shared;
  @override
  set shared(List<String> value) => father.shared = value;
  @override
  bool get isLazy => father.isLazy;
  @override
  set isLazy(bool value) => father.isLazy = value;
  @override
  bool get isNotLazy => father.isNotLazy;
  @override
  set isNotLazy(bool value) => father.isNotLazy = value;
  @override
  DateTime get start => lapse.applyOn(father.start);
  @override
  set start(DateTime value) => {};
  @override
  DateTime get end => father.end;
  @override
  set end(DateTime value) => {};
  @override
  Lapse get length => father.length;
  @override
  set length(Lapse value) => father.length = value;
  @override
  bool get fullDay => father.fullDay;
  @override
  set fullDay(bool value) => father.fullDay = value;
  @override
  List<Task> get tasks => father.tasks;
  @override
  set tasks(List<Task> value) => father.tasks = value;
  // Status
  bool localComplete = false;
  @override
  bool get isComplete => father.isComplete || localComplete;
  @override
  set isComplete(bool value) => localComplete = value;
  @override
  bool get isUncomplete => !isComplete;
  @override
  set isUncomplete(bool value) => isComplete = !value;
  @override
  bool get isActive {
    var now = DateTime.now();
    return isUncomplete &&
        (now.isAfter(start) || now.isAtSameMomentAs(start)) &&
        (now.isBefore(end) || now.isAtSameMomentAs(end));
  }

  @override
  set isActive(bool value) => localComplete = !value;
  @override
  bool get isInactive => !isActive;
  @override
  set isInactive(bool value) => isActive = !value;
  @override
  bool get isExpired =>
      isUncomplete && (isPosposed || DateTime.now().isAfter(end));
  @override
  set isExpired(bool value) {}
  @override
  bool get isUnexpired => !isExpired;
  @override
  set isUnexpired(bool value) => isExpired = !value;
// Anticipation
  @override
  List<EventAnticipation> get anticipations => father.anticipations;
  @override
  set anticipations(List<EventAnticipation> value) =>
      father.anticipations = value;
  @override
  bool isLastAnticipation() => father.isLastAnticipation();
  @override
  void addAnticipationByDate(DateTime date) =>
      father.addAnticipationByDate(date);
  @override
  void addAnticipationByLapse(Lapse lapse) =>
      father.addAnticipationByLapse(lapse);
// Posposition
  @override
  Lapse get pospositionLimit => father.pospositionLimit;
  @override
  set pospositionLimit(Lapse value) => father.pospositionLimit = value;
  @override
  DateTime get pospositionLimitDate => father.pospositionLimitDate;
  @override
  set pospositionLimitDate(DateTime value) =>
      father.pospositionLimitDate = value;
  @override
  Lapse get pospositionPosposed => father.pospositionPosposed;
  @override
  set pospositionPosposed(Lapse value) => father.pospositionPosposed = value;
  @override
  Lapse get pospositionLapseLeft => father.pospositionLapseLeft;
  @override
  set pospositionLapseLeft(Lapse value) => father.pospositionLapseLeft = value;
  @override
  EventPosposition get posposition => father.posposition;
  @override
  set posposition(EventPosposition value) => father.posposition = value;
  @override
  bool isLastPosposition() => father.isLastPosposition();
  @override
  bool get isPosposed => father.isPosposed;
  @override
  set isPosposed(bool value) => father.isPosposed = value;
  @override
  bool pospose(Lapse lapse) => father.pospose(lapse);
// Reminder
  @override
  List<EventReminder> get reminders => father.reminders;
  @override
  set reminders(List<EventReminder> value) => father.reminders = value;
  @override
  Delay get reminderDelay => father.reminderDelay;
  @override
  set reminderDelay(Delay value) => father.reminderDelay = value;
  @override
  bool isLastReminder() => father.isLastReminder();
// Repeat
  @override
  List<EventRepeat> get repeats => father.repeats;
  @override
  set repeats(List<EventRepeat> value) => father.repeats = value;
  @override
  Delay get repeatDelay => father.repeatDelay;
  @override
  set repeatDelay(Delay value) => father.repeatDelay = value;
  @override
  Lapse get repeatLimit => father.repeatLimit;
  @override
  set repeatLimit(Lapse value) => father.repeatLimit = value;
  @override
  DateTime get repeatLimitDate => father.repeatLimitDate;
  @override
  set repeatLimitDate(DateTime value) => father.repeatLimitDate = value;
  @override
  bool isLastRepeat() => father.isLastRepeat();
// Functions
  @override
  List<Event> selfAndChildren() => [this];

  EventChild(this.father, this.lapse);
}

class EventAnticipation extends EventChild {
  @override
  int position() => father.anticipations.indexOf(this);
  // Vars
  @override
  set start(DateTime value) => lapse = Lapse.between(value, father.start);
  @override
  DateTime get end =>
      isLastAnticipation() ? father.start : anticipations[position() + 1].start;
  // Anticipation
  @override
  bool isLastAnticipation() => position() == father.anticipations.length;
  // Posposition
  @override
  Lapse get pospositionLimit => Lapse.between(
      end,
      isLastAnticipation()
          ? father.start
          : father.anticipations[position() + 1].start);
  @override
  set pospositionLimit(Lapse value) => {};
  @override
  DateTime get pospositionLimitDate => isLastAnticipation()
      ? father.start
      : father.anticipations[position() + 1].start;
  @override
  set pospositionLimitDate(DateTime value) => {};
  @override
  Lapse pospositionPosposed = Lapse();
  @override
  Lapse get pospositionLapseLeft => pospositionLimit.take(pospositionPosposed);
  @override
  set pospositionLapseLeft(Lapse value) =>
      pospositionPosposed = pospositionLimit.take(value);
  @override
  late EventPosposition posposition = EventPosposition(this, Lapse());
  @override
  bool isLastPosposition() => false;
  @override
  bool get isPosposed => pospositionPosposed.isNotEmpty();
  @override
  set isPosposed(bool value) {
    if (!value) {
      pospositionPosposed = Lapse();
    }
  }

  @override
  bool pospose(Lapse lapse) {
    var result = lapse.add(pospositionPosposed);
    if (pospositionLimit.isLessThan(result)) {
      return false;
    }
    pospositionPosposed = result;
    return true;
  }

  // Funs
  @override
  List<Event> selfAndChildren() => isPosposed ? [this, posposition] : [this];

  EventAnticipation(Event father, Lapse lapse) : super(father, lapse) {
    type = EventType.anticipation;
  }
}

class EventReminder extends EventChild {
  @override
  int position() => father.reminders.indexOf(this);
  // Vars
  @override
  List<Task> tasks = [];
  @override
  DateTime get end =>
      isLastReminder() ? father.end : reminders[position() + 1].start;

  EventReminder(Event father, Lapse lapse) : super(father, lapse) {
    type = EventType.reminder;
  }
}

class EventRepeat extends EventChild {
  @override
  int position() => father.repeats.indexOf(this);
  @override
  DateTime get end => length.applyOn(start);
  // Status
  @override
  bool isComplete = false;
  @override
  bool get isUncomplete => !isComplete;
  @override
  set isUncomplete(bool value) => isComplete = !value;
  @override
  bool get isActive {
    var now = DateTime.now();
    return isUncomplete &&
        (((now.isAfter(start) || now.isAtSameMomentAs(start)) &&
                (now.isBefore(end) || now.isAtSameMomentAs(end))) ||
            isLazy);
  }

  @override
  set isActive(bool value) => isComplete = !value;
  @override
  bool get isInactive => !isActive;
  @override
  set isInactive(bool value) => isActive = !value;
  @override
  bool get isExpired =>
      isUncomplete && ((isPosposed || DateTime.now().isAfter(end)) || isLazy);
  @override
  set isExpired(bool value) {}
  @override
  bool get isUnexpired => !isExpired;
  @override
  set isUnexpired(bool value) => isExpired = !value;
  // Anticipation
  @override
  List<EventAnticipation> anticipations = [];

  @override
  void addAnticipationByDate(DateTime date) {
    addAnticipationByLapse(Lapse.between(date, start));
  }

  @override
  void addAnticipationByLapse(Lapse lapse) {
    anticipations.add(EventAnticipation(this, lapse));
  }

  // Posposition
  @override
  DateTime get pospositionLimitDate => pospositionLimit.applyOn(start);
  @override
  set pospositionLimitDate(DateTime value) =>
      pospositionLimit = Lapse.between(start, value);
  @override
  Lapse pospositionPosposed = Lapse();
  @override
  Lapse get pospositionLapseLeft => pospositionLimit.take(pospositionPosposed);
  @override
  set pospositionLapseLeft(Lapse value) =>
      pospositionPosposed = pospositionLimit.take(value);
  @override
  late EventPosposition posposition = EventPosposition(this, Lapse());
  @override
  bool get isPosposed => pospositionPosposed.isNotEmpty();
  @override
  set isPosposed(bool value) {
    if (!value) {
      pospositionPosposed = Lapse();
    }
  }

  @override
  bool pospose(Lapse lapse) {
    var result = lapse.add(pospositionPosposed);
    if (pospositionLimit.isLessThan(result)) {
      return false;
    }
    pospositionPosposed = result;
    return true;
  }

  // Reminder
  @override
  List<EventReminder> reminders = [];
  Delay _reminderDelay = Delay();
  @override
  Delay get reminderDelay => _reminderDelay;
  @override
  set reminderDelay(Delay value) {
    _reminderDelay = value;
    if (value.type == DelayType.not) {
      reminders = [];
      return;
    }
    Lapse l = value.toLapse();
    DateTime s = l.applyOn(start);
    int i = 0;
    while (s.isBefore(end)) {
      Lapse nl = l.multiply(i + 1);
      if (reminders.length <= i) {
        reminders.add(EventReminder(this, nl));
      } else {
        reminders[i].lapse = nl;
      }
      i++;
    }
  }

  // Repeat
  @override
  bool isLastRepeat() => position() == father.repeats.length;
  // Functions
  @override
  List<Event> selfAndChildren() {
    List<Event> result = [this];
    if (isNotLazy) {
      for (Event e in [...anticipations, ...reminders]) {
        result.addAll(e.selfAndChildren());
      }
      if (isPosposed) {
        result.addAll(posposition.selfAndChildren());
      }
    }
    return result;
  }

  EventRepeat(Event father, Lapse lapse) : super(father, lapse) {
    type = EventType.repeat;
    for (Task t in father.tasks) {
      tasks.add(Task(t.id, t.position, t.description, false));
    }
    tasks.sort((a, b) => b.position.compareTo(a.position));
    for (EventAnticipation a in father.anticipations) {
      addAnticipationByLapse(a.lapse);
    }
    reminderDelay = father.reminderDelay;
  }
}

class EventPosposition extends EventChild {
  @override
  DateTime get start => pospositionPosposed.applyOn(father.start);
  @override
  set start(DateTime value) => lapse = Lapse.between(father.start, value);
  EventPosposition(Event father, Lapse lapse) : super(father, lapse) {
    type = EventType.posposition;
  }
}
