import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomRangeSlider extends StatefulWidget {
//   const CustomRangeSlider(
//       {Key? key,
//       required this.division,
//       required this.minValue,
//       required this.maxValue,
//       required this.startValue,
//       required this.endValue,
//       this.isType1 = true,
//       required this.onChange,
//       required this.multiplierValue})
//       : super(key: key);
//   final int minValue;
//   final int maxValue;
//   final double startValue;
//   final double endValue;
//   final double multiplierValue;
//   final int division;
//   final bool isType1;
//   final Function(RangeValues values) onChange;

//   @override
//   State<CustomRangeSlider> createState() => _CustomRangeSliderState();
// }

// class _CustomRangeSliderState extends State<CustomRangeSlider> {
//   double _startValue = 0.0;
//   double _endValue = 0.0;

//   @override
//   void initState() {
//     _startValue = widget.startValue;
//     _endValue = widget.endValue;
//     super.initState();
//   }

//   // Method to determine label color based on proximity to slider values
//   Color _getLabelColor(double value) {
//     if (value == _startValue || value == _endValue) {
//       return Theme.of(context).primaryColor; // Highlight for selected range
//     }
//     return Colors.black54; // Default color
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RangeSlider(
//           values: RangeValues(_startValue, _endValue),
//           min: widget.minValue.toDouble(),
//           max: widget.maxValue.toDouble(),
//           divisions: widget.division,
//           activeColor: Theme.of(context).primaryColor,
//           inactiveColor: Colors.grey[300],
//           onChanged: (RangeValues values) {
//             setState(() {
//               _startValue = values.start;
//               _endValue = values.end;
//             });
//             widget.onChange(values);
//           },
//           labels: RangeLabels(
//             widget.isType1
//                 ? '${_startValue.toInt()} km'
//                 : '${_startValue.toInt()}',
//             widget.isType1 ? '${_endValue.toInt()} km' : "${_endValue.toInt()}",
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: List.generate(
//             widget.division + 1,
//             (index) {
//               final value =
//                   index * widget.multiplierValue; // Steps: 0, 5, 10, 15, 20, 25
//               return Text(
//                 widget.isType1 ? '${value.toInt()} km' : '${value.toInt()}',
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w600,
//                   color: _getLabelColor(value),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

class CustomRangeSlider extends StatefulWidget {
  const CustomRangeSlider(
      {Key? key,
      required this.division,
      required this.minValue,
      required this.maxValue,
      required this.startValue,
      required this.endValue,
      this.isType1 = true,
      required this.onChange,
      required this.multiplierValue,
      this.stepSize = 1}) // Add stepSize with a default of 1
      : super(key: key);

  final int minValue;
  final int maxValue;
  final double startValue;
  final double endValue;
  final double multiplierValue;
  final int division;
  final double stepSize; // Step size for range slider
  final bool isType1;
  final Function(RangeValues values) onChange;

  @override
  State<CustomRangeSlider> createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  double _startValue = 0.0;
  double _endValue = 0.0;

  @override
  void initState() {
    _startValue = widget.startValue;
    _endValue = widget.endValue;
    super.initState();
  }

  // Method to determine label color based on proximity to slider values
  // Color _getLabelColor(double value) {
  //   if (value == _startValue || value == _endValue) {
  //     return Theme.of(context).primaryColor; // Highlight for selected range
  //   }
  //   return Colors.black54; // Default color
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RangeSlider(
          values: RangeValues(_startValue, _endValue),
          min: widget.minValue.toDouble(),
          max: widget.maxValue.toDouble(),
          divisions: ((widget.maxValue - widget.minValue) /
                  widget.stepSize) // Adjust divisions based on step size
              .round(),
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Colors.grey[300],
          onChanged: (RangeValues values) {
            setState(() {
              _startValue = values.start;
              _endValue = values.end;
            });
            widget.onChange(values);
          },
          labels: RangeLabels(
            widget.isType1
                ? '${_startValue.toInt()} km'
                : '${_startValue.toInt()}',
            widget.isType1 ? '${_endValue.toInt()} km' : "${_endValue.toInt()}",
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     // Start Value
        //     Text(
        //       widget.isType1
        //           ? '${widget.minValue.toInt()} km'
        //           : '${widget.minValue.toInt()}',
        //       style: TextStyle(
        //         fontSize: 14.sp,
        //         fontWeight: FontWeight.w600,
        //         color: Colors.black54,
        //       ),
        //     ),
        //     // End Value
        //     Text(
        //       widget.isType1
        //           ? '${widget.maxValue.toInt()} km'
        //           : '${widget.maxValue.toInt()}',
        //       style: TextStyle(
        //         fontSize: 14.sp,
        //         fontWeight: FontWeight.w600,
        //         color: Colors.black54,
        //       ),
        //     ),
        //   ],
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: List.generate(
        //     ((widget.maxValue - widget.minValue) / widget.stepSize)
        //             .round() +
        //         1, // Calculate the correct number of labels
        //     (index) {
        //       final value = widget.minValue.toDouble() +
        //           (index * widget.stepSize); // Use stepSize for labels
        //       return Text(
        //         widget.isType1 ? '${value.toInt()} km' : '${value.toInt()}',
        //         style: TextStyle(
        //           fontSize: 14.sp,
        //           fontWeight: FontWeight.w600,
        //           color: _getLabelColor(value),
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
