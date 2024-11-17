import 'package:flutter/material.dart';

abstract class AppBoxDecorationStyle {
  static final boxDecoration = BoxDecoration(
    color: Colors.blueGrey.shade800.withOpacity(0.5),
    border: Border.all(color: Colors.black.withOpacity(0.2)),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, 3),
      ),
    ],
  );

  static final dropDownBoxDecoration = BoxDecoration(
    color: Colors.blueGrey.shade800.withOpacity(0.3),
    border: Border.all(color: Colors.black.withOpacity(0.2)),
    borderRadius: const BorderRadius.all(Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, 3),
      ),
    ],
  );
}
