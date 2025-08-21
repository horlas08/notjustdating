import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ofwhich_v2/application/profile/profile_view_model.dart';
// import 'package:ofwhich_v2/presentation/bottom_nav/content_creator/content_creator_nav.dart';
// import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
// import 'package:ofwhich/presentation/general_widgets/custom_button.dart';

import '../../../injectable.dart';
import '../../core/font.dart';
import '../../general_widgets/custom_button.dart';
// import '../../routes/app_router.dart';

@RoutePage()
class ProfileUpdateSuccessScreen extends StatelessWidget {
  const ProfileUpdateSuccessScreen({super.key, this.userType});
  final String? userType;

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     body: Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 20.0.w),
    //   child: Column(
    //     // crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       SvgPicture.asset("assets/images/svgs/success.svg"),
    //       SizedBox(
    //         height: 50.h,
    //       ),
    //       Text("Great",
    //           style: TextStyle(
    //               fontSize: 24.sp,
    //               fontWeight: FontWeight.w700,
    //               fontFamily: Font.inter)),
    //       Text("You have successfully set up \nyour profile",
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //               fontSize: 16.sp,
    //               fontWeight: FontWeight.w400,
    //               fontFamily: Font.inter,
    //               color: const Color(0xFF646464))),
    //       SizedBox(height: 20.h),
    //       CustomButton(
    //         height: 60.h,
    //         borderRadius: BorderRadius.circular(10.r),
    //         width: MediaQuery.of(context).size.width,
    //         onPressed:
    //             // model.agreedToTerms
    //             // ?
    //             () {
    //           getIt<ProfileViewModel>().exploreOfwhich();

    //           // getIt<AppRouter>().push( const EditNameRoute());
    //         },
    //         // : null,
    //         child: Text("Explore NotJustDating",
    //             style: TextStyle(
    //                 fontSize: 16.sp,
    //                 color: Colors.white,
    //                 fontFamily: Font.inter,
    //                 fontWeight: FontWeight.w400)),
    //       )
    //     ],
    //   ),
    // ));

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top section with icon and text
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Success icon
                  SvgPicture.asset("assets/images/svgs/success.svg"),

                  SizedBox(height: 40.h),

                  // "Great" title
                  Text(
                    "Great",
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: Font.inter,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Success message
                  Text(
                    "You have successfully set up your profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: Font.inter,
                      color: const Color(0xFF646464),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom section with button
            Column(
              children: [
                CustomButton(
                  height: 56.h,
                  borderRadius: BorderRadius.circular(15.r),
                  width: MediaQuery.of(context).size.width,
                  onPressed: () {
                    getIt<ProfileViewModel>().exploreOfwhich();
                  },
                  child: Text(
                    "Explore NotJustDating",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontFamily: Font.inter,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                SizedBox(height: 50.h), // Bottom padding
              ],
            ),
          ],
        ),
      ),
    );
  }
}
