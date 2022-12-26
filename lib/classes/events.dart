// ignore_for_file: prefer_final_fields

import 'package:calendario/classes/funs.dart';

import 'time.dart';
import 'enums.dart';
import 'tag.dart';
import 'tasks.dart';

class Event implements Comparable {
  // Config
  String get id => throw UnimplementedError();
  set id(String value) => throw UnimplementedError();
  DateTime get lastUpadte => throw UnimplementedError();
  set lastUpadte(DateTime value) => throw UnimplementedError();
  FromType get from => throw UnimplementedError();
  EventType get type => throw UnimplementedError();
  String get owner => throw UnimplementedError();
  Event get father => throw UnimplementedError();
  // Utility
  bool get _lazy => throw UnimplementedError();
  bool get _complete => throw UnimplementedError();
  bool get _cancel => throw UnimplementedError();
  set _lazy(bool value) => throw UnimplementedError();
  set _complete(bool value) => throw UnimplementedError();
  set _cancel(bool value) => throw UnimplementedError();
  bool get _dependent => throw UnimplementedError();
  bool get _hasAnticipations => throw UnimplementedError();
  bool get _hasReminders => throw UnimplementedError();
  bool get _hasRepeats => throw UnimplementedError();
  bool get _hasPostposition => throw UnimplementedError();
  TaskList get tasks => throw UnimplementedError();

  // Vars
  String get name => throw UnimplementedError();
  set name(String value) => throw UnimplementedError();

  String get description => throw UnimplementedError();
  set description(String value) => throw UnimplementedError();

  Tag get tag => throw UnimplementedError();
  set tag(Tag value) => throw UnimplementedError();

  Icon get icon => throw UnimplementedError();
  set icon(Icon value) => throw UnimplementedError();

  int get color => throw UnimplementedError();
  set color(int value) => throw UnimplementedError();

  int get priority => throw UnimplementedError();
  set priority(int value) => throw UnimplementedError();

  List<String> get shared => throw UnimplementedError();

  DateTime get start => throw UnimplementedError();
  set start(DateTime value) => throw UnimplementedError();

  DateTime get end => throw UnimplementedError();
  set end(DateTime value) => throw UnimplementedError();

  Lapse get length => throw UnimplementedError();
  set length(Lapse value) => throw UnimplementedError();

  bool get isFullDay => throw UnimplementedError();
  set isFullDay(bool value) => throw UnimplementedError();

  // CHILDREN
  // Anticipation
  List<EventAnticipation> get anticipations => throw UnimplementedError();
  void addAnticipationByLapse(Lapse lapse) => throw UnimplementedError();
  void addAnticipationByDate(DateTime date) => throw UnimplementedError();
  void removeAnticipationByLapse(Lapse lapse) => throw UnimplementedError();
  void removeAnticipationByDate(DateTime start) => throw UnimplementedError();
  // Reminder
  List<EventReminder> get reminders => throw UnimplementedError();
  Delay get reminderDelay => throw UnimplementedError();
  set reminderDelay(Delay value) => throw UnimplementedError();
  // Repeat
  List<EventRepeat> get repeats => throw UnimplementedError();
  Delay get repeatDelay => throw UnimplementedError();
  set repeatDelay(Delay value) => throw UnimplementedError();

  Lapse get repeatLimit => throw UnimplementedError();
  set repeatLimit(Lapse value) => throw UnimplementedError();

  DateTime get repeatLimitDate => throw UnimplementedError();
  set repeatLimitDate(DateTime value) => throw UnimplementedError();
  // Postposition
  EventPostposition get postposition => throw UnimplementedError();
  Lapse get postpositionLimit => throw UnimplementedError();
  set postpositionLimit(Lapse value) => throw UnimplementedError();

  DateTime get postpositionLimitDate => throw UnimplementedError();
  set postpositionLimitDate(DateTime value) => throw UnimplementedError();

  Lapse get postposed => throw UnimplementedError();
  set postposed(Lapse value) => throw UnimplementedError();

  Lapse get postpositionLeft => throw UnimplementedError();
  set postpositionLeft(Lapse value) => throw UnimplementedError();
  bool postpose(Lapse lapse) => throw UnimplementedError();
  // Functions
  List<Event> selfAndChildren() => throw UnimplementedError();
  void notifyChanges() => throw UnimplementedError();
  void addShared(String email) => throw UnimplementedError();
  void removeShared(String email) => throw UnimplementedError();
  @override
  bool operator ==(Object other) => throw UnimplementedError();
  @override
  int get hashCode => throw UnimplementedError();
  @override
  int compareTo(other) => throw UnimplementedError();
  // Status IMPLEMENTED
  bool get isFather => type == EventType.father;
  bool get isNotFather => !isNotFather;

  bool get isChild => !isFather;
  bool get isNotChild => !isChild;

  bool get isAnticipation => type == EventType.anticipation;
  bool get isNotAnticipation => !isAnticipation;

  bool get isReminder => type == EventType.reminder;
  bool get isNotReminder => !isReminder;

  bool get isRepeat => type == EventType.repeat;
  bool get isNotRepeat => !isRepeat;

  bool get isPostposition => type == EventType.postposition;
  bool get isNotPostposition => !isPostposition;

  bool get isPostponeable => _hasPostposition;
  bool get isNotPostponeable => !isPostponeable;

  bool get isAnticipable => _hasAnticipations;
  bool get isNotAnticipable => !isAnticipable;

  bool get isRemindable => _hasReminders;
  bool get isNotRemindable => !isRemindable;

  bool get isRepeatable => _hasRepeats;
  bool get isNotRepeatable => !isRepeatable;

  bool get isPostposed => isPostponeable && postposed.isNotEmpty;
  bool get isNotPostposed => !isPostposed;

  bool get isReminded => isRemindable && reminderDelay.isNotEmpty;
  bool get isNotReminded => !isReminded;

  bool get isAnticipated => isAnticipable && anticipations.isNotEmpty;
  bool get isNotAnticipated => !isAnticipated;

  bool get isRepeated => isRepeatable && repeatDelay.isNotEmpty;
  bool get isNotRepeated => !isRepeated;

  bool _isLast<E extends EventChild>(List<E> list) =>
      list.length - 1 == (this as EventChild).position();

  bool get isLastReminder => isReminder && _isLast(reminders);
  bool get isNotLastReminder => !isLastReminder;

  bool get isLastRepeat => isRepeat && _isLast(repeats);
  bool get isNotLastRepeat => !isLastRepeat;

  bool get isLastAnticipation => isAnticipation && _isLast(anticipations);
  bool get isNotLastAnticipation => !isLastAnticipation;

  bool get isLazy => _lazy;
  set isLazy(bool value) {
    _lazy = value;
    if (value) {
      anticipations.clear();
      reminderDelay = Delay(type: DelayType.not);
      repeatDelay = Delay(type: DelayType.not);
      postpositionLimit = Lapse();
    }
    notifyChanges();
  }

  bool get isNotLazy => !isLazy;
  set isNotLazy(bool value) => isLazy = !value;

  bool get isComplete => _complete || (_dependent && father.isComplete);
  set isComplete(bool value) {
    if (isPostposition) {
      father.isComplete = value;
    }
    _complete = value;
    notifyChanges();
  }

  bool get isNotComplete => !isComplete;
  set isNotComplete(bool value) => isComplete = !value;

  bool get isCancelled => _cancel || (_dependent && father.isCancelled);
  set isCancelled(bool value) {
    _cancel = value;
    notifyChanges();
  }

  bool get isNotCancelled => !isCancelled;
  set isNotCancelled(bool value) => isCancelled = !value;

  bool get isActive => isNotComplete && (isInDate || isLazy) && isNotCancelled;

  bool get isNotActive => !isActive;

  bool get isExpired =>
      isNotComplete && (isPostposed || isNotInDate || isNotLazy);
  bool get isNotExpired => !isExpired;

  bool get isInDate {
    var now = DateTime.now();
    return (now.isAfter(start) || now.isAtSameMomentAs(start)) &&
        (now.isBefore(end) || now.isAtSameMomentAs(end));
  }

  bool get isNotInDate => !isInDate;

  bool get isLost =>
      isExpired && (isNotPostposed || (isPostposed && postposition.isExpired));
  bool get isNotLost => !isLost;

  int _deepth() => isFather ? 1 : father._deepth() + 1;
}

class EventFather extends Event {
  // SAVING VARS
  @override
  bool _lazy = false;
  @override
  bool _complete = false;
  @override
  bool _cancel = false;
  @override
  bool get _dependent => false;
  @override
  bool get _hasAnticipations => true;
  @override
  bool get _hasReminders => true;
  @override
  bool get _hasRepeats => true;
  @override
  bool get _hasPostposition => true;
  // Private
  String _name = 'New';
  String _description = '';
  late Tag _tag;
  late Icon _icon;
  late int _color;
  late int _priority;
  List<String> _shared = [];
  late Lapse _length;
  bool _isFullDay = false;
  late DateTime _start;
  // Public
  @override
  late final String id;
  @override
  DateTime lastUpadte;
  @override
  late final String owner;
  // Utils
  @override
  late final TaskList tasks = TaskList(this);

  List<EventAnticipation> _anticipations = [];

  Delay _reminderDelay = Delay();
  List<EventReminder> _reminders = [];

  Delay _repeatDelay = Delay();
  Lapse _repeatLimit = Lapse();
  List<EventRepeat> _repeats = [];

  @override
  late final EventPostposition postposition = EventPostposition(this);
  Lapse _postpositionLimit = Lapse();
  Lapse _postposed = Lapse();

  // Config
  @override
  final EventType type = EventType.father;
  @override
  late final FromType from;
  @override
  late final Event father = this;

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
    _color = limitBetween(0, value, 360);
    notifyChanges();
  }

  @override
  int get priority => _priority;
  @override
  set priority(int value) {
    _priority = limitBetween(0, value, 10);
    notifyChanges();
  }

  @override
  // ignore: unnecessary_string_interpolations
  List<String> get shared => _shared.map((e) => '$e').toList();

  @override
  DateTime get start => isLazy
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
  Lapse get length => isLazy ? Lapse(days: 1) : _length;
  @override
  set length(Lapse value) {
    _length = value.limited(min: Lapse(minutes: 1));
    reminderDelay = reminderDelay.clone();
    notifyChanges();
  }

  @override
  bool get isFullDay => _isFullDay;
  @override
  set isFullDay(bool value) {
    _isFullDay = value;
    notifyChanges();
  }

  // Children
  // Anticipations
  List<Event> get _anticipateds {
    var result = <Event>[];
    for (Event it in [this, ...repeats]) {
      result.addAll([it, it.postposition]);
    }
    return result;
  }

  @override
  List<EventAnticipation> get anticipations => _anticipations;
  // Reminders
  List<Event> get _remindeds => _anticipateds;
  @override
  List<EventReminder> get reminders => _reminders;
  @override
  Delay get reminderDelay => _reminderDelay;
  @override
  set reminderDelay(Delay value) {
    value = value.limited(min: Lapse(minutes: 1), max: length);
    if (value.type == DelayType.not) {
      for (Event it in _remindeds) {
        it.reminders.clear();
      }
    } else {
      Lapse lapse = value.toLapse();
      _reminderDelay = value;
      for (Event it in _remindeds) {
        List<EventReminder> subevents = it.reminders;
        DateTime start = lapse.applyOn(it.start);
        int i = 0;
        while (start.isBefore(it.end)) {
          Lapse nl = lapse * (i + 1);
          if (subevents.length <= i) {
            subevents.add(EventReminder(it, nl));
          } else {
            subevents[i].lapse = nl;
          }
          start = nl.applyOn(it.start);
          i++;
        }
        it.reminders.removeRange(i, it.reminders.length);
      }
    }
    notifyChanges();
  }

  // Repeats
  @override
  List<EventRepeat> get repeats => _repeats;
  @override
  Delay get repeatDelay => _repeatDelay;
  @override
  set repeatDelay(Delay value) {
    _repeatDelay = value;
    if (value.type == DelayType.not) {
      repeats.clear();
      return;
    }
    Lapse lapse = value.toLapse();
    DateTime start = lapse.applyOn(this.start), limit = repeatLimitDate;
    int i = 0;
    while (start.isBefore(limit) && i < 100) {
      Lapse newlapse = lapse * (i + 1);
      if (repeats.length > i) {
        repeats[i]._lapse = newlapse;
      } else {
        repeats.add(EventRepeat(this, newlapse));
      }
      start = repeats[i].start;
      i++;
    }
    _repeats = repeats.sublist(0, i);
    notifyChanges();
  }

  @override
  Lapse get repeatLimit => _repeatLimit;
  @override
  set repeatLimit(Lapse value) {
    value = value.limited(min: Lapse());
    if (repeatLimit > value) {
      _repeatLimit = value;
      repeats.removeWhere((it) => it.start.isAfter(repeatLimitDate));
      notifyChanges();
    } else {
      _repeatLimit = value;
      repeatDelay = repeatDelay.clone();
    }
  }

  @override
  DateTime get repeatLimitDate =>
      (repeatLimit.isEmpty ? Lapse(years: 10) : repeatLimit).applyOn(start);
  @override
  set repeatLimitDate(DateTime value) =>
      repeatLimit = Lapse.between(value, start);

  // Postposition
  List<Event> get _postposeables => [this, ...repeats];
  @override
  Lapse get postpositionLimit => _postpositionLimit;
  @override
  set postpositionLimit(Lapse value) {
    value = value.limited(min: Lapse());
    _postpositionLimit = value;
    for (Event it in _postposeables) {
      if (it.postposed > value) {
        it.postposed = value.clone();
      }
    }
    notifyChanges();
  }

  @override
  DateTime get postpositionLimitDate => postpositionLimit.applyOn(start);
  @override
  set postpositionLimitDate(DateTime value) =>
      postpositionLimit = Lapse.between(value, start);
  @override
  Lapse get postposed => _postposed;
  @override
  set postposed(Lapse value) {
    _postposed = value.limited(min: Lapse());
    notifyChanges();
  }

  @override
  Lapse get postpositionLeft => postpositionLimit - postposed;
  @override
  set postpositionLeft(Lapse value) => postposed = postpositionLimit - value;

  // Functions
  @override
  void addAnticipationByLapse(Lapse lapse) {
    lapse = lapse.limited(max: Lapse(minutes: -1));
    if (anticipations.where((it) => it.lapse == lapse).isNotEmpty) {
      return;
    }
    for (Event it in _anticipateds) {
      it.anticipations.add(EventAnticipation(it, lapse));
    }
    notifyChanges();
  }

  @override
  void addAnticipationByDate(DateTime date) =>
      addAnticipationByLapse(Lapse.between(date, start));

  @override
  void removeAnticipationByLapse(Lapse lapse) {
    for (Event it in _anticipateds) {
      it.anticipations.removeWhere((it) => it.lapse == lapse);
    }
    notifyChanges();
  }

  @override
  void removeAnticipationByDate(DateTime start) =>
      removeAnticipationByLapse(Lapse.between(start, this.start));
  @override
  bool postpose(Lapse lapse) {
    var result = lapse + postposed;
    if (result >= postpositionLimit) {
      return false;
    }
    postposed = result;
    return true;
  }

  @override
  List<Event> selfAndChildren() {
    List<Event> result = [this];
    if (isNotLazy) {
      for (EventChild e in [...anticipations, ...reminders, ...repeats]) {
        result.addAll(e.selfAndChildren());
      }
      if (isPostposed) {
        result.addAll(postposition.selfAndChildren());
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
        id = buildId(),
        _tag = tag ?? Tag.appTag() {
    _tag.applyOn(this);
  }
  @override
  int compareTo(other) {
    if (other is Event) {
      if (other.start.isBefore(start)) {
        return -1;
      }
      if (other.start.isAfter(start)) {
        return 1;
      }
      return 0;
    } else {
      return 1;
    }
  }

  @override
  bool operator ==(Object other) => other is EventFather && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    String s = '  ' * _deepth();
    return '''EventFather {
${s}id: $id,
${s}lastUpadte: $lastUpadte,
${s}from: $from,
${s}type: $type,
${s}owner: $owner,
${s}tasks: $tasks,
${s}name: $name,
${s}description: $description,
${s}tag: $tag,
${s}icon: $icon,
${s}color: $color,
${s}priority: $priority,
${s}shared: $shared,
${s}start: $start,
${s}end: $end,
${s}length: $length,
${s}isFullDay: $isFullDay,
${s}anticipations: $anticipations,
${s}reminders: $reminders,
${s}reminderDelay: $reminderDelay,
${s}repeats: $repeats,
${s}repeatDelay: $repeatDelay,
${s}repeatLimit: $repeatLimit,
${s}repeatLimitDate: $repeatLimitDate,
${s}postposition: $postposition,
${s}postpositionLimit: $postpositionLimit,
${s}postpositionLimitDate: $postpositionLimitDate,
${s}postposed: $postposed,
${s}postpositionLeft: $postpositionLeft,
${s}isFather: $isFather,
${s}isChild: $isChild,
${s}isAnticipation: $isAnticipation,
${s}isReminder: $isReminder,
${s}isRepeat: $isRepeat,
${s}isPostposition: $isPostposition,
${s}isPostponeable: $isPostponeable,
${s}isAnticipable: $isAnticipable,
${s}isRemindable: $isRemindable,
${s}isRepeatable: $isRepeatable,
${s}isPostposed: $isPostposed,
${s}isReminded: $isReminded,
${s}isAnticipated: $isAnticipated,
${s}isRepeated: $isRepeated,
${s}isLastReminder: $isLastReminder,
${s}isLastRepeat: $isLastRepeat,
${s}isLastAnticipation: $isLastAnticipation,
${s}isLazy: $isLazy,
${s}isComplete: $isComplete,
${s}isCancelled: $isCancelled,
${s}isActive: $isActive,
${s}isExpired: $isExpired,
${s}isInDate: $isInDate,
${s}isLost: $isLost,
${"  " * (_deepth() - 1)}}''';
  }
}

class EventChild extends Event {
  @override
  bool _lazy = false;
  @override
  bool _complete = false;
  @override
  bool _cancel = false;
  @override
  bool get _dependent => true;
  @override
  bool get _hasAnticipations => false;
  @override
  bool get _hasReminders => false;
  @override
  bool get _hasRepeats => false;
  @override
  bool get _hasPostposition => false;
  // Local
  int position() => throw UnimplementedError();

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
  DateTime get start => lapse.applyOn(father.start);
  @override
  Lapse get length => Lapse.between(start, end);
  @override
  bool get isFullDay => father.isFullDay;
  @override
  set isFullDay(bool value) => father.isFullDay = value;
  // Children
  // Anticipations
  @override
  List<EventAnticipation> get anticipations => father.anticipations;
  // Reminders
  @override
  List<EventReminder> get reminders => father.reminders;

  @override
  Delay get reminderDelay => father.reminderDelay;
  @override
  set reminderDelay(Delay value) => father.reminderDelay = value;
  // Repeats
  @override
  List<EventRepeat> get repeats => father.repeats;

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

  // Postposition
  @override
  Lapse get postpositionLimit => father.postpositionLimit;
  @override
  set postpositionLimit(Lapse value) => father.postpositionLimit = value;

  @override
  DateTime get postpositionLimitDate => father.postpositionLimitDate;
  @override
  set postpositionLimitDate(DateTime value) =>
      father.postpositionLimitDate = value;

  @override
  Lapse get postposed => father.postposed;
  @override
  set postposed(Lapse value) => father.postposed;

  @override
  Lapse get postpositionLeft => father.postpositionLeft;
  @override
  set postpositionLeft(Lapse value) => father.postpositionLeft = value;
// Functions
  @override
  List<Event> selfAndChildren() => [this];
  @override
  void notifyChanges() => father.notifyChanges();
  @override
  void addShared(String email) => father.addShared(email);
  @override
  void removeShared(String email) => father.removeShared(email);
  @override
  int compareTo(other) {
    if (other is Event) {
      if (other.start.isBefore(start)) {
        return -1;
      }
      if (other.start.isAfter(start)) {
        return 1;
      }
      return 0;
    } else {
      return 1;
    }
  }

  @override
  void addAnticipationByDate(DateTime date) =>
      father.addAnticipationByDate(date);
  @override
  void addAnticipationByLapse(Lapse lapse) =>
      father.addAnticipationByLapse(lapse);
  @override
  void removeAnticipationByDate(DateTime start) =>
      father.removeAnticipationByDate(start);
  @override
  void removeAnticipationByLapse(Lapse lapse) =>
      father.removeAnticipationByLapse(lapse);
  @override
  EventPostposition get postposition => father.postposition;
  @override
  bool postpose(Lapse lapse) => father.postpose(lapse);
  @override
  bool operator ==(Object other) =>
      other is EventChild &&
      other.father == father &&
      other.type == type &&
      other.position() == position();

  @override
  int get hashCode => id.hashCode;

  EventChild(this.father, this.type, this._lapse);
}

class EventAnticipation extends EventChild {
  @override
  int position() => father.anticipations.indexWhere((it) => it.lapse == lapse);

  @override
  set start(DateTime value) {
    lapse = Lapse.between(value, father.start);
    notifyChanges();
  }

  @override
  DateTime get end =>
      (isLastAnticipation ? father : father.anticipations[position() + 1])
          .start;
  @override
  set end(DateTime value) => lapse = Lapse.between(start, value).toNegative();

  @override
  set length(Lapse value) => end = value.applyOn(start);

  EventAnticipation(Event father, Lapse lapse)
      : super(father, EventType.anticipation, lapse);

  @override
  List<Event> selfAndChildren() => [this];

  @override
  String toString() {
    String s = '  ' * _deepth();
    return '''EventAnticipation {
${s}lastUpadte: $lastUpadte,
${s}type: $type,
${s}tasks: $tasks,
${s}start: $start,
${s}end: $end,
${s}length: $length,
${s}isFullDay: $isFullDay,
${s}isFather: $isFather,
${s}isChild: $isChild,
${s}isAnticipation: $isAnticipation,
${s}isReminder: $isReminder,
${s}isRepeat: $isRepeat,
${s}isPostposition: $isPostposition,
${s}isPostponeable: $isPostponeable,
${s}isAnticipable: $isAnticipable,
${s}isRemindable: $isRemindable,
${s}isRepeatable: $isRepeatable,
${s}isPostposed: $isPostposed,
${s}isReminded: $isReminded,
${s}isAnticipated: $isAnticipated,
${s}isRepeated: $isRepeated,
${s}isLastReminder: $isLastReminder,
${s}isLastRepeat: $isLastRepeat,
${s}isLastAnticipation: $isLastAnticipation,
${s}isLazy: $isLazy,
${s}isComplete: $isComplete,
${s}isCancelled: $isCancelled,
${s}isActive: $isActive,
${s}isExpired: $isExpired,
${s}isInDate: $isInDate,
${s}isLost: $isLost,
${"  " * (_deepth() - 1)}}''';
  }
}

class EventReminder extends EventChild {
  @override
  int position() => father.reminders.indexWhere((it) => it.lapse == lapse);

  @override
  set start(DateTime value) {}

  @override
  DateTime get end =>
      isLastReminder ? father.end : father.reminders[position() + 1].start;
  @override
  set end(DateTime value) {}

  @override
  set length(Lapse value) {
    end = value.applyOn(start);
  }

  EventReminder(Event father, Lapse lapse)
      : super(father, EventType.reminder, lapse);

  @override
  String toString() {
    String s = '  ' * _deepth();
    return '''EventReminder {
${s}lastUpadte: $lastUpadte,
${s}type: $type,
${s}tasks: $tasks,
${s}start: $start,
${s}end: $end,
${s}length: $length,
${s}isFullDay: $isFullDay,
${s}isFather: $isFather,
${s}isChild: $isChild,
${s}isAnticipation: $isAnticipation,
${s}isReminder: $isReminder,
${s}isRepeat: $isRepeat,
${s}isPostposition: $isPostposition,
${s}isPostponeable: $isPostponeable,
${s}isAnticipable: $isAnticipable,
${s}isRemindable: $isRemindable,
${s}isRepeatable: $isRepeatable,
${s}isPostposed: $isPostposed,
${s}isReminded: $isReminded,
${s}isAnticipated: $isAnticipated,
${s}isRepeated: $isRepeated,
${s}isLastReminder: $isLastReminder,
${s}isLastRepeat: $isLastRepeat,
${s}isLastAnticipation: $isLastAnticipation,
${s}isLazy: $isLazy,
${s}isComplete: $isComplete,
${s}isCancelled: $isCancelled,
${s}isActive: $isActive,
${s}isExpired: $isExpired,
${s}isInDate: $isInDate,
${s}isLost: $isLost,
${"  " * (_deepth() - 1)}}''';
  }
}

class EventRepeat extends EventChild {
  @override
  bool get _dependent => false;
  @override
  bool get _hasAnticipations => true;
  @override
  bool get _hasReminders => true;
  @override
  bool get _hasPostposition => true;
  @override
  int position() => father.repeats.indexWhere((it) => it.lapse == lapse);

  // Utils
  @override
  late final TaskList tasks = TaskList(this);

  List<EventAnticipation> _anticipations = [];
  @override
  List<EventAnticipation> get anticipations => _anticipations;

  List<EventReminder> _reminders = [];
  @override
  List<EventReminder> get reminders => _reminders;

  @override
  late final EventPostposition postposition = EventPostposition(this);
  Lapse _postposed = Lapse();

  @override
  DateTime get postpositionLimitDate => postpositionLimit.applyOn(start);
  @override
  set postpositionLimitDate(DateTime value) =>
      postpositionLimit = Lapse.between(start, value);
  @override
  Lapse get postposed => _postposed;
  @override
  set postposed(Lapse value) {
    _postposed = value.limited(min: Lapse());
    notifyChanges();
  }

  @override
  Lapse get postpositionLeft => postpositionLimit - postposed;
  @override
  set postpositionLeft(Lapse value) => postposed = postpositionLimit - value;

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
    tasks.incorporateAll(father.tasks.toList());
    _anticipations = father.anticipations
        .map((it) => EventAnticipation(this, it.lapse))
        .toList();
    _reminders =
        father.reminders.map((it) => EventReminder(this, it.lapse)).toList();
  }

// Functions
  @override
  List<Event> selfAndChildren() {
    List<Event> result = [this];
    if (isNotLazy) {
      for (EventChild e in [...anticipations, ...reminders]) {
        result.addAll(e.selfAndChildren());
      }
      if (isPostposed) {
        result.addAll(postposition.selfAndChildren());
      }
    }
    return result;
  }

  @override
  String toString() {
    String s = '  ' * _deepth();
    return '''EventRepeat {
${s}lastUpadte: $lastUpadte,
${s}type: $type,
${s}tasks: $tasks,
${s}start: $start,
${s}end: $end,
${s}length: $length,
${s}isFullDay: $isFullDay,
${s}anticipations: $anticipations,
${s}reminders: $reminders,
${s}reminderDelay: $reminderDelay,
${s}postposition: $postposition,
${s}postpositionLimit: $postpositionLimit,
${s}postpositionLimitDate: $postpositionLimitDate,
${s}postposed: $postposed,
${s}postpositionLeft: $postpositionLeft,
${s}isFather: $isFather,
${s}isChild: $isChild,
${s}isAnticipation: $isAnticipation,
${s}isReminder: $isReminder,
${s}isRepeat: $isRepeat,
${s}isPostposition: $isPostposition,
${s}isPostponeable: $isPostponeable,
${s}isAnticipable: $isAnticipable,
${s}isRemindable: $isRemindable,
${s}isRepeatable: $isRepeatable,
${s}isPostposed: $isPostposed,
${s}isReminded: $isReminded,
${s}isAnticipated: $isAnticipated,
${s}isRepeated: $isRepeated,
${s}isLastReminder: $isLastReminder,
${s}isLastRepeat: $isLastRepeat,
${s}isLastAnticipation: $isLastAnticipation,
${s}isLazy: $isLazy,
${s}isComplete: $isComplete,
${s}isCancelled: $isCancelled,
${s}isActive: $isActive,
${s}isExpired: $isExpired,
${s}isInDate: $isInDate,
${s}isLost: $isLost,
${"  " * (_deepth() - 1)}}''';
  }
}

class EventPostposition extends EventChild {
  @override
  int position() => 0;
  @override
  bool get _hasAnticipations => true;
  @override
  bool get _hasReminders => true;

  List<EventAnticipation> _anticipations = [];
  @override
  List<EventAnticipation> get anticipations => _anticipations;

  List<EventReminder> _reminders = [];
  @override
  List<EventReminder> get reminders => _reminders;

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

  EventPostposition(Event father)
      : super(father, EventType.postposition, Lapse()) {
    _anticipations = father.anticipations
        .map((it) => EventAnticipation(this, it.lapse))
        .toList();
    _reminders =
        father.reminders.map((it) => EventReminder(this, it.lapse)).toList();
  }

  @override
  List<Event> selfAndChildren() => [this];

  @override
  DateTime get end => lapse.applyOn(father.end);
  @override
  set end(DateTime value) => father.length = Lapse.between(start, value);

  @override
  String toString() {
    String s = '  ' * _deepth();
    return '''EventPostposition {
${s}lastUpadte: $lastUpadte,
${s}type: $type,
${s}tasks: $tasks,
${s}start: $start,
${s}end: $end,
${s}length: $length,
${s}isFullDay: $isFullDay,
${s}anticipations: $anticipations,
${s}reminders: $reminders,
${s}reminderDelay: $reminderDelay,
${s}isFather: $isFather,
${s}isChild: $isChild,
${s}isAnticipation: $isAnticipation,
${s}isReminder: $isReminder,
${s}isRepeat: $isRepeat,
${s}isPostposition: $isPostposition,
${s}isPostponeable: $isPostponeable,
${s}isAnticipable: $isAnticipable,
${s}isRemindable: $isRemindable,
${s}isRepeatable: $isRepeatable,
${s}isPostposed: $isPostposed,
${s}isReminded: $isReminded,
${s}isAnticipated: $isAnticipated,
${s}isRepeated: $isRepeated,
${s}isLastReminder: $isLastReminder,
${s}isLastRepeat: $isLastRepeat,
${s}isLastAnticipation: $isLastAnticipation,
${s}isLazy: $isLazy,
${s}isComplete: $isComplete,
${s}isCancelled: $isCancelled,
${s}isActive: $isActive,
${s}isExpired: $isExpired,
${s}isInDate: $isInDate,
${s}isLost: $isLost,
${"  " * (_deepth() - 1)}}''';
  }
}
