import '../../preferences/prefs_helper.dart';

Prefs get prefs {
  return Prefs._prefs;
}

class Prefs {
  static final _prefs = Prefs();
  final token = PrefsHelper<String>("token");
  final userId = PrefsHelper<String>("userId");
  final selectedLocale = PrefsHelper<String>("selectedLocale");
}
