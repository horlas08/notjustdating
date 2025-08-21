import 'package:auto_route/auto_route.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/presentation/general_widgets/app_back_button.dart';
// import 'package:ofwhich_v2/lib/presentation/core/font.dart';

import 'package:stacked/stacked.dart';

import '../../application/splash_screen/splash_view_model.dart';
import '../../injectable.dart';
import '../core/font.dart';
import '../general_widgets/custom_button.dart';
import '../routes/app_router.dart';
import '../routes/app_router.gr.dart';
// import '../routes/app_router.dart';
// import '../routes/app_router.gr.dart';

@RoutePage()
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => getIt<SplashViewModel>(),
      builder: (context, model, child) => Scaffold(
          body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              top: 0.h,
              right: 0.w,
              left: 0.w,
              bottom: 0.h,
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/images/pngs/image2.png",
                    fit: BoxFit.fill,
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8)
                  ],
                      stops: const [
                    0,
                    .4
                  ])),
            ),
            Positioned(
                top: MediaQuery.sizeOf(context).height * 0.6,
                left: 10.w,
                right: 10.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: Column(
                    children: [
                      Text("Welcome to Notjustdating.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.sp,
                              fontFamily: Font.inter,
                              fontWeight: FontWeight.w600)),

                      Text(
                          'Meet genuine singles and develop your relationship with our amazing resources and chat groups',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontFamily: Font.inter,
                              fontWeight:
                                  FontWeight.w400)), // SizedBox(height: 5.h),
                      CustomButton(
                        height: 65.h,
                        borderRadius: BorderRadius.circular(15.r),
                        width: MediaQuery.of(context).size.width,
                        onPressed: () {
                          // getIt<AppRouter>()
                          //     .push(const UserTypeSelectionRoute());
                          getIt<AppRouter>()
                              .replace(RegisterRoute(userType: "user"));
                        },
                        child: Text("Get Started",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontFamily: Font.inter,
                                fontWeight: FontWeight.w400)),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.75,
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                              text:
                                  "By Signing up for ofwhich, you agree to our ",
                              style: TextStyle(
                                  fontFamily: Font.inter,
                                  color: Colors.white,
                                  fontSize: 12.sp),
                              children: [
                                TextSpan(
                                    text: "\nTerms of services. ",
                                    style: TextStyle(
                                        fontFamily: Font.inter,
                                        color: Colors.white,
                                        fontSize: 12.sp)),
                                TextSpan(
                                    text: "Learn how we use your data in our ",
                                    style: TextStyle(
                                        fontFamily: Font.inter,
                                        color: Colors.white,
                                        fontSize: 12.sp)),
                                TextSpan(
                                    text: "  Privacy Policy.",
                                    style: TextStyle(
                                        fontFamily: Font.inter,
                                        color: Colors.white,
                                        fontSize: 12.sp))
                              ]),
                          maxLines: 3,
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
