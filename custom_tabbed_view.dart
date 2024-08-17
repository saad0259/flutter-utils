// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:vida/flutter-utils/theme/theme.dart';

import 'snippets/reusable_widgets.dart';

class CustomTabbedButton extends StatefulWidget {
  const CustomTabbedButton({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.initialIndex,
    this.showIcon = true,
    this.selectedIcon,
    this.unselectedColor,
    this.backgroundColor,
  }) : super(key: key);

  final List<CustomTabItem> items;
  final Function(int) onChanged;
  final int initialIndex;

  final bool showIcon;
  final IconData? selectedIcon;
  final Color? unselectedColor;
  final Color? backgroundColor;

  @override
  State<CustomTabbedButton> createState() => _CustomTabbedButtonState();
}

class _CustomTabbedButtonState extends State<CustomTabbedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    setState(() {
      _selectedIndex = widget.initialIndex;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(context.borderRadius),
      ),
      child: SpacedRow(
        spacing: 8,
        children: widget.items
            .map((e) => Expanded(
                  child: TweenAnimationBuilder<Color?>(
                    tween: ColorTween(
                      end: _selectedIndex == widget.items.indexOf(e)
                          ? theme.colorScheme.primary
                          : widget.unselectedColor ??
                              ((theme.brightness == Brightness.light)
                                  ? null
                                  : theme.cardColor),
                    ),
                    duration: _animationController.duration!,
                    builder: (context, color, child) {
                      return Container(
                        height: 35,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(context.borderRadius),
                        ),
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                context.borderRadius,
                              ),
                            ),
                            backgroundColor: color,
                            foregroundColor:
                                _selectedIndex == widget.items.indexOf(e)
                                    ? null
                                    : theme.brightness == Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _selectedIndex = widget.items.indexOf(e);
                            });
                            _animationController.reset();
                            _animationController.forward();
                            widget.onChanged(widget.items.indexOf(e));
                          },
                          label: child!,
                          icon: (widget.showIcon &&
                                  _selectedIndex == widget.items.indexOf(e))
                              ? Icon(widget.selectedIcon ?? Icons.done)
                              : const SizedBox.shrink(),
                        ),
                      );
                    },
                    child: Text(e.title,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class CustomTabItem {
  CustomTabItem({
    required this.title,
  });

  final String title;
}
