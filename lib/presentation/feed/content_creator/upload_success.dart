import 'package:auto_route/annotations.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';

import '../../core/font.dart';
import '../../general_widgets/custom_button.dart';

@RoutePage()
class UploadSuccess extends StatefulWidget {
  const UploadSuccess({super.key});

  @override
  State<UploadSuccess> createState() => _UploadSuccessState();
}

class _UploadSuccessState extends State<UploadSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              Image.asset('assets/images/pngs/green_tick.png', scale: 1.7),
              SizedBox(height: 30.h),
              Text("Great!",
                  style: TextStyle(
                    fontFamily: Font.inter,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  )),
              SizedBox(height: 10.h),
              Text(
                  "Your upload has been sent for approval, and will be posted within 2hrs, kindly note that unapproved videos will disappear from your profile",
                  style: TextStyle(
                      fontFamily: Font.inter,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: const Color(0xFF646464))),
              SizedBox(height: 10.h),
              CustomButton(
                onPressed: () {
                  getIt<AppRouter>().pushAndPopUntil(
                      const ContentBottomNavRoute(),
                      predicate: (_) => false);
                  // List<String> taggedPeople = [];
                },
                height: 70.h,
                bgColor: Theme.of(context).primaryColor,
                // width: MediaQuery.of(context).size.width * 0.45,
                borderRadius: BorderRadius.circular(15.r),
                child: Text(
                  "Okay",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: Font.inter,
                      color: Colors.white),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    ));
  }
}
