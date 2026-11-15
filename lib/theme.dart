import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const forest = Color(0xFF25392C);
const canvas = Color(0xFFF7F5EE);
const paper = Color(0xFFFFFDF8);
const moss = Color(0xFF475B46);
const quiet = Color(0xFF596157);
const line = Color(0xFFDEDCD0);
const lime = Color(0xFFE8EC95);

final patikaTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: forest,
    onPrimary: Colors.white,
    secondary: lime,
    onSecondary: forest,
    surface: canvas,
    onSurface: forest,
    outline: line,
  ),
  scaffoldBackgroundColor: canvas,
  fontFamily: 'DM Sans',
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: canvas,
    foregroundColor: forest,
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    toolbarHeight: 66,
    titleSpacing: 20,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: forest,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  ),
);

const headline = TextStyle(
  fontFamily: 'Instrument Serif',
  fontSize: 45,
  height: 0.99,
  color: forest,
);
