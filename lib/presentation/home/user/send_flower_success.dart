import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ofwhich_v2/injectable.dart';

import '../../../domain/user_service/model/user_object.dart';
import '../../core/font.dart';
import '../../general_widgets/custom_button.dart';
import '../../routes/app_router.dart';
import '../../routes/app_router.gr.dart';

@RoutePage()
class SendFloweSuccess extends StatelessWidget {
  const SendFloweSuccess({super.key, required this.user});
  final UserModel user;

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
          Text("Awesome!",
              style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: Font.inter)),
          Text("Your flower has been sent to ${user.full_name} \nsuccessfully",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: Font.inter,
                  color: const Color(0xFF646464))),
          SizedBox(height: 20.h),
          CustomButton(
            height: 60.h,
            borderRadius: BorderRadius.circular(10.r),
            width: MediaQuery.of(context).size.width,
            onPressed:
                // model.agreedToTerms
                // ?
                () {
              getIt<AppRouter>().pushAndPopUntil(const BottomNavRoute(),
                  predicate: (_) => false);
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
