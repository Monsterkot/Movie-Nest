import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blueAccent.shade400,
    primary: Colors.white,
    dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
  ),
  useMaterial3: true,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 24,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.blue.shade900,
    unselectedItemColor: Colors.white54,
    selectedItemColor: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
);
