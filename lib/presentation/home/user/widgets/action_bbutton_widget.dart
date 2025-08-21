import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionButtonWidget extends StatelessWidget {
  const ActionButtonWidget(
      {Key? key,
      required this.onPressed,
      required this.icon,
      this.backgroundColor,
      this.containerHeight})
      : super(key: key);
  final VoidCallback onPressed;
  final Widget icon;
  final Color? backgroundColor;
  final double? containerHeight;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      shape: const CircleBorder(),
      child: Container(
        height: containerHeight ?? 70.h,
        decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white, shape: BoxShape.circle),
        child: GestureDetector(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: icon,
            )),
      ),
    );
  }
}
