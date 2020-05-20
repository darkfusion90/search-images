import 'package:flutter/cupertino.dart';

void requestFocus(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

HSLColor lightenHSLColor(HSLColor hslColor, double amount) {
  double keepColorLightnessWithinLimits(double num) {
    return num.clamp(0, 1);
  }
  
  return hslColor.withLightness(
    keepColorLightnessWithinLimits(hslColor.lightness + amount));
}

Color darkenColor(Color color, double amount) {
  final HSLColor hslColor = HSLColor.fromColor(color);
  final HSLColor hslColorDarker = lightenHSLColor(hslColor, -amount);
  
  return hslColorDarker.toColor();
}

Color lightenColor(Color color, double amount) {
  final HSLColor hslColor = HSLColor.fromColor(color);
  final HSLColor hslColorLighter = lightenHSLColor(hslColor, amount);
  
  return hslColorLighter.toColor();
}