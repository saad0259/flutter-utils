// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../state/general_state.dart';

// class CustomSliderWidget extends StatefulWidget {
//   CustomSliderWidget(
//       {Key? key,
//       required this.value,
//       this.onChanged,
//       required this.onDecrement,
//       required this.onIncrement,
//       required this.title})
//       : super(key: key);

//   final double? value;
//   final String title;
//   final void Function(double)? onChanged;
//   final void Function() onDecrement;
//   final void Function() onIncrement;

//   @override
//   State<CustomSliderWidget> createState() => _CustomSliderWidgetState();
// }

// class _CustomSliderWidgetState extends State<CustomSliderWidget> {
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(widget.title),
//         const SizedBox(height: 10),
//         AnimatedSliderValue(widget.value ?? 0),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SliderAction(function: widget.onDecrement, icon: Icons.remove),
//             Slider(
//               value: widget.value ?? 0,
//               max: 100.0,
//               min: 0.0,
//               divisions: 1000,
//               label: (widget.value ?? 0).toStringAsFixed(1),
//               onChanged: widget.onChanged,
//             ),
//             SliderAction(
//               function: widget.onIncrement,
//               icon: Icons.add,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class AnimatedSliderValue extends StatelessWidget {
//   const AnimatedSliderValue(this.value, {Key? key}) : super(key: key);
//   final double value;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Center(
//         child: Text(' ${value.toStringAsFixed(1)} %',
//             style: TextStyle(
//                 fontSize: 15 + (1 * (value * 0.1)),
//                 fontWeight: FontWeight.bold)),
//       ),
//     );
//   }
// }

// class SliderAction extends StatefulWidget {
//   final void Function() function;
//   final IconData icon;

//   const SliderAction({
//     super.key,
//     required this.function,
//     required this.icon,
//   });

//   @override
//   State<SliderAction> createState() => _SliderActionState();
// }

// class _SliderActionState extends State<SliderAction> {
//   Timer? timer;
//   @override
//   Widget build(BuildContext context) {
//     final GeneralState generalState =
//         Provider.of<GeneralState>(context, listen: false);
//     return GestureDetector(
//       onTap: widget.function,
//       onLongPressStart: (details) async {
//         setState(() {
//           timer =
//               Timer.periodic(Duration(milliseconds: generalState.delay), (_) {
//             widget.function();
//             generalState.decreaseDelay();
//           });
//         });
//       },
//       onLongPressEnd: (details) {
//         timer?.cancel();
//         generalState.resetDelay();
//       },
//       child: Icon(widget.icon),
//     );
//   }
// }
