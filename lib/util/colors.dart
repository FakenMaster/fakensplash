import 'dart:ui';

final BACKGROUND_COLORS = [
  ...AMERICAN_COLORS,
  ...AUSSIE_COLORS,
  ...BRITISH_COLORS,
  ...CHINESE_COLORS
];

const AMERICAN_COLORS = [
  Color(0xffdfe6e9),
  Color(0xffa29bfe),
  Color(0xff74b9ff),
  Color(0xff81ecec),
  Color(0xff55efc4),
  Color(0xffffeaa7),
  Color(0xfffab1a0),
  Color(0xffff7675),
  Color(0xfffd79a8),
  Color(0xff636e72),
  Color(0xff2d3436),
  Color(0xfffdcb6e),
  Color(0xffe17055),
  Color(0xffe84393),
  Color(0xffd63031),
  Color(0xff00b894),
  Color(0xff0984e3),
  Color(0xffb2bec3),
  Color(0xff00cec9),
  Color(0xff6c5ce7),
];

const AUSSIE_COLORS = [
  Color(0xff535c68),
  Color(0xff130f40),
  Color(0xff4834d4),
  Color(0xffbe2edd),
  Color(0xff22a6b3),
  Color(0xfff6e58d),
  Color(0xffffbe76),
  Color(0xffff7979),
  Color(0xffbadc58),
  Color(0xffdff9fb),
  Color(0xff7ed6df),
  Color(0xffe056fd),
  Color(0xff686de0),
  Color(0xff30336b),
  Color(0xff95afc0),
  Color(0xfff9ca24),
  Color(0xfff0932b),
  Color(0xffeb4d4b),
  Color(0xff6ab04c),
  Color(0xffc7ecee),
];

const BRITISH_COLORS = [
  Color(0xff00a8ff),
  Color(0xff9c88ff),
  Color(0xfffbc531),
  Color(0xff4cd137),
  Color(0xff487eb0),
  Color(0xff0097e6),
  Color(0xff8c7ae6),
  Color(0xffe1b12c),
  Color(0xff44bd32),
  Color(0xff40739e),
  Color(0xffe84118),
  Color(0xfff5f6fa),
  Color(0xff7f8fa6),
  Color(0xff273c75),
  Color(0xff353b48),
  Color(0xffc23616),
  Color(0xffdcdde1),
  Color(0xff718093),
  Color(0xff192a56),
  Color(0xff2f3640),
];

const CHINESE_COLORS = [
  Color(0xffeccc68),
  Color(0xffff7f50),
  Color(0xffff6b81),
  Color(0xffa4b0be),
  Color(0xff57606f),
  Color(0xffffa502),
  Color(0xffff6348),
  Color(0xffff4757),
  Color(0xff747d8c),
  Color(0xff2f3542),
  Color(0xff7bed9f),
  Color(0xff70a1ff),
  Color(0xff5352ed),
  Color(0xffffffff),
  Color(0xffdfe4ea),
  Color(0xff2ed573),
  Color(0xff1e90ff),
  Color(0xff3742fa),
  Color(0xfff1f2f6),
  Color(0xffced6e0),
];

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
