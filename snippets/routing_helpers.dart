import 'package:flutter/material.dart';

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
