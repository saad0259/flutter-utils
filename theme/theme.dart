import 'package:flutter/material.dart';

import '../nb_utils/color.dart';

ThemeData getThemeData(BuildContext context) {
  return ThemeData(
    // useMaterial3: true,
    primaryColor: appColorPrimary,
    fontFamily: "Poppins",
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(0xFFd61f5d, <int, Color>{
      50: Color(0xFFfbe9ef),
      100: Color(0xFFf7d2df),
      200: Color(0xFFf3bcce),
      300: Color(0xFFefa5be),
      400: Color(0xFFeb8fae),
      500: Color(0xFFe6799e),
      600: Color(0xFFe2628e),
      700: Color(0xFFde4c7d),
      800: Color(0xFFda356d),
      900: Color(0xFFd61f5d),
    })).copyWith(secondary: appColorSecondary),

    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: Colors.grey[400],
        fontFamily: 'Poppins',
        fontSize: 15,
      ),
      labelStyle: TextStyle(
        color: colorMatteBlack,
        fontFamily: 'Poppins',
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

class MyScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return BouncingScrollPhysics();
  }
}

extension ContextExtensions on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  InputDecorationTheme get inputDecorationTheme =>
      Theme.of(this).inputDecorationTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  ThemeData get theme => Theme.of(this);

  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  double get statusBarHeight => MediaQuery.of(this).padding.top;

  double get bottomBarHeight => MediaQuery.of(this).padding.bottom;

  //* Colors
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  Color get primaryColorDark => Theme.of(this).primaryColorDark;

  Color get whiteColor => const Color(0xFFFFFFFF);
  Color get blackColor => const Color(0XFF2e2e2e);
  Color get greyColor => const Color(0XFF6C6C6C);
  Color get background => const Color(0xFFF2F5FA);

  double get elevation => 3.0;
  double get borderRadius => 20.0;

  TextStyle get toolbarText => const TextStyle(
        color: Colors.white,
        fontFamily: 'Poppins',
        fontSize: 16,
      );
}
