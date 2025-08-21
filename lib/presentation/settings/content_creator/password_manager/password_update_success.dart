import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';

import '../../../../injectable.dart';
import '../../../core/font.dart';
import '../../../general_widgets/custom_button.dart';
import '../../../routes/app_router.dart';

@RoutePage()
class PasswordUpdateSuccess extends StatelessWidget {
  const PasswordUpdateSuccess({super.key});

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
            height: 50.h,
          ),
          Text("Great!",
              style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: Font.inter)),
          Text("Your password has been successfully \nupdated ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: Font.inter,
                  color: const Color(0xFF646464))),
          SizedBox(height: 20.h),
          CustomButton(
            height: 70.h,
            borderRadius: BorderRadius.circular(10.r),
            width: MediaQuery.of(context).size.width,
            onPressed:
                // model.agreedToTerms
                // ?
                () {
              getIt<AppRouter>().popUntilRouteWithName(
                ContentCreatorSettings.name,
              );
              // getIt<AppRouter>().push( const EditNameRoute());
            },
            // : null,
            child: Text("Okay",
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontFamily: Font.inter,
                    fontWeight: FontWeight.w400)),
          )
        ],
      ),
    ));
  }
}
