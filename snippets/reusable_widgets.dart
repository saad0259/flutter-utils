import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jpay/utils/colors.dart';

//? What is this lint error?
class SpacedColumn extends Column {
  SpacedColumn({
    super.key,
    super.mainAxisAlignment,
    super.crossAxisAlignment,
    super.mainAxisSize,
    TextDirection? textDirection,
    super.verticalDirection,
    super.textBaseline,
    List<Widget> children = const <Widget>[],
    double spacing = 0,
  }) : super(
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
    super.key,
    super.mainAxisAlignment,
    super.crossAxisAlignment,
    super.mainAxisSize,
    TextDirection? textDirection,
    super.verticalDirection,
    super.textBaseline,
    List<Widget> children = const <Widget>[],
    double spacing = 0,
  }) : super(
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
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior,
    required Widget child,
  }) : super(
          child: SizedBox(
            width: double.infinity,
            child: Center(child: child),
          ),
        );
}

Widget get emptyListMessage =>
    const Text('No item found', textAlign: TextAlign.center);

Widget getLoader({Color? color}) =>
    Center(child: CircularProgressIndicator(color: color));

void getStickyLoader(context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => getLoader(),
  );
}

// ignore: must_be_immutable
class MyScaffold extends StatelessWidget {
  final Widget? body, drawer, bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final Color backgroundColor;
  final Key? scaffoldKey;
  bool? resizeToAvoidBottomInset = true, extendBody, extendBodyBehindAppBar;

  MyScaffold({
    Key? key,
    this.body,
    this.drawer,
    this.appBar,
    this.bottomNavigationBar,
    this.backgroundColor = AppColor.whiteColor,
    this.scaffoldKey,
    this.extendBody = true,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: backgroundColor,
      appBar: appBar,

      body: body,
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      extendBody: extendBody!,
      extendBodyBehindAppBar: extendBodyBehindAppBar!,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}

bool isNotEmpty(value) {
  if (value != null && value != '') {
    return true;
  }
  return false;
}

bool isEmpty(value) {
  if (value == null || value == '') {
    return true;
  }
  return false;
}

// const SizedBox(height:10),
// const SizedBox(width:10),
// isn't this simple enough?
// meku cool lagta maybe adat kh lo, hahahahahahah, sun le chatpt
//hta de yar, ok

//tf is this? sare app me print use krne ke bad submit time isko comment kr do phle print tha phir log kr dea bad me pata laga log release me chalta hi nai
logMsg(String msg) {
  //? better? ok
  // there is a chat button in this anydesk widow
  kDebugMode ? log(msg) : print(msg);
}

hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
