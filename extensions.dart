extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
  String get allInCaps => toUpperCase();
  String get capitalizeFirstofEach =>
      split(" ").map((str) => str.inCaps).join(" ");
}

//* Turn each map value into a String
extension MapExtension<K, V> on Map<K, V> {
  Map<String, String> convertMapValuesToString<T>() {
    String convertNonPrimitiveValuesToString(dynamic value) {
      if (value is String || value is int || value is double) {
        return value.toString();
      } else if (value is Map) {
        // Handle nested maps
        Map<dynamic, String> newMap = {};
        value.forEach((key, nestedValue) {
          newMap[key] = convertNonPrimitiveValuesToString(nestedValue);
        });
        return newMap.toString();
      } else {
        return value.toString();
      }
    }

    Map<String, String> convertedMap = {};
    forEach((key, value) {
      convertedMap[key as String] = convertNonPrimitiveValuesToString(value);
    });

    return convertedMap;
  }
}
