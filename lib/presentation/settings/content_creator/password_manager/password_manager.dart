import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';

import '../../../core/font.dart';
import '../../../general_widgets/custom_appbar.dart';
import '../../../general_widgets/custom_button.dart';
import '../../../general_widgets/custom_textfield.dart';
import '../../../routes/app_router.dart';

@RoutePage()
class PasswordManager extends StatelessWidget {
  const PasswordManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const OfWhichAppBar(
          titleText: "Password Manager",
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomTextFieldWidget(
                    label: "Current Password*",
                    labelTextStyle: TextStyle(
                        fontFamily: Font.rubik,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF535353),
                        fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFieldWidget(
                    label: "New Password*",
                    labelTextStyle: TextStyle(
                        fontFamily: Font.rubik,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF535353),
                        fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFieldWidget(
                    // prefix: Text("+234",
                    //     style: TextStyle(
                    //         fontFamily: Font.rubik,
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.black,
                    //         fontSize: 14.sp)),
                    label: "Repeat New Password*",
                    labelTextStyle: TextStyle(
                        fontFamily: Font.rubik,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF535353),
                        fontSize: 16.sp),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (val) {},
                  ),
                  Text(
                    "Sign out of all devices ",
                    style: TextStyle(
                        fontFamily: Font.inter,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF535353),
                        fontSize: 16.sp),
                  )
                ],
              ),
              Column(
                children: [
                  CustomButton(
                      borderRadius: BorderRadius.circular(10.r),
                      height: 70.h,
                      child: Text("Update Password",
                          style: TextStyle(
                              fontFamily: Font.inter,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 16.sp)),
                      onPressed: () {
                        getIt<AppRouter>().push(const PasswordUpdateSuccess());
                      }),
                  SizedBox(
                    height: 30.h,
                  )
                ],
              )
            ],
          ),
        ));
  }
}
