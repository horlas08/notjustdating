import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../injectable.dart';
import '../../core/font.dart';
import '../../general_widgets/custom_button.dart';
import '../../routes/app_router.dart';
import '../../routes/app_router.gr.dart';

@RoutePage()
class PasswordResetSuccess extends StatefulWidget {
  const PasswordResetSuccess({super.key, required this.userType});
  final String userType;

  @override
  State<PasswordResetSuccess> createState() => _PasswordResetSuccessState();
}

class _PasswordResetSuccessState extends State<PasswordResetSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: Column(
          children: [
            const Spacer(), // Pushes content down to center
            SvgPicture.asset("assets/images/svgs/success.svg"),
            SizedBox(height: 50.h),
            Text("Password Reset!",
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: Font.inter)),
            SizedBox(height: 20.h),
            Text("Your password has been reset sucessfully",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: Font.inter,
                    color: const Color(0xFF646464))),
            const Spacer(), // Pushes button to bottom
            CustomButton(
              height: 65.h,
              borderRadius: BorderRadius.circular(15.r),
              width: MediaQuery.of(context).size.width,
              onPressed: () {
                getIt<AppRouter>().push(LoginRoute(userType: widget.userType));
              },
              child: Text("Login",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontFamily: Font.inter,
                      fontWeight: FontWeight.w400)),
            ),
            SizedBox(height: 40.h), // spacing below the button
          ],
        ),
      ),
    );
  }
}
