import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'routing_helpers.dart';

void snack(BuildContext context, String message, {bool info = false}) {
  debugPrint(message);

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      backgroundColor: info ? context.primaryColor : context.colorScheme.error,
      // behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: context.textTheme.bodyLarge?.copyWith(
          color: Colors.white,
        ),
      ),
    ));

  // ignore: unused_element
  Future<bool> dialogConfirmation(
    BuildContext context, {
    String? title,
    String? bodyText,
    String? affirmButtonText,
    String? cancelButtonText,
  }) async {
    title ??= 'Are you sure?';
    bodyText ??= 'Are you sure you want to proceed?';
    affirmButtonText ??= 'Yes';
    cancelButtonText ??= 'Cancel';

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
}
