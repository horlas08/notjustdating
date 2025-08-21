import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_appbar.dart';

@RoutePage()
class SecuritySettingsScreen extends StatelessWidget {
  const SecuritySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OfWhichAppBar(
        titleText: "Security Settings",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: ListView(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Manage your account’s security and keep track of your account’s usage, including app that you have connected to your account',
              style:
                  TextStyle(fontSize: 14.0.sp, color: const Color(0xFF6C6C6C)),
            ),
            // const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Security',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: Font.inter,
                      color: Colors.black)),
              subtitle: Text("Manage your account's security.",
                  style: TextStyle(
                      fontSize: 12.sp, color: const Color(0xFF898989))),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to Security settings
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('App and sessions',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: Font.inter,
                      color: Colors.black)),
              subtitle: Text(
                  'See information about connected apps and login sessions for your account.',
                  style: TextStyle(
                      fontSize: 12.sp, color: const Color(0xFF898989))),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to App and sessions
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Connected accounts',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: Font.inter,
                      color: Colors.black)),
              subtitle: Text(
                  'Manage Google or Apple accounts connected to footfan to log in.',
                  style: TextStyle(
                      fontSize: 12.sp, color: const Color(0xFF898989))),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to Connected accounts
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Delegate',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: Font.inter,
                      color: Colors.black)),
              subtitle: Text('Manage your shared accounts.',
                  style: TextStyle(
                      fontSize: 12.sp, color: const Color(0xFF898989))),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to Delegate settings
              },
            ),
          ],
        ),
      ),
    );
  }
}
