// import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${substring(1)}";
//   }

//   String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
//   String get allInCaps => toUpperCase();
//   String get capitalizeFirstofEach =>
//       split(" ").map((str) => str.inCaps).join(" ");
// }

// //* Turn each map value into a String
// extension MapExtension<K, V> on Map<K, V> {
//   Map<String, String> convertMapValuesToString<T>() {
//     String convertNonPrimitiveValuesToString(dynamic value) {
//       if (value is String || value is int || value is double) {
//         return value.toString();
//       } else if (value is Map) {
//         // Handle nested maps
//         Map<dynamic, String> newMap = {};
//         value.forEach((key, nestedValue) {
//           newMap[key] = convertNonPrimitiveValuesToString(nestedValue);
//         });
//         return newMap.toString();
//       } else {
//         return value.toString();
//       }
//     }

//     Map<String, String> convertedMap = {};
//     forEach((key, value) {
//       convertedMap[key as String] = convertNonPrimitiveValuesToString(value);
//     });

//     return convertedMap;
//   }
// }

// extension TimeOfDayExtension on TimeOfDay {
//   bool isBefore(TimeOfDay other) {
//     // Convert TimeOfDay to DateTime for easier comparison
//     DateTime dateTime1 = DateTime(2000, 1, 1, hour, minute);
//     DateTime dateTime2 = DateTime(2000, 1, 1, other.hour, other.minute);

//     // Compare the DateTimes
//     return dateTime1.isBefore(dateTime2);
//   }

//   String format() {
//     return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
//   }
// }

extension DateTimeExtension on DateTime {
  String formatDate({String? format, Locale locale = const Locale('en')}) {
    return DateFormat(format ?? 'yyyy-MM-dd hh:mm a', locale.toString())
        .format(this);
  }

  String format({String? format}) {
    return DateFormat(format ?? 'yyyy-MM-dd hh:mm a').format(this);
  }

  String formatDateHumanReadable() {
    String result = '';
    DateTime today = DateTime.now();
    DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));

    if (year == today.year && month == today.month && day == today.day) {
      result = 'Today';
    } else {
      if (year == yesterday.year &&
          month == yesterday.month &&
          day == yesterday.day) {
        result = 'Yesterday';
      } else {
        result = DateFormat.MMMEd().format(this);
      }
    }

    return result;
  }

  String formatTime() {
    return DateFormat('hh:mm a').format(this);
  }
}

DateTime getDateTimeFromMap(Map<String, dynamic> map, String key) {
  var value = map[key];
  if (value != null) {
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value) ?? DateTime.now();
    } else if (value is Timestamp) {
      return value.toDate();
    }
  }
  return DateTime.now();
}
