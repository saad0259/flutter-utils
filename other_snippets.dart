// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:url_launcher/url_launcher.dart';

// Future<bool> isInternetAvailable() async {
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.mobile) {
//     return true;
//   } else if (connectivityResult == ConnectivityResult.wifi) {
//     return true;
//   }
//   return false;
// }

// Future<void> customLaunch(String receiptUrl) async {
//   final Uri url = Uri.parse(receiptUrl);
//   if (await canLaunchUrl(url)) {
//     await launchUrl(url);
//   } else {
//     print(' could not launch $url');
//   }
// }

// Future<bool> appVersionDiscontinued(String minimumVersion) async {
//   try {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     String currentVersion = packageInfo.version;

//     currentVersion = currentVersion.replaceAll(RegExp(r'-dev|-prod'), '');

//     if (_isVersionLower(currentVersion, minimumVersion)) {
//       return true;
//     } else {
//       return false;
//     }
//   } on PlatformException catch (e) {
//     // Handle exception related to platform services
//     print('Error getting package info: $e');
//     return false; // Or throw an exception to notify callers
//   } catch (e) {
//     // Handle any other unexpected exception
//     print('Unexpected error: $e');
//     return false; // Or throw an exception to notify callers
//   }
// }

// bool _isVersionLower(String currentVersion, String minimumVersion) {
//   List<int> currentVersionParts =
//       currentVersion.split('.').map(int.parse).toList();
//   List<int> minimumVersionParts =
//       minimumVersion.split('.').map(int.parse).toList();

//   // Compare major, minor, and patch version parts
//   for (int i = 0; i < 3; i++) {
//     if (currentVersionParts[i] < minimumVersionParts[i]) {
//       return true;
//     } else if (currentVersionParts[i] > minimumVersionParts[i]) {
//       return false;
//     }
//   }

//   // If the loop completes without returning, the versions are equal
//   return false;
// }
