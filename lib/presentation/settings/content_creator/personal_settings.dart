import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_button.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_textfield.dart';

import '../../core/font.dart';
import '../../general_widgets/custom_appbar.dart';

@RoutePage()
class PersonalSettings extends StatelessWidget {
  const PersonalSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const OfWhichAppBar(
          titleText: "Person Information",
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomTextFieldWidget(
                    label: "Full Name*",
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
                    label: "Email Address*",
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
                    prefix: Text("+234",
                        style: TextStyle(
                            fontFamily: Font.rubik,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 14.sp)),
                    label: "Phone Number*",
                    labelTextStyle: TextStyle(
                        fontFamily: Font.rubik,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF535353),
                        fontSize: 16.sp),
                  ),
                ],
              ),
              Column(
                children: [
                  CustomButton(
                      borderRadius: BorderRadius.circular(10.r),
                      height: 70.h,
                      child: Text("Save",
                          style: TextStyle(
                              fontFamily: Font.inter,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 16.sp)),
                      onPressed: () {}),
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
