import 'package:flutter/material.dart';

ThemeData getThemeData(
  BuildContext context, {
  bool? useMaterial3,
  String? fontFamily,
  ColorScheme? colorScheme,
}) {
  return ThemeData(
    useMaterial3: useMaterial3,
    primaryColor: context.primaryColor,
    fontFamily: fontFamily,
    colorScheme: colorScheme,
    inputDecorationTheme: InputDecorationTheme(
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
    ),
  );
}

// * Scroll Behavior
class MyScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return BouncingScrollPhysics();
  }
}

extension ContextExtensions on BuildContext {
  // * Theme
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  InputDecorationTheme get inputDecorationTheme => theme.inputDecorationTheme;
  Color get primaryColor => theme.colorScheme.primary;
  Color get secondaryColor => theme.colorScheme.secondary;

  String get fontFamily => textTheme.bodyLarge!.fontFamily!;

  // * MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
  double get statusBarHeight => mediaQuery.padding.top;
  double get bottomBarHeight => mediaQuery.padding.bottom;

  //* Default Colors
  Color get appColorGreen => const Color(0xff317020);
  Color get appColorRed => const Color(0xffe74c3c);
  Color get appColorBlue => const Color(0xff204051);
  Color get appColorSubText => const Color(0xff4C5264);
  Color get appColorDisabledButton => const Color(0xffE4E4E4);
  Color get appColorGrey => const Color(0XFF6C6C6C);
  Color get appColorBackground => const Color(0xFFF2F5FA);
  Color get appColorWhite => const Color(0xFFFFFFFF);
  Color get appColorBlack => const Color(0XFF2e2e2e);

  // * Default Sizes
  double get elevation => 3.0;
  double get borderRadius => 20.0;
}
