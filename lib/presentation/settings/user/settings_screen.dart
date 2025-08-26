import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/profile/profile_view_model.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
// import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
import 'package:ofwhich_v2/presentation/user_profile/user/user_profile.dart';

import '../../suport/index.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 65.h),
            Text("Settings",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: Font.inter,
                    fontWeight: FontWeight.w500)),
            SizedBox(height: 50.h),
             ProfileCard(
              imgIcon: "assets/images/pngs/small_profile_Icon.png",
              titelText: "Personal information",
              onPressed: () {

              },
            ),
            SizedBox(
              height: 10.h,
            ),
             ProfileCard(
              imgIcon: "assets/images/pngs/notification_settings_icon.png",
              titelText: "Notification settings",
              onPressed: () {
                debugPrint("Navigating to Profile...");

              },
            ),
            SizedBox(
              height: 10.h,
            ),
            const ProfileCard(
              imgIcon: "assets/images/pngs/privacy_policy.png",
              titelText: "Security Settings",
            ),
            SizedBox(
              height: 10.h,
            ),
             ProfileCard(
              imgIcon: "assets/images/pngs/support_icon.png",
              titelText: "Support",
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Support()),
                );
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            ProfileCard(
              imgIcon: "assets/images/pngs/logout_icon.png",
              titelText: "Log Out",
              onPressed: () {
                getIt<ProfileViewModel>().logOut();
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            const ProfileCard(
              imgIcon: "assets/images/pngs/delete_icon.png",
              titelText: "Delete Account",
            )
          ],
        ),
      ),
    );
  }
}
