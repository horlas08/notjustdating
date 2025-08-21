import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';

import '../../core/font.dart';
import '../../general_widgets/custom_button.dart';
import '../../routes/app_router.gr.dart';

@RoutePage()
class AccountCreationSuccess extends StatelessWidget {
  const AccountCreationSuccess({super.key, required this.userType});
  final String userType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/svgs/success.svg"),
          SizedBox(
            height: 20.h,
          ),
          Text("Awesome!",
              style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: Font.inter)),
          Text("Your Not just dating has been \ncreated successfully",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: Font.inter,
                  color: const Color(0xFF646464))),
          SizedBox(height: 20.h),
          CustomButton(
            height: 56.h,
            borderRadius: BorderRadius.circular(10.r),
            width: MediaQuery.of(context).size.width,
            onPressed:
                // model.agreedToTerms
                // ?
                () {
              getIt<AppRouter>().push(EditNameRoute(userType: "user"));
            },
            // : null,
            child: Text("Continue",
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontFamily: Font.inter,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      );
    
  }
}
