// import 'package:<project-name>/model/profile.dart';
// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ofwhich_v2/injectable.dart';
// import 'package:ofwhich_v2/presentation/routes/app_router.dart';
// import 'package:ofwhich_v2/presentation/routes/app_router.dart';
// import 'package:ofwhich/presentation/routes/app_router.gr.dart';

import '../../../../domain/user_service/model/user_object.dart';
import '../../../core/font.dart';
import '../../../general_widgets/app_image.dart';
import 'app_image_widget.dart';
// import '../../../routes/app_router.gr.dart';
// import '../../../injectable.dart';
// import '../../routes/app_router.dart';
// import '../../routes/app_router.gr.dart';
// import '../model/profile_model.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.profile,
    required this.currentIndex,
  }) : super(key: key);
  final UserModel profile;
  final int currentIndex;
  // final VoidCallback selectedProfileCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 580,
      width: MediaQuery.sizeOf(context).width,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: AppImageWidget(
                  imageUrl: profile.photo!,
                )),
          ),
          Positioned(
            bottom: 200.h,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    profile.full_name ?? "",
                    style: TextStyle(
                        fontFamily: Font.inter,
                        fontWeight: FontWeight.w800,
                        fontSize: 21,
                        color: Colors.white),
                  ),
                  Text(
                    profile.gender ?? "",
                    style: TextStyle(
                      fontFamily: Font.inter,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
