// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_button.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import '../../../application/profile/profile_view_model.dart';
// import '../../../domain/core/validators/auth_validator.dart';
import '../../../injectable.dart';
// import '../../core/font.dart';
import '../../core/font.dart';
import '../../general_widgets/custom_appbar.dart';
import '../../routes/app_router.dart';
import '../../routes/app_router.gr.dart';
// import '../../general_widgets/custom_button.dart';
// import '../../general_widgets/custom_textfield.dart';

@RoutePage()
class ContentCrProfilePhoto extends StatefulWidget {
  const ContentCrProfilePhoto(
      {super.key, this.userType, this.firstName, this.username});
  final String? userType;
  final String? firstName;
  final String? username;
  @override
  State<ContentCrProfilePhoto> createState() => _ContentCrProfilePhotoState();
}

class _ContentCrProfilePhotoState extends State<ContentCrProfilePhoto> {
  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? profilePhoto;
  bool photoSelected = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
        appBar: const OfWhichAppBar(
          titleText: "Personal Information",
          leadingIcon: false,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 20.h),
                Text("Add a profile picture",
                    style: TextStyle(
                        fontFamily: Font.inter,
                        fontSize: 26.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                    "Let’s add a profile picture so your friends can easily recognize your account. your picture will be visible to everyone.",
                    style: TextStyle(
                        fontFamily: Font.rubik,
                        fontSize: 16.sp,
                        color: const Color(0xFF646464),
                        fontWeight: FontWeight.w400)),
                SizedBox(height: 50.h),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    maxRadius: 170.r,
                    backgroundColor: const Color(0xFFEC5873),
                    child: CircleAvatar(
                      maxRadius: 168.r,
                      backgroundColor: Colors.white,
                      backgroundImage: photoSelected
                          ? FileImage(profilePhoto ?? File("")) as ImageProvider
                          : const AssetImage(
                              "assets/images/pngs/big_image_avatar.png",
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                CustomButton(
                  onPressed: () {
                    photoSelected
                        ? getIt<AppRouter>().push(DateOfBirthContectCr(
                            userType: widget.userType,
                            username: widget.username,
                            firstName: widget.firstName,
                            selectedPhoto: profilePhoto))
                        : showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0.w, vertical: 20.w),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.17,
                                  child: Column(
                                    children: [
                                      InkResponse(
                                        onTap: () async {
                                          profilePhoto = await model
                                              .selextImage(type: "camera");
                                          setState(() {
                                            photoSelected = true;
                                          });
                                          // if (!mounted) return;
                                          Navigator.of(context).pop();

                                          // getIt<AppRouter>().push(
                                          //     ProfilePhotosRoute(
                                          //         selectedPhoto: profilePhoto,
                                          //         userName: widget.userName));
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/pngs/camera_icon.png",
                                              scale: 1.5,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              "Open camera",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontFamily: Font.inter,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                      SizedBox(
                                          height: 10.h,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: const Divider()),
                                      SizedBox(height: 20.h),
                                      InkResponse(
                                        onTap: () async {
                                          profilePhoto = await model
                                              .selextImage(type: "gallery");
                                          setState(() {
                                            photoSelected = true;
                                          });
                                          // getIt<AppRouter>().push(
                                          //     ProfilePhotosRoute(
                                          //         selectedPhoto: profilePhoto,
                                          //         userName: widget.userName));
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/pngs/gallery_icon.png",
                                              scale: 1.5,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              "Choose from gallery",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontFamily: Font.inter,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                    ],
                                  ),
                                ),
                              );
                            });
                  },
                  height: 60.h,
                  borderRadius: BorderRadius.circular(10.r),
                  child: photoSelected
                      ? Text("Done",
                          style: TextStyle(
                              fontFamily: Font.rubik,
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400))
                      : Text("Add Photo",
                          style: TextStyle(
                              fontFamily: Font.rubik,
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                ),
                CustomButton(
                    onPressed: () {
                      photoSelected
                          ? showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0.w, vertical: 20.w),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.17,
                                    child: Column(
                                      children: [
                                        InkResponse(
                                          onTap: () async {
                                            profilePhoto = await model
                                                .selextImage(type: "camera");
                                            setState(() {
                                              photoSelected = true;
                                            });
                                            // if (!mounted) return;
                                            Navigator.of(context).pop();

                                            // getIt<AppRouter>().push(
                                            //     ProfilePhotosRoute(
                                            //         selectedPhoto: profilePhoto,
                                            //         userName: widget.userName));
                                          },
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                "assets/images/pngs/camera_icon.png",
                                                scale: 1.5,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                "Open camera",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontFamily: Font.inter,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20.h),
                                        SizedBox(
                                            height: 10.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: const Divider()),
                                        SizedBox(height: 20.h),
                                        InkResponse(
                                          onTap: () async {
                                            profilePhoto = await model
                                                .selextImage(type: "gallery");
                                            setState(() {
                                              photoSelected = true;
                                            });
                                            // getIt<AppRouter>().push(
                                            //     ProfilePhotosRoute(
                                            //         selectedPhoto: profilePhoto,
                                            //         userName: widget.userName));
                                          },
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                "assets/images/pngs/gallery_icon.png",
                                                scale: 1.5,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                "Choose from gallery",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontFamily: Font.inter,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20.h),
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : getIt<AppRouter>().push(DateOfBirthContectCr(
                              userType: widget.userType,
                              username: widget.username,
                              firstName: widget.firstName,
                              selectedPhoto: profilePhoto));
                    },
                    bgColor: Colors.white,
                    borderColor: Colors.white,
                    height: 60.h,
                    borderRadius: BorderRadius.circular(10.r),
                    child: photoSelected
                        ? Text("Change Picture",
                            style: TextStyle(
                                fontFamily: Font.rubik,
                                fontSize: 16.sp,
                                color: const Color(0xFF383838),
                                fontWeight: FontWeight.w400))
                        : Text("Skip",
                            style: TextStyle(
                                fontFamily: Font.rubik,
                                fontSize: 16.sp,
                                color: const Color(0xFF383838),
                                fontWeight: FontWeight.w400)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
