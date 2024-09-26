import 'prefs_helper.dart';

Prefs get prefs {
  return Prefs._prefs;
}

class Prefs {
  static final _prefs = Prefs();
  final showNotification = PrefsHelper<bool>("showNotification");
  final isDark = PrefsHelper<bool>("showNotification");
}
