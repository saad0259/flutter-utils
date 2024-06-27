import 'dart:math';
// import 'dart:ui' as ui;

// import 'package:file_saver/file_saver.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:universal_html/html.dart' as html;
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import './theme/theme.dart';
// import 'snippets/dialogs.dart';

// Widget getErrorMessage(BuildContext context, e) {
//   debugPrint(e);

//   return Center(
//     child: Text(
//       e is FirebaseException ? e.message ?? e.code : e,
//       style:
//           Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.red),
//       textAlign: TextAlign.center,
//     ),
//   );
// }

Future<void> customLaunch(String receiptUrl) async {
  final Uri url = Uri.parse(receiptUrl);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    print(' could not launch $url');
  }
}

void alert(BuildContext context, String message,
    {bool info = false, IconData? icon, String? title}) {
  debugPrint(message);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 40, horizontal: 120),
      actionsPadding:
          const EdgeInsets.symmetric(vertical: 40, horizontal: 120) -
              const EdgeInsets.only(top: 40),
      actionsAlignment: MainAxisAlignment.center,
      title: info
          ? Icon(
              icon ?? Icons.check_circle_outline,
              color: Theme.of(context).primaryColor,
              size: 90,
            )
          : Icon(
              icon ?? Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
              size: 90,
            ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title ?? (info ? "success" : "error"),
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("ok"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}

String getRandomNumber() {
  var rng = Random();

  return (rng.nextInt(90000) + 10000).toString();
}

// Future<bool> isInternetAvailable() async {
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.mobile) {
//     return true;
//   } else if (connectivityResult == ConnectivityResult.wifi) {
//     return true;
//   }
//   return false;
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

class CustomRow extends StatelessWidget {
  const CustomRow({Key? key, required this.children, this.spacer = 0});
  final List<Widget> children;

  final double spacer;

  @override
  Widget build(BuildContext context) {
    return context.isPhone
        ? Column(
            children: children
                .expand((e) => [
                      e,
                      SizedBox(
                        height: spacer,
                      )
                    ])
                .toList()
              ..removeLast(),
          )
        : Row(
            children: children
                .expand((e) => [
                      Expanded(child: e),
                      SizedBox(
                        width: spacer,
                      )
                    ])
                .toList()
              ..removeLast(),
          );
  }
}

// Future<void> downloadWidgetIntoImage(GlobalKey key) async {
//   try {
//     RenderRepaintBoundary boundary =
//         key.currentContext!.findRenderObject() as RenderRepaintBoundary;
//     ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     Uint8List pngBytes = byteData!.buffer.asUint8List();
//     final blob = html.Blob([pngBytes]);
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     await FileSaver.instance.saveFile(
//         name: '${DateTime.now().toString()}.png',
//         bytes: pngBytes,
//         mimeType: MimeType.png,
//         ext: 'png');

//     html.Url.revokeObjectUrl(url);
//   } catch (e) {
//     print(e.toString());
//     rethrow;
//   }
// }

// void copyToClipboard(BuildContext context, String text) {
//   final textarea = html.TextAreaElement();
//   html.document.body?.append(textarea);
//   textarea.style.border = '0';
//   textarea.style.margin = '0';
//   textarea.style.padding = '0';
//   textarea.style.opacity = '0';
//   textarea.style.position = 'absolute';
//   textarea.readOnly = true;
//   textarea.value = text;
//   textarea.select();
//   html.document.execCommand('copy');
//   textarea.remove();
//   snack(context, 'Copied to clipboard', info: true);
// }

String parseDate(DateTime date) {
  return DateFormat.yMMMd().format(date);
}

// Future<String> uploadImage(
//     {required Reference storage,
//     required String name,
//     required Uint8List image}) async {
//   final resp = await storage.child('$name.png').putData(image);
//   return resp.ref.getDownloadURL();
// }
