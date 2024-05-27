import 'package:flutter/material.dart';

void push(BuildContext context, Widget child,
    {String? routeName, Object? arguments}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => child,
      settings: RouteSettings(name: routeName, arguments: arguments),
    ),
  );
}

void pushNamed(BuildContext context, String routeName, {Object? arguments}) {
  Navigator.of(context).pushNamed(routeName, arguments: arguments);
}

void popTillFirst(BuildContext context) {
  Navigator.of(context).popUntil((route) => route.isFirst);
}

void popAllAndPush(BuildContext context, Widget child) {
  popTillFirst(context);
  push(context, child);
}

void popAllAndPushNamed(BuildContext context, String route,
    {Object? arguments}) {
  popTillFirst(context);
  pushNamed(context, route, arguments: arguments);
}

// void popAllAndReplace(BuildContext context, Widget child) {
//   popTillFirst(context);
//   replace(context, child);
// }

void popAllAndReplaceNamed(BuildContext context, String route,
    {Object? arguments}) {
  popTillFirst(context);
  replaceNamed(context, route, arguments: arguments);
}

void pop(BuildContext context) => Navigator.of(context).pop();

void replace(BuildContext context, Widget child, {String? routeName}) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => child,
    settings: RouteSettings(name: routeName),
  ));
}

void replaceNamed(BuildContext context, String routeName, {Object? arguments}) {
  Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
}

void pushWithReplaceUntil(BuildContext context, Widget child) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => child),
      (Route<dynamic> route) => false);
}

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
