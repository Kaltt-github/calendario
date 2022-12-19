import 'enums.dart';

class Delay {
  late DelayType type;
  late int amount;

  Delay({this.type = DelayType.not, this.amount = 0}) {
    if (type == DelayType.not || amount == 0) {
      type = DelayType.not;
      amount = 0;
    } else {
      type == type;
      amount = amount;
    }
  }

  Delay.fromLapse(Lapse l) {
    var m = l._mins();
    if (m == 0) {
      type = DelayType.not;
      amount = 0;
    } else if (l.minutes != 0) {
      type = DelayType.minute;
      amount = m;
    } else if (l.hours != 0) {
      type = DelayType.hour;
      amount = m ~/ 60;
    } else {
      if (m % 10080 == 0) {
        type = DelayType.week;
        amount = m ~/ 10080;
      } else {
        type = DelayType.day;
        amount = m ~/ 1440;
      }
    }
  }

  bool get isEmpty => type == DelayType.not;

  bool get isNotEmpty => !isEmpty;

  Delay clone() => Delay(type: type, amount: amount);

  Lapse toLapse() {
    switch (type) {
      case DelayType.year:
        return Lapse(years: amount);
      case DelayType.month:
        return Lapse(months: amount);
      case DelayType.week:
        return Lapse(days: amount * 7);
      case DelayType.day:
        return Lapse(days: amount);
      case DelayType.hour:
        return Lapse(hours: amount);
      case DelayType.minute:
        return Lapse(minutes: amount);
      case DelayType.not:
        return Lapse();
    }
  }

  Delay limited({Lapse? min, Lapse? max}) {
    bool working = false;
    if (type == DelayType.not) {
      return this;
    }
    if (min != null && toLapse() < min) {
      amount++;
      working = true;
    }
    if (max != null && toLapse() > max) {
      amount--;
      if (amount == 0) {
        switch (type) {
          case DelayType.year:
            type = DelayType.month;
            amount = 365;
            break;
          case DelayType.month:
            type = DelayType.week;
            amount = 4;
            break;
          case DelayType.week:
            type = DelayType.day;
            amount = 7;
            break;
          case DelayType.day:
            type = DelayType.hour;
            amount = 24;
            break;
          case DelayType.hour:
            type = DelayType.minute;
            amount = 60;
            break;
          case DelayType.minute:
            type = DelayType.not;
            amount = 0;
            break;
          case DelayType.not:
            break;
        }
      }
      working = true;
    }
    return working ? limited(min: min, max: max) : this;
  }
}

class Lapse {
  late int years;
  late int months;
  late int days;
  late int hours;
  late int minutes;

  Lapse(
      {this.years = 0,
      this.months = 0,
      this.days = 0,
      this.hours = 0,
      this.minutes = 0});

  Lapse.between(DateTime x, DateTime y) {
    int minutes = x.difference(y).inMinutes;
    int hours = (minutes / 60).floor();
    minutes = minutes % 60;
    int days = (hours / 24).floor();
    hours = hours % 24;
    years = 0;
    months = 0;
    this.days = days;
    this.hours = hours;
    this.minutes = minutes;
  }

  int _mins() =>
      years * 525960 + months * 43830 + days * 1440 + hours * 60 + minutes;

  DateTime applyOn(DateTime date) {
    int year = date.year + years, month = date.month + months;
    while (month < 1) {
      year--;
      month += 12;
    }
    while (month > 12) {
      year++;
      month -= 12;
    }
    var x = DateTime(year, month, date.day, date.hour, date.minute);
    return x.add(Duration(days: days, hours: hours, minutes: minutes));
  }

  // Compare
  bool get isEmpty => _mins() == 0;
  bool get isNotEmpty => !isEmpty;

  bool operator >(Lapse x) => _mins() > x._mins();

  bool operator <(Lapse x) => _mins() < x._mins();

  @override
  bool operator ==(Object other) => other is Lapse && _mins() == other._mins();

  bool isDifferent(Lapse x) => !(this == x);

  bool operator >=(Lapse x) => _mins() >= x._mins();

  bool operator <=(Lapse x) => _mins() <= x._mins();

  bool isPositive() => _mins() > 0;

  bool isNegative() => _mins() < 0;
  // Math
  Lapse operator -(Lapse x) => Lapse(
        years: years - x.years,
        months: months - x.months,
        days: days - x.days,
        hours: hours - x.hours,
        minutes: minutes - x.minutes,
      );

  Lapse operator +(Lapse x) => Lapse(
        years: years + x.years,
        months: months + x.months,
        days: days + x.days,
        hours: hours + x.hours,
        minutes: minutes + x.minutes,
      );

  Lapse operator *(int x) => Lapse(
        years: years * x,
        months: months * x,
        days: days * x,
        hours: hours * x,
        minutes: minutes * x,
      );

  Lapse operator /(int x) => Lapse(
        years: years ~/ x,
        months: months ~/ x,
        days: days ~/ x,
        hours: hours ~/ x,
        minutes: minutes ~/ x,
      );

  Lapse invert() => this * -1;

  Lapse toPositive() => isPositive() ? clone() : invert();

  Lapse toNegative() => isNegative() ? clone() : invert();
  // others
  Lapse limited({Lapse? min, Lapse? max}) => (min ?? this) > this
      ? min!
      : this > (max ?? this)
          ? max!
          : this;

  Lapse clone() => Lapse(
      years: years, months: months, days: days, hours: hours, minutes: minutes);

  @override
  int get hashCode => _mins.hashCode;
}
