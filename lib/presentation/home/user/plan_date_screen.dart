import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ofwhich_v2/domain/user_service/model/user_object.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_appbar.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_button.dart';
import 'package:ofwhich_v2/presentation/home/user/choose_location_screen.dart';

class PlanDateScreen extends StatelessWidget {
  final UserModel profile;

  const PlanDateScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OfWhichAppBar(
        titleText: "Plan a Date",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(
              height: 36.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              //height: 350.h,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColor,
                    const Color(0xFF4D5BD5),
                  ],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 38.h,
                  ),
                  Text(
                    "Ready to Date\nwith Rosie",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  buildMatchPairWidget(profile.photo ?? ""),
                  SizedBox(
                    height: 31.h,
                  ),
                  CustomButton(
                    height: 56.h,
                    borderRadius: BorderRadius.circular(15.r),
                    bgColor: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChooseLocationScreen(
                              profile: profile,
                            ),
                          ));
                    },
                    child: Text("Plan a Date",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color.fromRGBO(236, 88, 115, 1),
                            fontFamily: Font.inter,
                            fontWeight: FontWeight.w400)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildMatchPairWidget(String image) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Left Image
          Container(
            clipBehavior: Clip.hardEdge,
            height: 112.h,
            width: 112.w,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(70.r)),
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 24), // Spacer between the two profile pics
          // Right Image
          Container(
            clipBehavior: Clip.hardEdge,
            height: 112.h,
            width: 112.w,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(70.r)),
            child: Image.asset(
              'assets/images/pngs/dummy_home_pic.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      // Center Icon Circle (overlapping slightly on the two avatars)
      Container(
        height: 79.h,
        width: 79.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.pinkAccent, width: 2),
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/images/svgs/date_icon.svg',
            height: 44.h,
            width: 44.w,
          ),
        ),
      ),
    ],
  );
}
