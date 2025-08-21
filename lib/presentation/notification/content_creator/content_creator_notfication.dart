import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../general_widgets/app_logo.dart';
import '../widgets/notification_tile.dart';

@RoutePage()
class ContentCreatorNotification extends StatefulWidget {
  const ContentCreatorNotification({super.key});

  @override
  State<ContentCreatorNotification> createState() =>
      _ContentCreatorNotificationState();
}

class _ContentCreatorNotificationState
    extends State<ContentCreatorNotification> {
  final List<Map<String, String>> unreadNotifications = [
    {
      'message':
          'Your account has been verified successfully and now visible on skilldz.',
      'dateTime': 'Nov 02, 2023 20:18',
    },
    {
      'message':
          'Your account has been verified successfully and now visible on skilldz.',
      'dateTime': 'Nov 02, 2023 20:18',
    },
  ];
  final List<Map<String, String>> yesterdayNotifications = [
    {
      'message':
          'Your account has been verified successfully and now visible on skilldz.',
      'dateTime': 'Nov 02, 2023 20:18',
    },
    {
      'message':
          'Your account has been verified successfully and now visible on skilldz.',
      'dateTime': 'Nov 02, 2023 20:18',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Notifications'),
      // ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: Padding(
              padding: EdgeInsets.only(top: 10.0.w),
              child: const AppLogo(),
            )),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '2 Unread Notifications',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle mark as read action
                      },
                      child: const Text('Mark as Read'),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final notification = unreadNotifications[index];
                  return NotificationTile(
                    message: notification['message']!,
                    dateTime: notification['dateTime']!,
                    isUnread: true,
                  );
                },
                childCount: unreadNotifications.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Yesterday',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle clear all action
                      },
                      child: const Text('Clear All'),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final notification = yesterdayNotifications[index];
                  return NotificationTile(
                    message: notification['message']!,
                    dateTime: notification['dateTime']!,
                    isUnread: false,
                  );
                },
                childCount: yesterdayNotifications.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
