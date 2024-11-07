import 'package:flutter/material.dart';

class AppTextFieldStyle {
  static const textFieldDecorator = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    isCollapsed: true,
  );

}
