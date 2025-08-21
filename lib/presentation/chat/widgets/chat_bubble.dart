// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/font.dart';

class ChatBuble extends StatelessWidget {
  final String message;
  final Widget? child;
  final VoidCallback? onTap;
  final Color? color;
  final bool isReceiver;
  final String? dateTime;

  const ChatBuble({
    super.key,
    required this.message,
    this.child,
    this.onTap,
    this.isReceiver = false,
    this.dateTime,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isReceiver ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: color ?? Theme.of(context).primaryColor,
          ),
          child: child != null
              ? GestureDetector(onTap: onTap, child: child)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: isReceiver ? Colors.black87 : Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
        SizedBox(height: 5.h),
        Row(
          mainAxisAlignment:
              isReceiver ? MainAxisAlignment.start : MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isReceiver) Image.asset("assets/images/pngs/green_check.png"),
            SizedBox(width: 4.w), // Space between the checkmark and the text
            Text(
              dateTime ?? "Loading..",
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                fontFamily: Font.inter,
                color: Colors.grey.shade500,
              ),
            ),
            if (!isReceiver) Image.asset("assets/images/pngs/green_check.png"),
          ],
        ),
      ],
    );
  }
}
