import 'package:flutter/material.dart';

import 'snippets/reusable_widgets.dart';

class CustomTabbedButton extends StatefulWidget {
  const CustomTabbedButton({
    super.key,
    required this.items,
    required this.onChanged,
    required this.initialIndex,
    this.unselectedColor,
    this.selectedIcon,
  });

  final List<CustomTabItem> items;
  final Function(int) onChanged;
  final int initialIndex;

  final IconData? selectedIcon;
  final Color? unselectedColor;

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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SpacedRow(
          spacing: 8,
          children: widget.items
              .map((e) => Expanded(
                    child: TweenAnimationBuilder<Color?>(
                      tween: ColorTween(
                        begin: Colors.white,
                        end: _selectedIndex == widget.items.indexOf(e)
                            ? theme.colorScheme.primary
                            : widget.unselectedColor ??
                                ((theme.brightness == Brightness.light)
                                    ? Colors.white
                                    : theme.cardColor),
                      ),
                      duration: _animationController.duration!,
                      builder: (context, color, child) {
                        return TextButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor: color,
                            foregroundColor:
                                _selectedIndex == widget.items.indexOf(e)
                                    ? Colors.white
                                    : theme.brightness == Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 8.0),
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
                          icon: _selectedIndex == widget.items.indexOf(e)
                              ? Icon(widget.selectedIcon ?? Icons.done)
                              : const SizedBox.shrink(),
                        );
                      },
                      child: Text(e.title),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class CustomTabItem {
  CustomTabItem({
    required this.title,
  });

  final String title;
}
