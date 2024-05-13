import 'package:cached_network_image/cached_network_image.dart';
// import 'package:community_material_icon/community_material_icon.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:easypay_customer/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../view/app_constants/app_images.dart';
import './theme/theme.dart';

// import 'app_images.dart';
// import 'color.dart';

//* This Function is specific to this project
double getPriceFromTotal(double total, double tax) {
  return total / (1 + tax / 100);
}

//* This Function is specific to this project
double getTaxFromTotal(double total, double tax) {
  return total - (total / (1 + tax / 100));
}

String? Function(String?) get passwordValidator => (String? password) =>
    (password?.length ?? 0) < 8 ? "Password too short" : null;

String? Function(String?) get mandatoryValidator =>
    (String? val) => val?.isEmpty ?? true ? 'mandatoryFieldError'.tr() : null;

String? Function(String?) get emailValidator => (String? email) => RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email ?? "")
        ? null
        : 'enterValidEmail'.tr();

String? Function(String?) get pinValidator => (String? email) => RegExp(
      r"^\d{4,}$",
    ).hasMatch(email ?? "")
        ? null
        : 'pinLengthError'.tr();

String getShortId(String val) {
  return val.substring(val.length - 6);
}

String parseDate(DateTime date) {
  return DateFormat.yMMMd('en-US').format(date);
}

String parseTime(DateTime time) {
  return DateFormat.jm('en-US').format(time);
}

String parseDateTime(DateTime date) {
  return "${parseDate(date)} ${parseTime(date)}";
}

void push(BuildContext context, Widget child, String routeName) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => child,
      settings: RouteSettings(name: routeName),
    ),
  );
}

void popTillFirst(BuildContext context) {
  Navigator.of(context).popUntil((route) => route.isFirst);
}

void pop(BuildContext context) => Navigator.of(context).pop();

void replace(BuildContext context, Widget child, String routeName) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => child,
    settings: RouteSettings(name: routeName),
  ));
}

void pushWithReplaceUntil(BuildContext context, Widget child) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => child),
      (Route<dynamic> route) => false);
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

Future<bool> dialogConfirmation(
  BuildContext context, {
  String? title,
  String? bodyText,
  String? affirmButtonText,
  String? cancelButtonText,
}) async {
  title ??= 'areYouSure'.tr();
  bodyText ??= 'areYouSureYouWantToProceed'.tr();
  affirmButtonText ??= 'yes'.tr();
  cancelButtonText ??= 'cancel'.tr();

  bool response = false;
  await showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('$title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                '$bodyText',
                softWrap: true,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('$cancelButtonText'),
            onPressed: () {
              response = false;
              pop(context);
            },
          ),
          TextButton(
            child: Text('$affirmButtonText'),
            onPressed: () {
              response = true;
              pop(context);
            },
          ),
        ],
      );
    },
  );
  return response;
}

void dialogLoader(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => getLoaderDialogue(context),
  );
}

Widget getLoaderDialogue(BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))),
    contentPadding: const EdgeInsets.only(top: 10.0),
    content: Container(
      width: 40,
      height: 140,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.borderRadius)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(
                    backgroundColor: context.appColorDisabledButton,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(context.secondaryColor),
                  ),
                ),
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      AppImages.loaderImage,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Loading...',
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    ),
  );
}

// void dialogInternet(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10.0))),
//       contentPadding: const EdgeInsets.only(top: 10.0),
//       content: Container(
//         height: 160,
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(20)),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Icon(
//               CommunityMaterialIcons.wifi_strength_off,
//               color: Colors.grey[700],
//               size: 40,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Text(
//               'Check your internet connection.',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: context.appColorBlack,
//                 fontSize: 18,
//               ),
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }

void snack(BuildContext context, String message, {bool info = false}) {
  debugPrint(message);

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      backgroundColor: info ? context.primaryColor : Colors.red,
      // behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: context.textTheme.bodyLarge?.copyWith(
          color: Colors.white,
        ),
      ),
    ));
}

Future<void> customLaunch(String receiptUrl) async {
  final Uri url = Uri.parse(receiptUrl);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    print(' could not launch $url');
  }
}

//TODO: Make separate folder for loaders and shimmers
Widget getLoader() => const Center(child: CircularProgressIndicator());

void getStickyLoader(context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => getLoader(),
  );
}
// dynamic decodeJWT(String token) {
//   final parts = token.split('.');
//   final payload = parts[1];
//   return json.decode(B64urlEncRfc7515.decodeUtf8(payload));
// }

Widget get emptyListMessage =>
    Text('noItemFound'.tr(), textAlign: TextAlign.center);

dynamic modalRouteHandler(BuildContext context) {
  final modalRoute = ModalRoute.of(context);
  dynamic routeData;
  if (modalRoute == null) {
    pop(context);
  } else {
    final routeArguments = modalRoute.settings.arguments;
    if (routeArguments != null) {
      routeData = routeArguments;
    }
  }
  return routeData;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.inCaps).join(" ");
}

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage(
    this.source, {
    Key? key,
    this.fit,
    this.errorWidget,
    this.width,
    this.height,
    this.alignment,
  }) : super(key: key);
  final String source;
  final BoxFit? fit;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: source,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
      alignment: alignment ?? Alignment.center,
      errorWidget: (context, url, error) =>
          errorWidget ?? const Icon(Icons.error),
    );
  }
}

final Color baseColor = Colors.grey[300]!;
final Color highlightColor = Colors.grey[100]!;

Widget getShimmer({
  double height = 12,
  double width = 40,
  double itemElevation = 0,
  double itemBorderRadius = 5,
}) {
  return Shimmer.fromColors(
    baseColor: baseColor,
    highlightColor: highlightColor,
    child: Card(
      elevation: itemElevation,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(itemBorderRadius),
      ),
      child: Container(
        height: height,
        width: width,
      ),
    ),
  );
}

Widget shimmerHorizontalList({
  double itemSpacing = 30,
  double itemHeight = 150,
  double itemWidth = 250,
  int itemCount = 10,
  double itemBorderRadius = 5,
}) {
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    clipBehavior: Clip.hardEdge,
    itemCount: itemCount,
    separatorBuilder: (BuildContext context, int index) {
      return SizedBox(
        width: itemSpacing,
      );
    },
    itemBuilder: (context, index) {
      return getShimmer(
        height: itemHeight,
        width: itemWidth,
        itemBorderRadius: itemBorderRadius,
      );
    },
  );
}

Shimmer shimmerTableEffect({
  EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  double itemHeight = 40,
  int itemCount = 20,
  double itemBorderRadius = 20,
}) {
  return Shimmer.fromColors(
    baseColor: baseColor,
    highlightColor: highlightColor,
    child: Padding(
      padding: padding,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            endIndent: 0,
            color: Colors.black,
            height: 0,
            indent: 0,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(itemBorderRadius)),
            ),
            child: SizedBox(
              height: itemHeight,
            ),
          );
        },
      ),
    ),
  );
}

Shimmer shimmerGridEffect({
  EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  double itemAspectRatio = 1,
  int itemCount = 20,
  double itemBorderRadius = 5,
  int crossAxisCount = 2,
  bool shrinkWrap = true,
}) {
  return Shimmer.fromColors(
    baseColor: baseColor,
    highlightColor: highlightColor,
    child: Padding(
      padding: padding,
      child: GridView.builder(
        shrinkWrap: shrinkWrap,
        itemCount: itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: itemAspectRatio,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(itemBorderRadius),
            ),
            child: SizedBox(),
          );
        },
      ),
    ),
  );
}

Future<bool> appVersionDiscontinued(String minimumVersion) async {
  try {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;

    currentVersion = currentVersion.replaceAll(RegExp(r'-dev|-prod'), '');

    if (_isVersionLower(currentVersion, minimumVersion)) {
      return true;
    } else {
      return false;
    }
  } on PlatformException catch (e) {
    // Handle exception related to platform services
    print('Error getting package info: $e');
    return false; // Or throw an exception to notify callers
  } catch (e) {
    // Handle any other unexpected exception
    print('Unexpected error: $e');
    return false; // Or throw an exception to notify callers
  }
}

bool _isVersionLower(String currentVersion, String minimumVersion) {
  List<int> currentVersionParts =
      currentVersion.split('.').map(int.parse).toList();
  List<int> minimumVersionParts =
      minimumVersion.split('.').map(int.parse).toList();

  // Compare major, minor, and patch version parts
  for (int i = 0; i < 3; i++) {
    if (currentVersionParts[i] < minimumVersionParts[i]) {
      return true;
    } else if (currentVersionParts[i] > minimumVersionParts[i]) {
      return false;
    }
  }

  // If the loop completes without returning, the versions are equal
  return false;
}

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
    this.forEach((key, value) {
      convertedMap[key as String] = convertNonPrimitiveValuesToString(value);
    });

    return convertedMap;
  }
}

class SpacedColumn extends Column {
  SpacedColumn({
    Key? key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    List<Widget> children = const <Widget>[],
    double spacing = 0,
  }) : super(
          key: key,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
          children: children
              .map((e) => Padding(
                    padding: EdgeInsets.only(bottom: spacing),
                    child: e,
                  ))
              .toList(),
        );
}

class SpacedRow extends Row {
  SpacedRow({
    Key? key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    List<Widget> children = const <Widget>[],
    double spacing = 0,
  }) : super(
          key: key,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
          children: children
              .expand((e) => [
                    e,
                    SizedBox(
                      width: spacing,
                    )
                  ])
              .toList()
            ..removeLast(),
        );
}

class ExpandedElevatedButton extends ElevatedButton {
  ExpandedElevatedButton({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    required Widget child,
  }) : super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          child: SizedBox(
            width: double.infinity,
            child: Center(child: child),
          ),
        );
}
