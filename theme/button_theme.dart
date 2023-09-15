import './theme.dart';
import 'package:flutter/material.dart';

ElevatedButtonThemeData? elevatedButtonTheme(BuildContext context) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: context.colorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.borderRadius),
      ),
      padding: const EdgeInsets.all(16),
    ),
  );
}

TextButtonThemeData? textButtonTheme(BuildContext context) {
  return TextButtonThemeData(
    style: TextButton.styleFrom(),
  );
}
