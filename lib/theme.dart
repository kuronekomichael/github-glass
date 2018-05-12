import 'package:flutter/material.dart';

const _primaryColor = 0xFF4CAF50; // green
const _grassColor = const MaterialColor(
  _primaryColor,
  const <int, Color>{
    50: const Color(0xFFE8F5E9),
    100: const Color(0xFFC8E6C9),
    200: const Color(0xFFA5D6A7),
    300: const Color(0xFF81C784),
    400: const Color(0xFF66BB6A),
    500: const Color(_primaryColor),
    600: const Color(0xFF43A047),
    700: const Color(0xFF388E3C),
    800: const Color(0xFF2E7D32),
    900: const Color(0xFF1B5E20),
  },
);

final ThemeData grassTheme = new ThemeData(
  primarySwatch: _grassColor,
);
