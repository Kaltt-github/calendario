import 'package:uuid/uuid.dart';

int limitBetween(int min, int x, int max) => (x < min)
    ? min
    : (x > max)
        ? max
        : x;

bool isBetween(int min, int x, int max, {bool excludeLimts = false}) =>
    excludeLimts ? min < x && x < max : min <= x && x <= max;

double module(double x) => (x > 0) ? x : x * -1;

bool equal(int x, int y, int delta) => isBetween(x - delta, y, x + delta);

String buildId() => const Uuid().v4();
