import 'package:flutter/material.dart';

abstract class AppButtonStyle {
  static final linkButtonStyle = ButtonStyle(
    foregroundColor: const WidgetStatePropertyAll(Colors.lightBlue),
    textStyle: const WidgetStatePropertyAll(
      TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  static final linkAltButtonStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.black.withOpacity(0.4)),
    textStyle: const WidgetStatePropertyAll(
      TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    ),
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  static final inactiveButtonStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.grey.withOpacity(0.1)),
    textStyle: const WidgetStatePropertyAll(
      TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    ),
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  static final buttonStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.lightBlue.shade600),
    textStyle: const WidgetStatePropertyAll(
      TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    ),
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  static final logOutButtonStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.red.shade900),
    textStyle: const WidgetStatePropertyAll(
      TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    ),
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  static final trailerButtonStyle = ButtonStyle(
    foregroundColor: const WidgetStatePropertyAll(Colors.lightBlue),
    textStyle: const WidgetStatePropertyAll(
      TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  static final disabledTrailerButtonStyle = ButtonStyle(
    foregroundColor:
        const WidgetStatePropertyAll(Colors.grey), // Цвет текста для неактивного состояния
    backgroundColor:
        WidgetStatePropertyAll(Colors.grey[300]), // Цвет фона для неактивного состояния
    textStyle: const WidgetStatePropertyAll(
      TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
