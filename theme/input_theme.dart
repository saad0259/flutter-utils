import 'package:flutter/material.dart';
import './theme.dart';

InputDecorationTheme inputDecoration(String? fontFamily, BuildContext context) {
  return InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.grey[400],
      fontFamily: fontFamily,
      fontSize: 15,
    ),
    labelStyle: TextStyle(
      fontFamily: fontFamily,
      fontSize: 15,
    ),
    fillColor: Colors.grey[100],
    filled: true,
    contentPadding: const EdgeInsets.all(16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(context.borderRadius),
      borderSide: const BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(context.borderRadius),
    ),
  );
}
