import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ofwhich_v2/presentation/general_widgets/app_back_button.dart';
import 'package:ofwhich_v2/presentation/onboarding/data/onboarding_model.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
// import 'package:ofwhich_v2/injectable.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../injectable.dart';
import '../core/font.dart';
import '../general_widgets/custom_button.dart';
import '../routes/app_router.dart';

// import '../routes/app_router.dart';
@RoutePage()
class OnboardingIndex extends StatefulWidget {
  const OnboardingIndex({super.key});

  @override
  State<OnboardingIndex> createState() => _OnboardingIndexState();
}

class _OnboardingIndexState extends State<OnboardingIndex> {
  final controller = PageController(viewportFraction: 1.0);
  // final _appRouter = getIt<AppRouter>();

  int outterIndex = 0;
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     body: Stack(
    //   children: [
    //     PageView.builder(
    //         controller: controller,
    //         itemCount: onboardingPages.length,
    //         onPageChanged: (val) {
    //           setState(() {
    //             outterIndex = val;
    //           });
    //         },
    //         itemBuilder: (context, index) {
    //           return Column(children: [
    //             ClipRRect(
    //               borderRadius:
    //                   BorderRadius.only(bottomRight: Radius.circular(70.r)),
    //               child: Image.asset(onboardingPages[index].imgUrl,
    //                   fit: BoxFit.fitWidth,
    //                   width: MediaQuery.of(context).size.width,
    //                   height: MediaQuery.of(context).size.height * 0.65),
    //             ),
    //             SizedBox(height: 20.h),
    //             Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 20.0.w),
    //               child: Column(
    //                 children: [
    //                   Text(
    //                     onboardingPages[outterIndex].title,
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.w700,
    //                         fontSize: 18.sp,
    //                         color: Colors.black,
    //                         fontFamily: Font.inter),
    //                   ),
    //                   // SizedBox(height: 10.h),
    //                   // Text(
    //                   //   onboardingPages[index].subTitle,
    //                   //   style: TextStyle(
    //                   //       fontWeight: FontWeight.w400,
    //                   //       fontSize: 14.sp,
    //                   //       color: const Color(0xFF464646),
    //                   //       fontFamily: Font.inter),
    //                   // ),
    //                 ],
    //               ),
    //             )
    //           ]);
    //         }),
    //     outterIndex != 0
    //         ? Positioned(
    //             top: 25.h,
    //             left: 10.h,
    //             child: AppBackButton(
    //               onTap: () {
    //                 controller.previousPage(
    //                     duration: const Duration(milliseconds: 50),
    //                     curve: Curves.easeIn);
    //               },
    //             ))
    //         : Container(),
    //     Positioned(
    //       bottom: 50.91.h,
    //       left: 0.0.w,
    //       right: 0.0.w,
    //       child: Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 20.0.w),
    //         child:
    // Row(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             SmoothPageIndicator(
    //               controller: controller,
    //               count: onboardingPages.length,
    //               // introWidgetList.length,
    //               effect: ExpandingDotsEffect(
    //                 spacing: 10.0,
    //                 radius: 10.0,
    //                 dotWidth: 8.0,
    //                 dotHeight: 8.0,
    //                 dotColor: Colors.grey.shade600,
    //                 paintStyle: PaintingStyle.fill,
    //                 strokeWidth: 0.5,
    //                 activeDotColor:
    //                     // onboardingPages[outterIndex]== ou
    //                     Theme.of(context).primaryColor,
    //               ),
    //             ),
    //             // if (true) ...[
    //             Padding(
    //               padding: EdgeInsets.only(bottom: 14.w),
    //               child: CustomButton(
    //                   borderRadius: BorderRadius.circular(15.r),
    //                   onPressed: () {
    //                     if (outterIndex < 2) {
    //                       controller.nextPage(
    //                           duration: const Duration(milliseconds: 50),
    //                           curve: Curves.easeIn);
    //                     } else {
    //                       getIt<AppRouter>().push(const OnboardingRoute());
    //                     }
    //                   },
    //                   height: 60.h,
    //                   width: 60.w,
    //                   child: SvgPicture.asset(
    //                       "assets/images/svgs/arrow_forward.svg")),
    //             )
    //             // ]
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // ));

    // return Scaffold(
    //   // backgroundColor: Colors.white,
    //   body: Stack(
    //     children: [
    //       // your existing PageView
    //       PageView.builder(
    //           controller: controller,
    //           itemCount: onboardingPages.length,
    //           onPageChanged: (val) {
    //             setState(() {
    //               outterIndex = val;
    //             });
    //           },
    //           itemBuilder: (context, index) {
    //             return Column(children: [
    //               Image.asset(onboardingPages[index].imgUrl,
    //                   fit: BoxFit.fill,
    //                   width: MediaQuery.of(context).size.width,
    //                   height: MediaQuery.of(context).size.height * 0.8),
    //               // SizedBox(height: 20.h),
    //             ]);
    //           }),

    //       // back button logic
    //       outterIndex != 0
    //           ? Positioned(
    //               top: 25.h,
    //               left: 10.h,
    //               child: AppBackButton(
    //                 onTap: () {
    //                   controller.previousPage(
    //                       duration: const Duration(milliseconds: 50),
    //                       curve: Curves.easeIn);
    //                 },
    //               ))
    //           : SizedBox.shrink(),

    //       Positioned(
    //         bottom: 0,
    //         top: MediaQuery.sizeOf(context).height * 0.65,
    //         left: 0,
    //         right: 0,
    //         // height: 160.h, // Adjust as needed
    //         child: Container(
    //           decoration: const BoxDecoration(
    //             gradient: LinearGradient(
    //               begin: Alignment.topCenter,
    //               end: Alignment.bottomCenter,
    //               colors: [
    //                 Colors.transparent,
    //                 Colors.black,
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),

    //       // 🔘 Dots and next/skip buttons
    //       Positioned(
    //         bottom: 50.91.h,
    //         left: 0.0.w,
    //         right: 0.0.w,
    //         child: Padding(
    //           padding: EdgeInsets.symmetric(horizontal: 20.0.w),
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               SmoothPageIndicator(
    //                 controller: controller,
    //                 count: onboardingPages.length,
    //                 // introWidgetList.length,
    //                 effect: ExpandingDotsEffect(
    //                   spacing: 10.0,
    //                   radius: 10.0,
    //                   dotWidth: 8.0,
    //                   dotHeight: 8.0,
    //                   dotColor: Colors.grey.shade600,
    //                   paintStyle: PaintingStyle.fill,
    //                   strokeWidth: 0.5,
    //                   activeDotColor:
    //                       // onboardingPages[outterIndex]== ou
    //                       Theme.of(context).primaryColor,
    //                 ),
    //               ),
    //               // if (true) ...[
    //               Padding(
    //                 padding: EdgeInsets.only(bottom: 14.w),
    //                 child: CustomButton(
    //                     borderRadius: BorderRadius.circular(15.r),
    //                     onPressed: () {
    //                       if (outterIndex < 2) {
    //                         controller.nextPage(
    //                             duration: const Duration(milliseconds: 50),
    //                             curve: Curves.easeIn);
    //                       } else {
    //                         getIt<AppRouter>().push(const OnboardingRoute());
    //                       }
    //                     },
    //                     height: 60.h,
    //                     width: 60.w,
    //                     child: SvgPicture.asset(
    //                         "assets/images/svgs/arrow_forward.svg")),
    //               )
    //               // ]
    //             ],
    //           ),
    //         ),
    //       ),

    //       // Optional: Skip button at the top right
    //       Positioned(
    //         top: 50.h,
    //         right: 20.w,
    //         child: GestureDetector(
    //           onTap: () {
    //             getIt<AppRouter>().push(const OnboardingRoute());
    //           },
    //           child: Text(
    //             "Skip",
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontSize: 14.sp,
    //               fontWeight: FontWeight.w500,
    //             ),
    //           ),
    //         ),
    //       ),

    //       Positioned(
    //           top: MediaQuery.sizeOf(context).height * 0.7,
    //           left: 0,
    //           right: 0,
    //           child: Padding(
    //             padding: EdgeInsets.symmetric(horizontal: 20.0.w),
    //             child: Column(
    //               children: [
    //                 Text(
    //                   onboardingPages[outterIndex].title,
    //                   style: TextStyle(
    //                       fontWeight: FontWeight.w700,
    //                       fontSize: 18.sp,
    //                       color: Colors.black,
    //                       fontFamily: Font.inter),
    //                 ),
    //               ],
    //             ),
    //           )),
    //     ],
    //   ),
    // );

    return Scaffold(
      body: Stack(
        children: [
          // PageView with blended images
          PageView.builder(
            controller: controller,
            itemCount: onboardingPages.length,
            onPageChanged: (val) {
              setState(() {
                outterIndex = val;
              });
            },
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  // Base image
                  Image.asset(
                    onboardingPages[index].imgUrl,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  // Gradient overlay for blending
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.4, 0.7, 1.0],
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Back button logic
          outterIndex != 0
              ? Positioned(
                  top: 25.h,
                  left: 10.h,
                  child: AppBackButton(
                    onTap: () {
                      controller.previousPage(
                          duration: const Duration(milliseconds: 50),
                          curve: Curves.easeIn);
                    },
                  ))
              : SizedBox.shrink(),

          // Skip button at the top right
          Positioned(
            top: 50.h,
            right: 20.w,
            child: GestureDetector(
              onTap: () {
                getIt<AppRouter>().push(const OnboardingRoute());
              },
              child: Text(
                "Skip",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Title text
          Positioned(
            bottom: 180.h, // Adjusted position
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    onboardingPages[outterIndex].title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 32.sp, // Larger font size to match the image
                      color: Colors.white,
                      fontFamily: Font.inter,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Dots and next button
          Positioned(
            bottom: 50.91.h,
            left: 0.0.w,
            right: 0.0.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: onboardingPages.length,
                    // introWidgetList.length,
                    effect: ExpandingDotsEffect(
                      spacing: 10.0,
                      radius: 10.0,
                      dotWidth: 8.0,
                      dotHeight: 8.0,
                      dotColor: Colors.grey.shade600,
                      paintStyle: PaintingStyle.fill,
                      strokeWidth: 0.5,
                      activeDotColor:
                          // onboardingPages[outterIndex]== ou
                          Theme.of(context).primaryColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 14.w),
                    child: CustomButton(
                      borderRadius: BorderRadius.circular(15.r),
                      onPressed: () {
                        if (outterIndex < 2) {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 50),
                              curve: Curves.easeIn);
                        } else {
                          getIt<AppRouter>().push(const OnboardingRoute());
                        }
                      },
                      height: 50.h,
                      width: 120.w,
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
