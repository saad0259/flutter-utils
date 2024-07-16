// import 'package:shared_preferences/shared_preferences.dart';

// class PrefsHelper<T> {
//   final String key;

//   PrefsHelper(String key) : this.key = "Prefs$key" {
//     if (![int, double, String, bool].any((t) => t == T)) {
//       throw ArgumentError(
//           "Only native type allowed, given type ${T.toString()}");
//     }
//   }

//   Future<bool> save(T? value) async {
//     final prefs = await SharedPreferences.getInstance();
//     if (value == null) {
//       return prefs.remove(key);
//     }
//     switch (T) {
//       case int:
//         return prefs.setInt(key, value as int);
//       case double:
//         return prefs.setDouble(key, value as double);
//       case String:
//         return prefs.setString(key, value as String);
//       case bool:
//         return prefs.setBool(key, value as bool);
//       default:
//         throw ArgumentError("Non native type not possible here.");
//     }
//   }

//   Future<T> load() async {
//     final prefs = await SharedPreferences.getInstance();
//     switch (T) {
//       case int:
//         return prefs.getInt(key) as T;
//       case double:
//         return prefs.getDouble(key) as T;
//       case String:
//         return (prefs.getString(key) ?? '') as T;
//       case bool:
//         return prefs.getBool(key) as T;
//       default:
//         throw ArgumentError("Non native type not possible here.");
//     }
//   }

//   Future<bool> clear() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return await prefs.clear();
//   }
// }
