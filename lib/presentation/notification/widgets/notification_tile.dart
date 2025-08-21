import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationTile extends StatelessWidget {
  final String message;
  final String dateTime;
  final bool isUnread;

  const NotificationTile({super.key, 
    required this.message,
    required this.dateTime,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              fontWeight: isUnread ? FontWeight.w500 : FontWeight.normal,
              color: isUnread ? Colors.black : Colors.grey,
            ),
          ),
          SizedBox(height: 4.0.h),
          Text(
            dateTime,
            style: TextStyle(
              color: isUnread ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
