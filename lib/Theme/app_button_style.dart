import 'package:flutter/material.dart';

abstract class AppButtonStyle {
  static const color = Color(0xFF01B4E4);
  static const textStyle = TextStyle(fontSize: 16, color: Color(0xFF212529));
  static const textFieldDecoration = InputDecoration(
      border: OutlineInputBorder(),
      isCollapsed: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10));
  static final linkButton = ButtonStyle(
      textStyle: MaterialStateProperty.all(
          const TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
      foregroundColor: MaterialStateProperty.all((color)));
}
