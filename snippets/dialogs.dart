import 'package:easy_localization/easy_localization.dart';
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

void alert(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 90,
      ),
      content: Text(
        message,
        style: context.textTheme.bodyMedium,
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("OK"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}

void sureAlert({
  required BuildContext context,
  required String message,
  required void Function() onYes,
}) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // contentPadding:
        //     const EdgeInsets.symmetric(vertical: 40, horizontal: 120),
        // actionsPadding:
        //     const EdgeInsets.symmetric(vertical: 40, horizontal: 120) -
        //         const EdgeInsets.only(top: 40),
        actionsAlignment: MainAxisAlignment.center,
        title: Icon(
          Icons.help_outline,
          color: Theme.of(context).primaryColor,
          size: 90,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Are you sure?",
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
            child: const Text("Yes"),
            onPressed: () {
              onYes();
              pop(context);
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: const Text("No"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );

class ConfirmationPopup extends StatelessWidget {
  const ConfirmationPopup({
    Key? key,
    required this.onConfirm,
    this.onCancel,
    this.dialogText,
  }) : super(key: key);

  final Function onConfirm;
  final Function? onCancel;
  final String? dialogText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(dialogText ?? 'areYouSureWantToCompleteThisAction'.tr()),
      actions: [
        //confirm and cancel button
        TextButton(
          onPressed: () => onCancel ?? pop(context),
          child: Text('cancel'.tr()),
        ),

        ElevatedButton(
          onPressed: () async {
            await onConfirm.call();
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(2.0),
            visualDensity: VisualDensity.compact,
          ),
          child: Text('confirm'.tr()),
        ),
      ],
    );
  }
}
