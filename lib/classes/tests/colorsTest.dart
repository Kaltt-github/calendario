// ignore_for_file: file_names, avoid_print

import 'package:calendario/classes/colors.dart';
import 'package:calendario/classes/funs.dart';

void testHexInt() {
  var a1 = HEX.fromINT(value: 4360181),
      a2 = a1.toHEX(),
      a3 = a1.toRGB(),
      a4 = a1.toCMYK(),
      a5 = a1.toHSV(),
      a6 = a1.toHSL(),
      a7 = a1.toINT();
  if (a2.value != a1.value) {
    print('HEX to String ${a2.value} == ${a1.value}');
  }
  if (!equal(a3.red, 66, 1) ||
      !equal(a3.green, 135, 1) ||
      !equal(a3.blue, 245, 1)) {
    print(
        'HEX to RGB ${a3.red} == 66 || ${a3.green} == 135 || ${a3.blue} == 245');
  }
  if (!equal(a4.cian, 73, 1) ||
      !equal(a4.magenta, 45, 1) ||
      !equal(a4.yellow, 0, 1) ||
      !equal(a4.key, 4, 1)) {
    print(
        'HEX to CMYK ${a4.cian} == 73 || ${a4.magenta} == 45 || ${a4.yellow} == 0 || ${a4.key} == 4');
  }
  if (!equal(a5.hue, 217, 1) ||
      !equal(a5.saturation, 73, 1) ||
      !equal(a5.value, 96, 1)) {
    print(
        'HEX to HSV ${a5.hue} == 217 || ${a5.saturation} == 73 || ${a5.value} == 96');
  }
  if (!equal(a6.hue, 217, 1) ||
      !equal(a6.saturation, 90, 1) ||
      !equal(a6.light, 61, 1)) {
    print(
        'HEX to HSL ${a6.hue} == 217 || ${a6.saturation} == 90 || ${a6.light} == 61');
  }
  if (!equal(a7, 4360181, 1)) {
    print('HEX to INT $a7 == 4360181');
  }
}

void testHexString() {
  var a1 = HEX(value: '#8c00f7'),
      a2 = a1.toHEX(),
      a3 = a1.toRGB(),
      a4 = a1.toCMYK(),
      a5 = a1.toHSV(),
      a6 = a1.toHSL(),
      a7 = a1.toINT();
  if (a2.value != a1.value) {
    print('HEX to String ${a2.value} == ${a1.value}');
  }
  if (!equal(a3.red, 140, 1) ||
      !equal(a3.green, 0, 1) ||
      !equal(a3.blue, 247, 1)) {
    print(
        'HEX to RGB ${a3.red} == 140 || ${a3.green} == 0 || ${a3.blue} == 247');
  }
  if (!equal(a4.cian, 43, 1) ||
      !equal(a4.magenta, 100, 1) ||
      !equal(a4.yellow, 0, 1) ||
      !equal(a4.key, 3, 1)) {
    print(
        'HEX to CMYK ${a4.cian} == 43 || ${a4.magenta} == 100 || ${a4.yellow} == 0 || ${a4.key} == 3');
  }
  if (!equal(a5.hue, 274, 1) ||
      !equal(a5.saturation, 100, 1) ||
      !equal(a5.value, 97, 1)) {
    print(
        'HEX to HSV ${a5.hue} == 274 || ${a5.saturation} == 100 || ${a5.value} == 97');
  }
  if (!equal(a6.hue, 274, 1) ||
      !equal(a6.saturation, 100, 1) ||
      !equal(a6.light, 48, 1)) {
    print(
        'HEX to HSL ${a6.hue} == 274 || ${a6.saturation} == 100 || ${a6.light} == 48  ');
  }
  if (!equal(a7, 9175287, 1)) {
    print('HEX to INT $a7 == 9175287');
  }
}

void testRGB() {
  var a1 = RGB(red: 94, green: 6, blue: 90),
      a2 = a1.toHEX(),
      a3 = a1.toRGB(),
      a4 = a1.toCMYK(),
      a5 = a1.toHSV(),
      a6 = a1.toHSL(),
      a7 = a1.toINT();
  if (a2.value != '#5E065A') {
    print('RGB to String ${a2.value} == #5E065A');
  }
  if (!equal(a3.red, 94, 1) ||
      !equal(a3.green, 6, 1) ||
      !equal(a3.blue, 90, 1)) {
    print('RGB to RGB ${a3.red} == 94 || ${a3.green} == 6 || ${a3.blue} == 90');
  }
  if (!equal(a4.cian, 0, 1) ||
      !equal(a4.magenta, 94, 1) ||
      !equal(a4.yellow, 4, 1) ||
      !equal(a4.key, 63, 1)) {
    print(
        'RGB to CMYK ${a4.cian} == 0 || ${a4.magenta} == 94 || ${a4.yellow} == 4 || ${a4.key} == 63');
  }
  if (!equal(a5.hue, 303, 1) ||
      !equal(a5.saturation, 94, 1) ||
      !equal(a5.value, 37, 1)) {
    print(
        'RGB to HSV ${a5.hue} == 303 || ${a5.saturation} == 94 || ${a5.value} == 37');
  }
  if (!equal(a6.hue, 303, 1) ||
      !equal(a6.saturation, 88, 1) ||
      !equal(a6.light, 20, 1)) {
    print(
        'RGB to HSL ${a6.hue} == 303 || ${a6.saturation} == 88 || ${a6.light} == 20');
  }
  if (!equal(a7, 6162010, 1)) {
    print('RGB to INT $a7 == 6162010');
  }
}

void testCMYK() {
  var a1 = CMYK(cian: 0, magenta: 28, yellow: 21, key: 1),
      a2 = a1.toHEX(),
      a3 = a1.toRGB(),
      a4 = a1.toCMYK(),
      a5 = a1.toHSV(),
      a6 = a1.toHSL(),
      a7 = a1.toINT();
  if (a2.value != '#FCB6C6') {
    print('CMYK to String ${a2.value} == #FCB6C6');
  }
  if (!equal(a3.red, 252, 1) ||
      !equal(a3.green, 182, 1) ||
      !equal(a3.blue, 198, 1)) {
    print(
        'CMYK to RGB ${a3.red} == 252 || ${a3.green} == 182 || ${a3.blue} == 198');
  }
  if (!equal(a4.cian, 0, 1) ||
      !equal(a4.magenta, 28, 1) ||
      !equal(a4.yellow, 21, 1) ||
      !equal(a4.key, 1, 1)) {
    print(
        'CMYK to CMYK ${a4.cian} == 0 || ${a4.magenta} == 28 || ${a4.yellow} == 21 || ${a4.key} == 1');
  }
  if (!equal(a5.hue, 346, 2) ||
      !equal(a5.saturation, 28, 1) ||
      !equal(a5.value, 99, 1)) {
    print(
        'CMYK to HSV ${a5.hue} == 346 || ${a5.saturation} == 28 || ${a5.value} == 99');
  }
  if (!equal(a6.hue, 346, 2) ||
      !equal(a6.saturation, 93, 1) ||
      !equal(a6.light, 85, 1)) {
    print(
        'CMYK to HSL ${a6.hue} == 346 || ${a6.saturation} == 93 || ${a6.light} == 85');
  }
  if (!equal(a7, 16561862, 1)) {
    print('CMYK to INT $a7 == 16561862');
  }
}

void testHSV() {
  var a1 = HSV(hue: 21, saturation: 75, value: 98),
      a2 = a1.toHEX(),
      a3 = a1.toRGB(),
      a4 = a1.toCMYK(),
      a5 = a1.toHSV(),
      a6 = a1.toHSL(),
      a7 = a1.toINT();
  if (a2.value != '#FA803E') {
    print('HSV to String ${a2.value} == #FA803E');
  }
  if (!equal(a3.red, 250, 1) ||
      !equal(a3.green, 128, 1) ||
      !equal(a3.blue, 62, 1)) {
    print(
        'HSV to RGB ${a3.red} == 250 || ${a3.green} == 128 || ${a3.blue} == 62');
  }
  if (!equal(a4.cian, 0, 1) ||
      !equal(a4.magenta, 49, 1) ||
      !equal(a4.yellow, 75, 1) ||
      !equal(a4.key, 2, 1)) {
    print(
        'HSV to CMYK ${a4.cian} == 0 || ${a4.magenta} == 49 || ${a4.yellow} == 75 || ${a4.key} == 2');
  }
  if (!equal(a5.hue, 21, 1) ||
      !equal(a5.saturation, 75, 1) ||
      !equal(a5.value, 98, 1)) {
    print(
        'HSV to HSV ${a5.hue} == 21 || ${a5.saturation} == 75 || ${a5.value} == 98');
  }
  if (!equal(a6.hue, 21, 1) ||
      !equal(a6.saturation, 95, 1) ||
      !equal(a6.light, 61, 1)) {
    print(
        'HSV to HSL ${a6.hue} == 21 || ${a6.saturation} == 95 || ${a6.light} == 61');
  }
  if (!equal(a7, 16416830, 1)) {
    print('HSV to INT $a7 == 16416830');
  }
}

void testHSL() {
  var a1 = HSL(hue: 93, saturation: 14, light: 40),
      a2 = a1.toHEX(),
      a3 = a1.toRGB(),
      a4 = a1.toCMYK(),
      a5 = a1.toHSV(),
      a6 = a1.toHSL(),
      a7 = a1.toINT();
  if (a2.value != '#657558') {
    print('HSL to String ${a2.value} == #657558');
  }
  if (!equal(a3.red, 101, 1) ||
      !equal(a3.green, 117, 1) ||
      !equal(a3.blue, 88, 1)) {
    print(
        'HSL to RGB ${a3.red} == 101 || ${a3.green} == 117 || ${a3.blue} == 88');
  }
  if (!equal(a4.cian, 14, 1) ||
      !equal(a4.magenta, 0, 1) ||
      !equal(a4.yellow, 25, 1) ||
      !equal(a4.key, 54, 1)) {
    print(
        'HSL to CMYK ${a4.cian} == 14 || ${a4.magenta} == 0 || ${a4.yellow} == 25 || ${a4.key} == 54');
  }
  if (!equal(a5.hue, 93, 1) ||
      !equal(a5.saturation, 25, 1) ||
      !equal(a5.value, 46, 1)) {
    print(
        'HSL to HSV ${a5.hue} == 93 || ${a5.saturation} == 25 || ${a5.value} == 46');
  }
  if (!equal(a6.hue, 93, 1) ||
      !equal(a6.saturation, 14, 1) ||
      !equal(a6.light, 40, 1)) {
    print(
        'HSL to HSL ${a6.hue} == 93 || ${a6.saturation} == 14 || ${a6.light} == 40');
  }
  if (!equal(a7, 6649176, 1)) {
    print('HSL to INT $a7 == 6649176');
  }
}

void main() {
  testHexInt();
  testHexString();
  testRGB();
  testCMYK();
  testHSV();
  testHSL();
  print('Fin del test');
}
