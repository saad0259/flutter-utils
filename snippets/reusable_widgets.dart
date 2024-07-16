import 'package:flutter/material.dart';

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
