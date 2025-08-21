// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown extends StatefulWidget {
  final Widget? child;
  final String? label;
  final TextStyle? labelStyle;
  final Color? color;
  final double? width;
  final bool useParent;
  final double? labelSpace;
  final Color? borderColor;
  const CustomDropdown({
    super.key,
    required this.child,
    this.label,
    this.color,
    this.labelStyle,
    this.width,
    this.labelSpace,
    this.borderColor,
    this.useParent = false,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.label ?? '',
            style: widget.labelStyle ??
                TextStyle(
                    fontSize: 15.5.sp, color: widget.color ?? Colors.black),
          ),
          widget.label == null
              ? Container()
              : SizedBox(height: widget.labelSpace ?? size.height * 0.01),
          Container(
            padding: widget.useParent
                ? EdgeInsets.only(
                    top: 5.w, bottom: 10.w, right: 20.w, left: 12.w)
                : EdgeInsets.only(
                    top: 5.w, bottom: 10.w, right: 0.w, left: 0.w),
            width: widget.width ?? size.width,
            // height: 70.h,
            decoration: widget.useParent
                ? BoxDecoration(
                    color: widget.color ?? Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                        width: 1.5.w,
                        color: widget.borderColor ?? Colors.grey.shade700))
                : null,
            child:
                DropdownButtonHideUnderline(child: widget.child ?? Container()),
          ),
          SizedBox(height: size.height * 0.02),
        ]);
  }
}
