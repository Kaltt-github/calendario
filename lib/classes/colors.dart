import 'dart:math';
import 'funs.dart';

class _ColorFormat {
  external HEX toHEX();
  external RGB toRGB();
  external CMYK toCMYK();
  external HSV toHSV();
  external HSL toHSL();
  external int toINT();
}

class HEX implements _ColorFormat {
  String _value = '#000000';

  HEX({String value = '#000000'}) {
    this.value = value.toUpperCase();
  }
  HEX.fromINT({int value = 0x000000}) {
    var s = value.toRadixString(16);
    this.value = '#${'0' * (6 - s.length)}$s'.toUpperCase();
  }

  String get value => _value;
  set value(String value) {
    var hash = false;
    var valid = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      'A',
      'B',
      'C',
      'D',
      'E',
      'F'
    ];
    var code = value.toUpperCase().split('').map((i) {
      if (valid.contains(i)) {
        return i;
      }
      if (i == '#' && !hash) {
        hash = true;
        return '#';
      }
      return '0';
    }).join('');
    _value = (hash ? '' : '#') + code;
  }

  @override
  HEX toHEX() => this;
  @override
  RGB toRGB() => RGB(
      red: int.parse(value.substring(1, 3), radix: 16),
      green: int.parse(value.substring(3, 5), radix: 16),
      blue: int.parse(value.substring(5, 7), radix: 16));
  @override
  CMYK toCMYK() => toRGB().toCMYK();
  @override
  HSV toHSV() => toRGB().toHSV();
  @override
  HSL toHSL() => toRGB().toHSL();
  @override
  int toINT() => int.parse(value.substring(1, 7), radix: 16);
  @override
  String toString() => toHEX().value;
}

class RGB implements _ColorFormat {
  int _red = 0, _green = 0, _blue = 0;

  RGB({int red = 0, int green = 0, int blue = 0}) {
    _red = red;
    _green = green;
    _blue = blue;
  }

  int get red => _red;
  set red(int value) => _red = limitBetween(0, value, 255);
  int get green => _green;
  set green(int value) => _green = limitBetween(0, value, 255);
  int get blue => _blue;
  set blue(int value) => _blue = limitBetween(0, value, 255);

  @override
  HEX toHEX() => HEX(
          value: '#${[
        red.toRadixString(16),
        green.toRadixString(16),
        blue.toRadixString(16)
      ].map((x) => '0' * (2 - x.length) + x).join('').toUpperCase()}');
  @override
  RGB toRGB() => this;
  @override
  CMYK toCMYK() {
    var r = red / 255,
        g = green / 255,
        b = blue / 255,
        k = 1 - [r, g, b].reduce(max),
        c = (1 - r - k) / (1 - k),
        m = (1 - g - k) / (1 - k),
        y = (1 - b - k) / (1 - k);
    return CMYK(
        cian: (c * 100).toInt(),
        magenta: (m * 100).toInt(),
        yellow: (y * 100).toInt(),
        key: (k * 100).toInt());
  }

  @override
  HSV toHSV() {
    var r = red / 255,
        g = green / 255,
        b = blue / 255,
        cmax = [r, g, b].reduce(max),
        cmin = [r, g, b].reduce(min),
        d = cmax - cmin,
        h = (d == 0)
            ? 0
            : (r == cmax)
                ? 60 * ((g - b) / d)
                : (g == cmax)
                    ? 60 * ((b - r) / d + 2)
                    : 60 * ((r - g) / d + 4),
        s = (d == 0) ? 0 : d / cmax;
    if (h < 0) {
      h += 360;
    }
    return HSV(
        hue: h.toInt(),
        saturation: (s * 100).toInt(),
        value: (cmax * 100).toInt());
  }

  @override
  HSL toHSL() {
    var r = red / 255,
        g = green / 255,
        b = blue / 255,
        cmax = [r, g, b].reduce(max),
        cmin = [r, g, b].reduce(min),
        d = cmax - cmin,
        h = (d == 0)
            ? 0
            : (r == cmax)
                ? 60 * ((g - b) / d)
                : (g == cmax)
                    ? 60 * ((b - r) / d + 2)
                    : 60 * ((r - g) / d + 4),
        l = (cmax + cmin) / 2,
        s = (d == 0) ? 0 : d / (1 - module(2 * l - 1));
    if (h < 0) {
      h += 360;
    }
    return HSL(
        hue: h.toInt(),
        saturation: (s * 100).toInt(),
        light: (l * 100).toInt());
  }

  @override
  int toINT() => toHEX().toINT();
  @override
  String toString() => toHEX().value;
}

class CMYK implements _ColorFormat {
  int _cian = 0, _magenta = 0, _yellow = 0, _key = 0;

  CMYK({int cian = 0, int magenta = 0, int yellow = 0, int key = 0}) {
    _cian = cian;
    _magenta = magenta;
    _yellow = yellow;
    _key = key;
  }

  int get cian => _cian;
  set cian(int value) => _cian = limitBetween(0, value, 100);
  int get magenta => _magenta;
  set magenta(int value) => _magenta = limitBetween(0, value, 100);
  int get yellow => _yellow;
  set yellow(int value) => _yellow = limitBetween(0, value, 100);
  int get key => _key;
  set key(int value) => _key = limitBetween(0, value, 100);

  @override
  HEX toHEX() => toRGB().toHEX();
  @override
  RGB toRGB() {
    var r = 255 * (1 - (cian / 100)) * (1 - (key / 100)),
        g = 255 * (1 - (magenta / 100)) * (1 - (key / 100)),
        b = 255 * (1 - (yellow / 100)) * (1 - (key / 100));
    return RGB(red: r.toInt(), green: g.toInt(), blue: b.toInt());
  }

  @override
  CMYK toCMYK() => this;
  @override
  HSV toHSV() => toRGB().toHSV();
  @override
  HSL toHSL() => toRGB().toHSL();
  @override
  int toINT() => toHEX().toINT();
  @override
  String toString() => toHEX().value;
}

class HSV implements _ColorFormat {
  int _hue = 0, _saturation = 0, _value = 0;

  HSV({int hue = 0, int saturation = 0, int value = 0}) {
    _hue = hue;
    _saturation = saturation;
    _value = value;
  }

  int get hue => _hue;
  set hue(int value) => _hue = limitBetween(0, value, 360);
  int get saturation => _saturation;
  set saturation(int value) => _saturation = limitBetween(0, value, 100);
  int get value => _value;
  set value(int value) => _value = limitBetween(0, value, 100);

  @override
  HEX toHEX() => toRGB().toHEX();
  @override
  RGB toRGB() {
    var c = value / 100 * saturation / 100,
        x = c * (1 - module((hue / 60) % 2 - 1)),
        m = value / 100 - c,
        a = <double>[];
    if (0 <= hue && hue < 60) {
      a = [c, x, 0];
    } else if (60 <= hue && hue < 120) {
      a = [x, c, 0];
    } else if (120 <= hue && hue < 180) {
      a = [0, c, x];
    } else if (180 <= hue && hue < 240) {
      a = [0, x, c];
    } else if (240 <= hue && hue < 300) {
      a = [x, 0, c];
    } else {
      a = [c, 0, x];
    }
    var rgb = a.map((e) => ((e + m) * 255).toInt()).toList();
    return RGB(red: rgb[0], green: rgb[1], blue: rgb[2]);
  }

  @override
  CMYK toCMYK() => toRGB().toCMYK();
  @override
  HSV toHSV() => this;
  @override
  HSL toHSL() {
    var l = (value / 100) * (1 - (saturation / 100) / 2),
        s = (l == 0 || l == 1) ? 0 : (value / 100 - l) / min(l, 1 - l);
    return HSL(
        hue: hue, saturation: (s * 100).toInt(), light: (l * 100).toInt());
  }

  @override
  int toINT() => toHEX().toINT();
  @override
  String toString() => toHEX().value;
}

class HSL implements _ColorFormat {
  int _hue = 0, _saturation = 0, _light = 0;

  HSL({int hue = 0, int saturation = 0, int light = 0}) {
    _hue = hue;
    _saturation = saturation;
    _light = light;
  }

  int get hue => _hue;
  set hue(int value) => _hue = limitBetween(0, value, 360);
  int get saturation => _saturation;
  set saturation(int value) => _saturation = limitBetween(0, value, 100);
  int get light => _light;
  set light(int value) => _light = limitBetween(0, value, 100);

  @override
  HEX toHEX() => toRGB().toHEX();
  @override
  RGB toRGB() {
    var c = (1 - module(2 * (light / 100) - 1)) * saturation / 100,
        x = c * (1 - module((hue / 60) % 2 - 1)),
        m = light / 100 - c / 2,
        a = <double>[];
    if (0 <= hue && hue < 60) {
      a = [c, x, 0];
    } else if (60 <= hue && hue < 120) {
      a = [x, c, 0];
    } else if (120 <= hue && hue < 180) {
      a = [0, c, x];
    } else if (180 <= hue && hue < 240) {
      a = [0, x, c];
    } else if (240 <= hue && hue < 300) {
      a = [x, 0, c];
    } else {
      a = [c, 0, x];
    }
    var rgb = a.map((e) => ((e + m) * 255).toInt()).toList();
    return RGB(red: rgb[0], green: rgb[1], blue: rgb[2]);
  }

  @override
  CMYK toCMYK() => toRGB().toCMYK();
  @override
  HSV toHSV() {
    var l = light / 100,
        v = l + (saturation / 100) * min(l, 1 - l),
        s = (v == 0) ? 0 : 2 * (1 - l / v);
    return HSV(
        hue: hue, saturation: (s * 100).toInt(), value: (v * 100).toInt());
  }

  @override
  HSL toHSL() => this;
  @override
  int toINT() => toHEX().toINT();
  @override
  String toString() => toHEX().value;
}

class Color {
  _ColorFormat _format = _ColorFormat();
  bool _isV = false;

  Color() {
    _format = RGB();
  }

  Color.fromHex(String s) {
    _format = HEX(value: s);
  }
  Color.fromString(String s) {
    _format = HEX(value: s);
  }
  Color.fromInt(int x) {
    _format = HEX.fromINT(value: x);
  }
  Color.fromRGB(int r, int g, int b) {
    _format = RGB(red: r, green: g, blue: b);
  }
  Color.fromCMYK(int c, int m, int y, int k) {
    _format = CMYK(cian: c, magenta: m, yellow: y, key: k);
  }
  Color.fromHSV(int h, int s, int v) {
    _format = HSV(hue: h, saturation: s, value: v);
    _isV = true;
  }
  Color.fromHSL(int h, int s, int l) {
    _format = HSL(hue: h, saturation: s, light: l);
    _isV = false;
  }

  @override
  String toString() => _format.toString();

  HEX get hex => _format.toHEX();
  set hex(HEX x) {
    _format = x;
  }

  int get integer => _format.toINT();
  set integer(int x) {
    _format = HEX.fromINT(value: x);
  }

  int get red => _format.toRGB().red;
  set red(int x) {
    var n = _format.toRGB();
    n.red = x;
    _format = n;
  }

  int get green => _format.toRGB().green;
  set green(int x) {
    var n = _format.toRGB();
    n.green = x;
    _format = n;
  }

  int get blue => _format.toRGB().blue;
  set blue(int x) {
    var n = _format.toRGB();
    n.blue = x;
    _format = n;
  }

  RGB get rgb => _format.toRGB();
  set rgb(RGB x) {
    _format = x;
  }

  int get cian => _format.toCMYK().cian;
  set cian(int x) {
    var n = _format.toCMYK();
    n.cian = x;
    _format = n;
  }

  int get magenta => _format.toCMYK().magenta;
  set magenta(int x) {
    var n = _format.toCMYK();
    n.magenta = x;
    _format = n;
  }

  int get yellow => _format.toCMYK().yellow;
  set yellow(int x) {
    var n = _format.toCMYK();
    n.yellow = x;
    _format = n;
  }

  int get key => _format.toCMYK().key;
  set key(int x) {
    var n = _format.toCMYK();
    n.key = x;
    _format = n;
  }

  int get black => _format.toCMYK().key;
  set black(int x) => key = x;

  CMYK get cmyk => _format.toCMYK();
  set cmyk(CMYK x) {
    _format = x;
  }

  int get hue => (_isV) ? _format.toHSV().hue : _format.toHSL().hue;
  set hue(int x) {
    dynamic n = (_isV) ? _format.toHSV() : _format.toHSL();
    n.hue = x;
    _format = n;
  }

  int get saturation =>
      (_isV) ? _format.toHSV().saturation : _format.toHSL().saturation;
  set saturation(int x) {
    dynamic n = (_isV) ? _format.toHSV() : _format.toHSL();
    n.saturation = x;
    _format = n;
  }

  int get value {
    _isV = true;
    return _format.toHSV().value;
  }

  set value(int x) {
    var n = _format.toHSV();
    n.value = x;
    _isV = true;
    _format = n;
  }

  int get light {
    _isV = false;
    return _format.toHSL().light;
  }

  set light(int x) {
    var n = _format.toHSL();
    n.light = x;
    _isV = false;
    _format = n;
  }

  HSV get hsv {
    _isV = true;
    return _format.toHSV();
  }

  set hsv(HSV x) {
    _format = x;
    _isV = true;
  }

  HSL get hsl {
    _isV = false;
    return _format.toHSL();
  }

  set hsl(HSL x) {
    _format = x;
    _isV = false;
  }

  String get string => toString();
  set string(String x) {
    _format = HEX(value: x);
  }
}
