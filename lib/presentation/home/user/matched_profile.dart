import 'dart:ui';

// import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:ofwhich_v2/domain/user_service/model/picture_model.dart';
import 'package:ofwhich_v2/domain/user_service/model/user_object.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
// import 'package:ofwhich_v2/presentation/home/user/choose_location_screen.dart';
import 'package:ofwhich_v2/presentation/home/user/plan_date_screen.dart';
import 'package:ofwhich_v2/presentation/home/user/widgets/cards_stack_widget.dart';
// import 'package:ofwhich_v2/presentation/routes/app_router.dart';

class MatchedProfile extends StatelessWidget {
  final UserModel profile;
  const MatchedProfile({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> infoItems = [
      {'title': 'Height', 'val': profile.height.toString()},
      {'title': 'Weight', 'val': profile.weight.toString()},
      {'title': 'Body Type', 'val': ""},
      {'title': 'Sign', 'val': ""},
      {'title': 'Smoke', 'val': profile.smokes ?? ""},
      {'title': 'Alcohol', 'val': profile.drinks ?? ""},
      {'title': 'Education', 'val': profile.education_level ?? ""},
      {'title': 'Hobbies', 'val': ""},
      {'title': 'Sexual Orientation', 'val': profile.sexual_orientation ?? ""},
      {'title': 'Religion', 'val': profile.religion ?? ""},
    ];

    final List<String> hobbies = profile.interests!.toList();
    List<String?> fileUrls =
        profile.pictures?.map((pic) => pic.file_url).toList() ?? [];

// [
//   "Travelling",
//   "Reading",
//   "Explore",
//   "Open-minded",
//   "Sustainability",
//   "Cooking",
//   "Movies & Cinemas",
// ];

    return Scaffold(
      bottomNavigationBar: Container(
        height: 80.h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black26,
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: _acceptOrDecline(context, profile),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              // Image.asset(
              //   "assets/images/pngs/dummy_home_pic.png",
              //   height: 576.h,
              // ),
              Container(
                width: double.infinity,
                height: 576.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        profile.photo ?? ''), // Adjust based on your model
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 21.h,
                    ),
                    Row(
                      children: [
                        Text(
                          profile.full_name ?? 'Unknown',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: Font.inter,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Container(
                          width: 9.w,
                          height: 9.h,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          '/yrs',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: Font.inter,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    _lastSeen(),
                    SizedBox(
                      height: 25.h,
                    ),
                    Divider(
                      height: 1.h,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      "About Me",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      profile.bio ?? "",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    dividerGap(),
                    _aboutMe("Things to know about me", aboutMe,
                        Colors.black.withOpacity(0.03), Colors.black),
                    dividerGap(),
                    _aboutMe(
                        "My hobbies & Interests",
                        hobbies,
                        const Color.fromRGBO(236, 150, 165, 0.1),
                        const Color.fromRGBO(152, 28, 50, 1)),
                    dividerGap(),
                    _info(profile.job_title.toString(), "",
                        profile.address.toString()),
                    dividerGap(),
                    _basicInformation(infoItems),
                    dividerGap(),
                    Text("My Gallery",
                        style: TextStyle(
                            fontSize: 18.sp,
                            //fontFamily: Font.inter,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    SizedBox(
                      height: 19.h,
                    ),
                    _userGalleryGrid(fileUrls),
                    SizedBox(
                      height: 25.h,
                    ),
                    _card(),
                    dividerGap(),
                    _report(),
                    SizedBox(
                      height: 100.h,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget dividerGap() {
  return Column(
    children: [
      SizedBox(
        height: 25.h,
      ),
      Divider(
        height: 1.h,
      ),
      SizedBox(
        height: 25.h,
      ),
    ],
  );
}

Widget _lastSeen() {
  return Row(
    children: [
      Text.rich(
        TextSpan(
          text: 'From ',
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(132, 132, 132, 1)),
          children: [
            TextSpan(
              text: 'Manchester',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
              ),
            ),
            TextSpan(
              text: 'Last seen recently',
              style: TextStyle(
                fontSize: 16.sp,
                fontStyle: FontStyle.italic,
                color: const Color.fromRGBO(132, 132, 132, 1),
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Widget _acceptOrDecline(BuildContext context, UserModel profile) {
  return SizedBox(
    height: 113.h,
    // decoration: BoxDecoration(
    //   color: Colors.black.withOpacity(0.2),
    //   borderRadius: BorderRadius.circular(20),
    //   border: Border.all(
    //     color: Colors.white.withOpacity(0.2),
    //   ),
    // ),
    child: Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 60.h,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                foregroundColor: Colors.white,
                side: const BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                ),
              ),
              onPressed: () {},
              child: Text(
                "Not Interested",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: Font.inter,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 60.h,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(236, 88, 115, 1),
                side: const BorderSide(
                    width: 0, color: Color.fromRGBO(236, 88, 115, 1)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              onPressed: () async {
                //getIt<AppRouter>().push(ChooseLocationScreen());
                final authUser = await getUserSavedLocally();
                if (!context.mounted) return;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlanDateScreen(
                        profile: profile,
                        authUser: authUser!,
                      ),
                    ));
              },
              child: Text("I'll go for a drink",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: Font.inter,
                      fontWeight: FontWeight.w400,
                      color: Colors.white)),
            ),
          ),
        ),
      ],
    ),
  );
}

final List<String> aboutMe = [
  "Serious Dating",
  "Still figuring it out",
  "I don't drink alcohol",
  "i don't smoke"
];

final List<String> hobbies = [
  "Travelling",
  "Reading",
  "Explore",
  "Open-minded",
  "Sustainability",
  "Cooking",
  "Movies & Cinemas",
];

Widget _aboutMe(String title, List<String> chipLabels, Color backgroundColor,
    Color textColor) {
  return SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 18.sp,
                fontFamily: Font.inter,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
        SizedBox(
          height: 19.h,
        ),
        _chipTilesMatchProfile(chipLabels, backgroundColor, textColor)
      ],
    ),
  );
}

Widget _chipTilesMatchProfile(
    List<String> chipLabels, Color backgroundColor, Color textColor) {
  return Wrap(
    alignment: WrapAlignment.start,
    spacing: 10.w,
    runSpacing: 10.h,
    children: chipLabels.map((label) {
      //bool selected = controller.isSelected(label);
      return GestureDetector(
        onTap: () {
          // selected = !selected;
        },
        child: Container(
          height: 42.h,
          padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 11.h),
          decoration: BoxDecoration(
            color: backgroundColor,
            // border: Border.all(
            // //  color: Colors.redAccent,
            // ),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 16.sp, fontWeight: FontWeight.w400, color: textColor),
          ),
        ),
      );
    }).toList(),
  );
}

Widget _info(String job, String studied, String location) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _infoTile("assets/images/pngs/job_icon.png", "Job", job),
      SizedBox(height: 19.h),
      _infoTile("assets/images/pngs/studied_icon.png", "Studied", studied),
      SizedBox(height: 19.h),
      _infoTile("assets/images/pngs/location_icon.png", "Living", location),
    ],
  );
}

Widget _infoTile(String iconPath, String title, String subTitle) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image.asset(
        iconPath,
        height: 20.h,
        width: 20.w,
      ),
      SizedBox(width: 10.w),
      SizedBox(
        width: 70.w,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            fontFamily: Font.inter,
          ),
        ),
      ),
      Expanded(
        child: Text(
          subTitle,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            fontFamily: Font.inter,
          ),
        ),
      ),
    ],
  );
}

Widget _basicInformation(List<Map<String, String>> infoItems) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Basic Information",
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
      ),
      // SizedBox(
      //   height: 19.h,
      // ),
      buildBasicInfoGrid(infoItems),
    ],
  );
}

Widget buildBasicInfoGrid(List<Map<String, String>> infoList) {
  return SizedBox(
    height: 300.h, // 5 rows * tile height + spacing buffer
    child: GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 8.w,
      mainAxisSpacing: 8.h,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 194.w / 46.h,
      children: infoList
          .map((info) => _basicInfoTiles(info['title']!, info['val']!))
          .toList(),
    ),
  );
}

Widget _basicInfoTiles(String title, String val) {
  return Container(
    padding: EdgeInsets.only(left: 14.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.r),
      color: Colors.black.withOpacity(0.03),
    ),
    height: 46.h,
    width: 194.w,
    child: Row(
      children: [
        Text.rich(
          TextSpan(
              text: "$title: ",
              style: TextStyle(fontSize: 12.sp),
              children: [
                TextSpan(
                    text: "$val",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700))
              ]),
        )
      ],
    ),
  );
}

Widget _userGalleryGrid(List<String?> images) {
  // Ensure fixed number of slots (e.g., 6)
  int totalSlots = 6;
  List<String?> displayImages = List.from(images);

  while (displayImages.length < totalSlots) {
    displayImages.add(null);
  }

  return GridView.builder(
    padding: const EdgeInsets.all(0), // removes all padding
    itemCount: displayImages.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 0.75,
    ),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      final img = displayImages[index];

      if (img == null || img.isEmpty) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[400]!),
          ),
          child: Center(
            child: Icon(
              Icons.add_a_photo_rounded,
              size: 36,
              color: Colors.grey[500],
            ),
          ),
        );
      }

      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          img,
          fit: BoxFit.cover,
        ),
      );
    },
  );
}

Widget _card() {
  return Container(
    width: double.infinity,
    color: const Color.fromRGBO(152, 45, 65, 1),
    padding: const EdgeInsets.all(14),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 35.h),
      color: const Color.fromRGBO(167, 76, 93, 1),
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('assets/images/pngs/card_bg.png'),
      //     fit: BoxFit.cover,
      //     colorFilter: ColorFilter.mode(
      //       Colors.white.withOpacity(0.15), // Adjust opacity here
      //       BlendMode.darken, // or BlendMode.srcOver for simple overlay
      //     ),
      //   ),
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/pngs/card_cup.png",
            height: 61.h,
            width: 61.w,
          ),
          SizedBox(
            height: 23.h,
          ),
          Text(
            "In case you match, you will go for\ncoffee in London\nYou both speak English",
            textAlign: TextAlign.center,
            style: GoogleFonts.allura(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    ),
  );
}

Widget _report() {
  return Container(
    height: 59.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      color: Colors.black.withOpacity(0.03),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.flag,
          size: 22.sp,
          color: Colors.black,
          fill: 0,
        ),
        SizedBox(
          width: 11.w,
        ),
        Text(
          "Report this profile",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
        )
      ],
    ),
  );
}
