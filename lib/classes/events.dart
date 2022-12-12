import 'package:calendario/classes/funs.dart';

import 'time.dart';
import 'enums.dart';
import 'tag.dart';
import 'task.dart';

class Anticipation {
  final Event _event;

  List<EventAnticipation> events = [];

  void addByLapse(Lapse lapse) {
    if (_event.status.isFather) {
      if (events.where((it) => it.lapse.isEqual(lapse)).isNotEmpty) {
        return;
      }
      for (Event it in [
        _event,
        ..._event.repeat.events,
        _event.postposition.event
      ]) {
        it.anticipation.events.add(EventAnticipation(it, lapse));
      }
      _event.notifyChanges();
    } else {
      _event.father.anticipation.addByLapse(lapse);
    }
  }

  void addByDate(DateTime date) =>
      addByLapse(Lapse.between(date, _event.start));

  void removeByLapse(Lapse lapse) {
    if (_event.status.isFather) {
      for (Event it in [
        _event,
        ..._event.repeat.events,
        _event.postposition.event
      ]) {
        it.anticipation.events.removeWhere((it) => it.lapse.isEqual(lapse));
      }
      _event.notifyChanges();
    } else {
      _event.father.anticipation.removeByLapse(lapse);
    }
  }

  void removeByDate(DateTime start) =>
      removeByLapse(Lapse.between(_event.start, start));

  Anticipation(this._event);
}

class Reminder {
  final Event _event;

  Delay _delay = Delay();
  List<EventReminder> events = [];

  Delay get delay => _delay;
  set delay(Delay value) {
    if (_event.status.isFather) {
      if (value.type == DelayType.not) {
        for (Event it in [
          _event,
          ..._event.repeat.events,
          _event.postposition.event
        ]) {
          it.reminder
            .._delay = value.clone()
            ..events = [];
        }
      } else {
        Lapse lapse = value.toLapse();
        for (Event it in [
          _event,
          ..._event.repeat.events,
          _event.postposition.event
        ]) {
          it.reminder._delay = value.clone();
          List<EventReminder> subevents = it.reminder.events;
          DateTime start = lapse.applyOn(it.start);
          int i = 0;
          while (start.isBefore(it.end)) {
            Lapse nl = lapse.multiply(i + 1);
            if (subevents.length <= i) {
              subevents.add(EventReminder(it, nl));
            } else {
              subevents[i].lapse = nl;
            }
            i++;
          }
          subevents = subevents.sublist(0, i);
        }
      }
      _event.notifyChanges();
    } else {
      _event.father.reminder.delay = value;
    }
  }

  Reminder(this._event);
}

class Repeat {
  final Event _event;

  Delay _delay = Delay();
  Lapse _limit = Lapse();
  List<EventRepeat> events = [];

  Delay get delay => _delay;
  set delay(Delay value) {
    if (_event.status.isFather) {
      _delay = value;
      if (value.type == DelayType.not) {
        events = [];
        return;
      }
      Lapse lapse = value.toLapse();
      DateTime start = lapse.applyOn(_event.start), limit = limitDate;
      int i = 0;
      while (start.isBefore(limit) && events.length < 100) {
        Lapse newlapse = lapse.multiply(i + 1);
        if (events.length <= i) {
          events.add(EventRepeat(_event, newlapse));
        } else {
          events[i].lapse = newlapse;
        }
        i++;
      }
      events = events.sublist(i);

      _event.notifyChanges();
    } else {
      _event.father.repeat.delay = value;
    }
  }

  Lapse get limit => _limit;
  set limit(Lapse value) {
    if (_event.status.isFather) {
      if (_limit.isLessThan(value)) {
        _limit = value;
        events.removeWhere((it) => it.start.isAfter(limitDate));
        _event.notifyChanges();
      } else {
        _limit = value;
        delay = delay.clone();
      }
    } else {
      _event.father.repeat.limit = value;
    }
  }

  DateTime get limitDate =>
      (limit.isEmpty ? Lapse(years: 10) : limit).applyOn(_event.start);
  set repeatLimitDate(DateTime value) {
    limit = Lapse.between(_event.start, value);
  }

  Repeat(this._event);
}

class Postpositon {
  final Event _event;

  Lapse _limit = Lapse();
  Lapse _postposed = Lapse();
  EventPostposition event;

  Lapse get limit => _limit;
  set limit(Lapse value) {
    if (_event.status.isFather) {
      value = value.isPositive() ? value : Lapse();
      for (Event it in [
        _event,
        ..._event.anticipation.events,
        ..._event.repeat.events
      ]) {
        it.postposition._limit = value;
        if (it.postposition.postposed.isMoreThan(value)) {
          it.postposition.postposed = value.clone();
        }
      }
      _event.notifyChanges();
    } else {
      _event.father.postposition.limit = value;
    }
  }

  DateTime get limitDate => limit.applyOn(_event.start);
  set limitDate(DateTime value) {
    limit = Lapse.between(_event.start, value);
  }

  Lapse get postposed => _postposed;
  set postposed(Lapse value) {
    _postposed = value;
    _event.notifyChanges();
  }

  Lapse get lapseLeft => limit.take(postposed);
  set lapseLeft(Lapse value) => postposed = limit.take(value);

  bool postpose(Lapse lapse) {
    var result = lapse.add(postposed);
    if (result.isMoreThan(limit)) {
      return false;
    }
    postposed = result;
    return true;
  }

  Postpositon(this._event) : event = EventPostposition(_event, Lapse());
}

class StatusManager {
  final Event event;

  bool _lazy = false;
  bool _complete = false;

  bool get isFather => event.type == EventType.father;
  bool get isNotFather => !isNotFather;

  bool get isChild => !isFather;
  bool get isNotChild => !isChild;

  bool get isAnticipation => event.type == EventType.anticipation;
  bool get isNotAnticipation => !isAnticipation;

  bool get isReminder => event.type == EventType.reminder;
  bool get isNotReminder => !isReminder;

  bool get isRepeat => event.type == EventType.repeat;
  bool get isNotRepeat => !isRepeat;

  bool get isPostposition => event.type == EventType.postposition;
  bool get isNotPostposition => !isPostposition;

  bool get hasChildren => isFather || isAnticipation || isRepeat;
  bool get hasNotChildren => !hasChildren;

  bool get isPostposed =>
      hasChildren && event.postposition.postposed.isNotEmpty;
  bool get isNotPostposed => !isPostposed;

  bool get isReminded => hasChildren && event.reminder.delay.isNotEmpty;
  bool get isNotReminded => !isReminded;

  bool get isAnticipated => hasChildren && event.anticipation.events.isNotEmpty;
  bool get isNotAnticipated => !isAnticipated;

  bool get isRepeated => hasChildren && event.repeat.delay.isNotEmpty;
  bool get isNotRepeated => !isRepeated;

  bool _isLast<E extends EventChild>(List<E> list, E event) =>
      list.length - 1 == event.position();

  bool get isLastReminder =>
      isReminder && _isLast(event.reminder.events, event as EventReminder);
  bool get isNotLastReminder => !isLastReminder;

  bool get isLastRepeat =>
      isRepeat && _isLast(event.repeat.events, event as EventRepeat);
  bool get isNotLastRepeat => !isLastRepeat;

  bool get isLastAnticipation =>
      isAnticipation &&
      _isLast(event.anticipation.events, event as EventAnticipation);
  bool get isNotLastAnticipation => !isLastAnticipation;

  bool get isLazy => _lazy;
  set isLazy(bool value) {
    _lazy = value;
    if (value) {
      event.anticipation.events = [];
      event.reminder.delay = Delay(type: DelayType.not);
      event.repeat.delay = Delay(type: DelayType.not);
      event.postposition.limit = Lapse();
    }
    event.notifyChanges();
  }

  bool get isNotLazy => !isLazy;
  set isNotLazy(bool value) => isLazy = !value;

  bool get _dependent => isAnticipation || isReminder || isPostposition;

  bool get isComplete =>
      _complete || (_dependent && event.father.status.isComplete);
  set isComplete(bool value) {
    if (isPostposition) {
      event.father.status.isComplete = value;
    }
    _complete = value;
    event.notifyChanges();
  }

  bool get isNotComplete => !isComplete;
  set isNotComplete(bool value) => isComplete = !value;

  bool get isActive {
    var now = DateTime.now();
    return isNotComplete &&
        (((now.isAfter(event.start) || now.isAtSameMomentAs(event.start)) &&
                (now.isBefore(event.end) || now.isAtSameMomentAs(event.end))) ||
            isLazy);
  }

  set isActive(bool value) => isComplete = !value;
  bool get isNotActive => !isActive;
  set isNotActive(bool value) => isActive = !value;

  bool get isExpired =>
      isNotComplete &&
      (isPostposed || DateTime.now().isAfter(event.end) || isNotLazy);
  bool get isNotExpired => !isExpired;

  StatusManager(this.event);
}

abstract class Event {
// Config
  String get id;
  set id(String value);
  DateTime get lastUpadte;
  set lastUpadte(DateTime value);
  FromType get from;
  EventType get type;
  String get owner;
  Event get father;
// Utility
  StatusManager get status;
  TaskList get tasks;
  Anticipation get anticipation;
  Reminder get reminder;
  Repeat get repeat;
  Postpositon get postposition;

// Vars
  String get name;
  set name(String value);

  String get description;
  set description(String value);

  Tag get tag;
  set tag(Tag value);

  Icon get icon;
  set icon(Icon value);

  int get color;
  set color(int value);

  int get priority;
  set priority(int value);

  List<String> get shared;
  set shared(List<String> value);

  DateTime get start;
  set start(DateTime value);

  DateTime get end;
  set end(DateTime value);

  Lapse get length;
  set length(Lapse value);

  bool get isFullDay;
  set isFullDay(bool value);

// Functions
  List<Event> selfAndChildren();
  void notifyChanges();
  void addShared(String email);
  void removeShared(String email);
}

class EventFather implements Event {
  // Private
  String _name = "New";
  String _description = "";
  late Tag _tag;
  late Icon _icon;
  late int _color;
  late int _priority;
  List<String> _shared = [];
  late Lapse _length;
  bool _isFullDay = false;
  late DateTime _start;

  // Utility
  @override
  late final StatusManager status = StatusManager(this);
  @override
  late final TaskList tasks = TaskList(this);
  @override
  late final Anticipation anticipation = Anticipation(this);
  @override
  late final Reminder reminder = Reminder(this);
  @override
  late final Repeat repeat = Repeat(this);
  @override
  late final Postpositon postposition = Postpositon(this);

  // Config
  @override
  final EventType type = EventType.father;
  @override
  late final FromType from;
  @override
  late final Event father = this;
  @override
  late final String id;
  @override
  DateTime lastUpadte;
  @override
  late final String owner;

  // Get/Set
  @override
  String get name => _name;
  @override
  set name(String value) {
    _name = value;
    notifyChanges();
  }

  @override
  String get description => _description;
  @override
  set description(String value) {
    _description = value;
    notifyChanges();
  }

  @override
  Tag get tag => _tag;
  @override
  set tag(Tag t) {
    _tag = t;
    t.applyOn(this);
  }

  @override
  Icon get icon => _icon;
  @override
  set icon(Icon value) {
    _icon = value;
    notifyChanges();
  }

  @override
  int get color => _color;
  @override
  set color(int value) {
    _color = value;
    notifyChanges();
  }

  @override
  int get priority => _priority;
  @override
  set priority(int value) {
    _priority = value;
    notifyChanges();
  }

  @override
  // ignore: unnecessary_string_interpolations
  List<String> get shared => _shared.map((e) => '$e').toList();
  @override
  set shared(List<String> value) {
    _shared = value;
    notifyChanges();
  }

  @override
  DateTime get start => status.isLazy
      ? DateTime.now()
      : DateTime(_start.year, _start.month, _start.day,
          (isFullDay) ? 0 : _start.hour, (isFullDay) ? 0 : _start.minute);
  @override
  set start(DateTime value) {
    _start = value;
    notifyChanges();
  }

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

  @override
  Lapse get length => status.isLazy ? Lapse(days: 1) : _length;
  @override
  set length(Lapse value) {
    _length = value;
    notifyChanges();
  }

  @override
  bool get isFullDay => _isFullDay;
  @override
  set isFullDay(bool value) {
    _isFullDay = value;
    notifyChanges();
  }

  // Functions
  @override
  List<Event> selfAndChildren() {
    List<Event> result = [this];
    if (status.isNotLazy) {
      for (EventChild e in [
        ...anticipation.events,
        ...reminder.events,
        ...repeat.events
      ]) {
        result.addAll(e.selfAndChildren());
      }
      if (status.isPostposed) {
        result.addAll(postposition.event.selfAndChildren());
      }
    }
    return result;
  }

  @override
  void notifyChanges() {
    lastUpadte = DateTime.now();
  }

  @override
  void addShared(String email) {
    if (_shared.contains(email)) {
      return;
    }
    notifyChanges();
    _shared.add(email);
  }

  @override
  void removeShared(String email) {
    if (_shared.contains(email)) {
      notifyChanges();
      _shared.remove(email);
    }
  }

  EventFather(this.id, this.from, this.owner, this.lastUpadte, this._tag);

  EventFather.newEvent(this.from, this.owner, {Tag? tag})
      : lastUpadte = DateTime.now(),
        id = buildId() {
    this.tag = tag ?? Tag.appTag();
  }
}

abstract class EventChild implements Event {
  // Local
  int position();

  Lapse _lapse;
  Lapse get lapse => _lapse;
  set lapse(Lapse value) {
    _lapse = value;
    notifyChanges();
  }

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
  final EventType type;
  @override
  String get owner => father.owner;
  @override
  final Event father;
// Utility
  @override
  TaskList get tasks => father.tasks;
  @override
  StatusManager get status => father.status;
  @override
  Anticipation get anticipation => father.anticipation;
  @override
  Postpositon get postposition => father.postposition;
  @override
  Reminder get reminder => father.reminder;
  @override
  Repeat get repeat => father.repeat;
// Vars
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
  DateTime get start => lapse.applyOn(father.start);
  @override
  Lapse get length => Lapse.between(start, end);
  @override
  bool get isFullDay => father.isFullDay;
  @override
  set isFullDay(bool value) => father.isFullDay = value;
// Functions
  @override
  List<Event> selfAndChildren() => [this];
  @override
  void notifyChanges() => father.notifyChanges();
  @override
  void addShared(String email) => father.addShared(email);
  @override
  void removeShared(String email) => father.removeShared(email);

  EventChild(this.father, this.type, this._lapse);
}

class EventAnticipation extends EventChild {
  @override
  int position() => father.anticipation.events.indexOf(this);

  @override
  late final StatusManager status = StatusManager(this);
  @override
  late final Postpositon postposition = Postpositon(this);

  @override
  set start(DateTime value) {
    lapse = Lapse.between(value, father.start);
    notifyChanges();
  }

  @override
  DateTime get end => (status.isLastAnticipation
          ? father
          : father.anticipation.events[position() + 1])
      .start;
  @override
  set end(DateTime value) {
    lapse = Lapse.between(start, value).toNegative();
  }

  @override
  set length(Lapse value) {
    end = value.applyOn(start);
  }

  EventAnticipation(Event father, Lapse lapse)
      : super(father, EventType.anticipation, lapse) {
    postposition.limit = father.postposition.limit;
  }

  @override
  List<Event> selfAndChildren() =>
      status.isPostposed ? [this, postposition.event] : [this];
}

class EventReminder extends EventChild {
  @override
  int position() => father.reminder.events.indexOf(this);

  @override
  late final StatusManager status = StatusManager(this);

  @override
  set start(DateTime value) {}

  @override
  DateTime get end => status.isLastReminder
      ? father.end
      : father.reminder.events[position() + 1].start;
  @override
  set end(DateTime value) {}

  @override
  set length(Lapse value) {
    end = value.applyOn(start);
  }

  EventReminder(Event father, Lapse lapse)
      : super(father, EventType.reminder, lapse);
}

class EventRepeat extends EventChild {
  @override
  int position() => father.repeat.events.indexOf(this);
// Utility
  @override
  late final StatusManager status = StatusManager(this);
  @override
  late final TaskList tasks = TaskList(this);
  @override
  late final Anticipation anticipation = Anticipation(this);
  @override
  late final Reminder reminder = Reminder(this);
  @override
  late final Postpositon postposition = Postpositon(this);
// Vars
  @override
  DateTime get start => lapse.applyOn(father.start);
  @override
  set start(DateTime value) => length = Lapse.between(value, end);

  @override
  DateTime get end => lapse.applyOn(father.end);
  @override
  set end(DateTime value) => father.end = lapse.invert().applyOn(value);

  @override
  Lapse get length => father.length;
  @override
  set length(Lapse value) => father.length = value;

  EventRepeat(Event father, Lapse lapse)
      : super(father, EventType.reminder, lapse) {
    for (EventAnticipation it in father.anticipation.events) {
      anticipation.addByLapse(it.lapse);
    }
    postposition.limit = father.postposition.limit;
    reminder.delay = father.reminder.delay;
    tasks.incorporateAll(father.tasks.toList());
  }

// Functions
  @override
  List<Event> selfAndChildren() {
    List<Event> result = [this];
    if (status.isNotLazy) {
      for (EventChild e in [...anticipation.events, ...reminder.events]) {
        result.addAll(e.selfAndChildren());
      }
      if (status.isPostposed) {
        result.addAll(postposition.event.selfAndChildren());
      }
    }
    return result;
  }
}

class EventPostposition extends EventChild {
  @override
  int position() => 0;

  @override
  late final StatusManager status = StatusManager(this);

  @override
  late final Reminder reminder = Reminder(this);
  @override
  late final Anticipation anticipation = Anticipation(this);

  @override
  DateTime get start => father.postposition.postposed.applyOn(father.start);
  @override
  set start(DateTime value) =>
      father.postposition.postpose(Lapse.between(value, start));

  @override
  Lapse get lapse => father.postposition.postposed;
  @override
  set lapse(Lapse value) => father.postposition.postposed = value;

  @override
  Lapse get length => father.length;
  @override
  set length(Lapse value) => father.length;

  EventPostposition(Event father, Lapse lapse)
      : super(father, EventType.postposition, lapse) {
    reminder.delay = father.reminder.delay.clone();
    for (EventAnticipation it in father.anticipation.events) {
      anticipation.addByLapse(it.lapse);
    }
  }

  @override
  List<Event> selfAndChildren() => [this];

  @override
  DateTime get end => lapse.applyOn(father.end);
  @override
  set end(DateTime value) => father.length = Lapse.between(start, value);
}
