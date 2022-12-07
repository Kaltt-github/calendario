// ignore_for_file: file_names, avoid_print

import 'package:calendario/classes/enums.dart';
import 'package:calendario/classes/time.dart';

void testDelay() {
  var a = Delay(type: DelayType.hour, amount: 5),
      b = Delay(type: DelayType.not, amount: 5),
      c = Delay(type: DelayType.hour, amount: 0),
      d = Delay(type: DelayType.not, amount: 0),
      e = DelayType.hour,
      f = 5,
      g = a.clone(),
      h = c.clone();
  if (a.type != e || a.amount != f) {
    print('${a.type} != $e || ${a.amount} != $f');
  }
  e = DelayType.not;
  f = 0;
  if (b.type != e || b.amount != f) {
    print('${b.type} != $e || ${b.amount} != $f');
  }
  if (c.type != e || c.amount != f) {
    print('${c.type} != $e || ${c.amount} != $f');
  }
  if (d.type != e || d.amount != f) {
    print('${d.type} != $e || ${d.amount} != $f');
  }
  if (a.isEmpty() || b.isNotEmpty() || c.isNotEmpty() || d.isNotEmpty()) {
    print(
        '${a.isEmpty()} || ${b.isNotEmpty()} || ${c.isNotEmpty()} || ${d.isNotEmpty()}');
  }
  if (g.type != a.type || g.amount != a.amount) {
    print('${g.type} != ${a.type} || ${g.amount} != ${a.amount}');
  }
  if (h.type != c.type || h.amount != c.amount) {
    print('${h.type} != ${c.type} || ${h.amount} != ${c.amount}');
  }
  var i = Delay(type: DelayType.year, amount: 3).toLapse(),
      j = Delay(type: DelayType.month, amount: 4).toLapse(),
      k = Delay(type: DelayType.week, amount: 5).toLapse(),
      l = Delay(type: DelayType.day, amount: 6).toLapse(),
      m = Delay(type: DelayType.hour, amount: 7).toLapse(),
      n = Delay(type: DelayType.minute, amount: 8).toLapse(),
      o = Delay(type: DelayType.not, amount: 9).toLapse(),
      p = 3,
      q = 0,
      r = 0,
      s = 0,
      t = 0,
      v = i;
  if (v.years != p ||
      v.months != q ||
      v.days != r ||
      v.hours != s ||
      v.minutes != t) {
    print(
        '${v.years} != $p || ${v.months} != $q || ${v.days} != $r || ${v.hours} != $s || ${v.minutes} != $t');
  }
  v = j;
  p = 0;
  q = 4;
  if (v.years != p ||
      v.months != q ||
      v.days != r ||
      v.hours != s ||
      v.minutes != t) {
    print(
        '${v.years} != $p || ${v.months} != $q || ${v.days} != $r || ${v.hours} != $s || ${v.minutes} != $t');
  }
  v = k;
  q = 0;
  r = 5 * 7;
  if (v.years != p ||
      v.months != q ||
      v.days != r ||
      v.hours != s ||
      v.minutes != t) {
    print(
        '${v.years} != $p || ${v.months} != $q || ${v.days} != $r || ${v.hours} != $s || ${v.minutes} != $t');
  }
  v = l;
  r = 6;
  if (v.years != p ||
      v.months != q ||
      v.days != r ||
      v.hours != s ||
      v.minutes != t) {
    print(
        '${v.years} != $p || ${v.months} != $q || ${v.days} != $r || ${v.hours} != $s || ${v.minutes} != $t');
  }
  v = m;
  r = 0;
  s = 7;
  if (v.years != p ||
      v.months != q ||
      v.days != r ||
      v.hours != s ||
      v.minutes != t) {
    print(
        '${v.years} != $p || ${v.months} != $q || ${v.days} != $r || ${v.hours} != $s || ${v.minutes} != $t');
  }
  v = n;
  s = 0;
  t = 8;
  if (v.years != p ||
      v.months != q ||
      v.days != r ||
      v.hours != s ||
      v.minutes != t) {
    print(
        '${v.years} != $p || ${v.months} != $q || ${v.days} != $r || ${v.hours} != $s || ${v.minutes} != $t');
  }
  v = o;
  t = 0;
  if (v.years != p ||
      v.months != q ||
      v.days != r ||
      v.hours != s ||
      v.minutes != t) {
    print(
        '${v.years} != $p || ${v.months} != $q || ${v.days} != $r || ${v.hours} != $s || ${v.minutes} != $t');
  }

  var aa = Delay.fromLapse(Lapse(years: 5)),
      bb = Delay.fromLapse(Lapse(days: 14)),
      cc = Delay.fromLapse(Lapse(months: 1, days: 7)),
      dd = Delay.fromLapse(Lapse(days: 1, hours: 5)),
      ee = Delay.fromLapse(Lapse(hours: 2, minutes: 30)),
      ff = Delay.fromLapse(Lapse()),
      t1 = aa,
      t2 = DelayType.year,
      t3 = 5;

  t1 = bb;
  t2 = DelayType.week;
  t3 = 2;
  if (t1.type != t2 || t1.amount != t3) {
    print('${t1.type} != $t2 || ${t1.amount} != $t3');
  }
  t1 = cc;
  t2 = DelayType.day;
  t3 = 37;
  if (t1.type != t2 || t1.amount != t3) {
    print('${t1.type} != $t2 || ${t1.amount} != $t3');
  }
  t1 = dd;
  t2 = DelayType.hour;
  t3 = 29;
  if (t1.type != t2 || t1.amount != t3) {
    print('${t1.type} != $t2 || ${t1.amount} != $t3');
  }
  t1 = ee;
  t2 = DelayType.minute;
  t3 = 150;
  if (t1.type != t2 || t1.amount != t3) {
    print('${t1.type} != $t2 || ${t1.amount} != $t3');
  }
  t1 = ff;
  t2 = DelayType.not;
  t3 = 0;
  if (t1.type != t2 || t1.amount != t3) {
    print('${t1.type} != $t2 || ${t1.amount} != $t3');
  }
}

void testLapse() {
  var a = DateTime(2020, 10, 3, 4, 5),
      b = DateTime(2021, 1, 2, 3, 4),
      c = Lapse.between(a, b),
      d = Lapse.between(b, a),
      g = c.applyOn(b),
      h = d.applyOn(a),
      i = Lapse(hours: -1, minutes: 60),
      j = Lapse(days: 1),
      k = Lapse(days: 2),
      m = Lapse(hours: 24);
  if (!a.isAtSameMomentAs(h)) {
    print('$a != $h');
  }
  if (!b.isAtSameMomentAs(g)) {
    print('$b != $g');
  }
  if (i.isNotEmpty() || Lapse().isNotEmpty()) {
    print('empty error');
  }
  if (c.isEmpty()) {
    print('not empty error');
  }
  if (!(j.isLessThan(k) &&
      j.isLessOrEqual(k) &&
      j.isLessOrEqual(m) &&
      j.isEqual(m) &&
      k.isMoreOrEqual(j) &&
      k.isMoreThan(j) &&
      j.isDifferent(k))) {
    print(
        '${j.isLessThan(k)} && ${j.isLessOrEqual(k)} && ${j.isLessOrEqual(m)} && ${j.isEqual(m)} && ${k.isMoreOrEqual(j)} && ${k.isMoreThan(j)} && ${j.isDifferent(k)}');
  }
  if (!d.isPositive() || d.isNegative()) {
    print('d positive error');
  }
  if (c.isPositive() || !c.isNegative()) {
    print('c negative error');
  }
  var aa = Lapse(years: 1, months: 2, days: -3, hours: 5, minutes: -5),
      bb = aa.take(Lapse(months: 1, days: -1)),
      cc = aa.add(Lapse(years: 3, minutes: 10)),
      dd = aa.multiply(3),
      ee = aa.divide(2),
      ff = aa.invert(),
      gg = aa.clone(),
      yr = 1,
      mo = 1,
      dy = -2,
      hr = 5,
      mn = -5,
      xx = bb;
  if (xx.years != yr ||
      xx.months != mo ||
      xx.days != dy ||
      xx.hours != hr ||
      xx.minutes != mn) {
    print(
        '${xx.years} != $yr || ${xx.months} != $mo || ${xx.days} != $dy || ${xx.hours} != $hr || ${xx.minutes} != $mn');
  }
  xx = cc;
  yr = 4;
  mo = 2;
  dy = -3;
  mn = 5;
  if (xx.years != yr ||
      xx.months != mo ||
      xx.days != dy ||
      xx.hours != hr ||
      xx.minutes != mn) {
    print(
        '${xx.years} != $yr || ${xx.months} != $mo || ${xx.days} != $dy || ${xx.hours} != $hr || ${xx.minutes} != $mn');
  }
  xx = dd;
  yr = 3;
  mo = 6;
  dy = -9;
  hr = 15;
  mn = -15;
  if (xx.years != yr ||
      xx.months != mo ||
      xx.days != dy ||
      xx.hours != hr ||
      xx.minutes != mn) {
    print(
        '${xx.years} != $yr || ${xx.months} != $mo || ${xx.days} != $dy || ${xx.hours} != $hr || ${xx.minutes} != $mn');
  }
  xx = ee;
  yr = 0;
  mo = 1;
  dy = -1;
  hr = 2;
  mn = -2;
  if (xx.years != yr ||
      xx.months != mo ||
      xx.days != dy ||
      xx.hours != hr ||
      xx.minutes != mn) {
    print(
        '${xx.years} != $yr || ${xx.months} != $mo || ${xx.days} != $dy || ${xx.hours} != $hr || ${xx.minutes} != $mn');
  }
  xx = ff;
  yr = -1;
  mo = -2;
  dy = 3;
  hr = -5;
  mn = 5;
  if (xx.years != yr ||
      xx.months != mo ||
      xx.days != dy ||
      xx.hours != hr ||
      xx.minutes != mn) {
    print(
        '${xx.years} != $yr || ${xx.months} != $mo || ${xx.days} != $dy || ${xx.hours} != $hr || ${xx.minutes} != $mn');
  }
  xx = gg;
  yr = 1;
  mo = 2;
  dy = -3;
  hr = 5;
  mn = -5;
  if (xx.years != yr ||
      xx.months != mo ||
      xx.days != dy ||
      xx.hours != hr ||
      xx.minutes != mn) {
    print(
        '${xx.years} != $yr || ${xx.months} != $mo || ${xx.days} != $dy || ${xx.hours} != $hr || ${xx.minutes} != $mn');
  }
}

void main() {
  testDelay();
  testLapse();
  print('Fin del test');
}
