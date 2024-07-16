import 'package:flutter/material.dart';

import 'button_theme.dart';
import 'input_theme.dart';

ThemeData getThemeData(
  BuildContext context, {
  bool? useMaterial3,
  String? fontFamily,
  ColorScheme? colorScheme,
}) {
  return ThemeData(
    useMaterial3: useMaterial3,
    primaryColor: colorScheme?.primary,
    fontFamily: fontFamily,
    colorScheme: colorScheme,
    inputDecorationTheme: inputDecoration(fontFamily, context),
    elevatedButtonTheme: elevatedButtonTheme(context),
    textButtonTheme: textButtonTheme(context),
  );
}

// * Scroll Behavior
class MyScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}

extension ContextExtensions on BuildContext {
  double get rMinHeight => 720.0;
  double get rTabletWidth => 800.0;
  double get rLaptopWidth => 1024.0;
  double get rLargeLaptopWidth => 1440.0;

  bool get isSmallScreen => isPhone || isTablet;

  bool get isPhone => width < rTabletWidth;
  bool get isTablet => width < rLaptopWidth;
  bool get isLaptop => width >= rLaptopWidth && width < rLargeLaptopWidth;
  bool get isLargeLaptop => width >= rLargeLaptopWidth;

  double getResponsiveHorizontalPadding() {
    return isTablet
        ? 16
        : isLaptop
            ? (rLaptopWidth - rTabletWidth) / 2
            : (rLargeLaptopWidth - rLaptopWidth) / 2;
  }

  // * Theme
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;
  InputDecorationTheme get inputDecorationTheme => theme.inputDecorationTheme;
  ElevatedButtonThemeData get elevatedButtonTheme => theme.elevatedButtonTheme;

  ColorScheme get colorScheme => theme.colorScheme;
  Color get primaryColor => theme.colorScheme.primary;
  Color get secondaryColor => theme.colorScheme.secondary;

  String get fontFamily => textTheme.bodyLarge!.fontFamily!;

  // * MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
  double get statusBarHeight => mediaQuery.padding.top;
  double get bottomBarHeight => mediaQuery.padding.bottom;

  // * Default Sizes
  double get elevation => 3.0;
  double get borderRadius => 20.0;
}
