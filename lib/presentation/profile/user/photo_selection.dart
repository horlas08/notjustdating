import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// import 'package:stacked/stacked.dart';

import '../../../application/profile/profile_view_model.dart';
import '../../../injectable.dart';
import '../../core/font.dart';
import '../../general_widgets/custom_appbar.dart';
import '../../routes/app_router.dart';
import '../../routes/app_router.gr.dart';

@RoutePage()
class PhotosSelectionScreen extends StatefulWidget {
  const PhotosSelectionScreen(
      {super.key, this.userName, this.userType, this.fullName});
  final String? userName;
  final String? fullName;
  final String? userType;

  @override
  State<PhotosSelectionScreen> createState() => _PhotosSelectionScreenState();
}

class _PhotosSelectionScreenState extends State<PhotosSelectionScreen> {
  File? profilePhoto;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
          appBar: const CustomAppBar(
            titleText: "Personal Information",
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text("You can add more photos here",
                    style: TextStyle(
                        fontFamily: Font.inter,
                        fontSize: 26.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 5.h,
                ),
                Text("You can replace the photo at any time",
                    style: TextStyle(
                        fontFamily: Font.inter,
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w400)),
                SizedBox(height: 35.h),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        builder: (context) {
                          //   return Padding(
                          //     padding: EdgeInsets.symmetric(
                          //         horizontal: 20.0.w, vertical: 20.w),
                          //     child: SizedBox(
                          //       height: MediaQuery.of(context).size.height * 0.17,
                          //       child: Column(
                          //         children: [
                          //           InkResponse(
                          //             onTap: () async {
                          //               profilePhoto = await model.selextImage(
                          //                   type: "camera");
                          //               log("firstName :::: ${widget.fullName}");
                          //               log("username:::::${widget.userName}");
                          //               getIt<AppRouter>().push(
                          //                   ProfilePhotosRoute(
                          //                       fullname: widget.fullName,
                          //                       selectedPhoto: profilePhoto,
                          //                       userName: widget.userName));
                          //             },
                          //             child: Row(
                          //               children: [
                          //                 Image.asset(
                          //                   "assets/images/pngs/camera_icon.png",
                          //                   scale: 1.5,
                          //                 ),
                          //                 SizedBox(
                          //                   width: 10.w,
                          //                 ),
                          //                 Text(
                          //                   "Open camera",
                          //                   style: TextStyle(
                          //                       fontSize: 16.sp,
                          //                       fontFamily: Font.inter,
                          //                       fontWeight: FontWeight.w400),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //           SizedBox(height: 20.h),
                          //           SizedBox(
                          //               height: 10.h,
                          //               width: MediaQuery.of(context).size.width,
                          //               child: const Divider()),
                          //           SizedBox(height: 20.h),
                          //           InkResponse(
                          //             onTap: () async {
                          //               profilePhoto = await model.selextImage(
                          //                   type: "gallery");
                          //               log("firstName :::: ${widget.fullName}");
                          //               log("username:::::${widget.userName}");
                          //               getIt<AppRouter>().push(
                          //                   ProfilePhotosRoute(
                          //                       fullname: widget.fullName,
                          //                       selectedPhoto: profilePhoto,
                          //                       userName: widget.userName));
                          //             },
                          //             child: Row(
                          //               children: [
                          //                 Image.asset(
                          //                   "assets/images/pngs/gallery_icon.png",
                          //                   scale: 1.5,
                          //                 ),
                          //                 SizedBox(
                          //                   width: 10.w,
                          //                 ),
                          //                 Text(
                          //                   "Choose from gallery",
                          //                   style: TextStyle(
                          //                       fontSize: 16.sp,
                          //                       fontFamily: Font.inter,
                          //                       fontWeight: FontWeight.w400),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //           SizedBox(height: 20.h),
                          //         ],
                          //       ),
                          //     ),
                          //   );

                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.17,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0.w, right: 10.w, top: 30.w),
                                  child: InkResponse(
                                    onTap: () async {
                                      profilePhoto = await model.selextImage(
                                          type: "camera");
                                      log("firstName :::: ${widget.fullName}");
                                      log("username:::::${widget.userName}");
                                      getIt<AppRouter>()
                                          .push(ProfilePhotosRoute(
                                        fullname: widget.fullName,
                                        selectedPhoto: profilePhoto,
                                        userName: widget.userName,
                                      ));
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/pngs/camera_icon.png",
                                          scale: 1.5,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          "Open camera",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontFamily: Font.inter,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.h),

                                // Full-width divider without horizontal padding
                                Divider(
                                  height: 10.h,
                                  thickness: 0.5,
                                  color: Colors.black,
                                ),

                                SizedBox(height: 20.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0.w),
                                  child: InkResponse(
                                    onTap: () async {
                                      profilePhoto = await model.selextImage(
                                          type: "gallery");
                                      log("firstName :::: ${widget.fullName}");
                                      log("username:::::${widget.userName}");
                                      getIt<AppRouter>()
                                          .push(ProfilePhotosRoute(
                                        fullname: widget.fullName,
                                        selectedPhoto: profilePhoto,
                                        userName: widget.userName,
                                      ));
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/pngs/gallery_icon.png",
                                          scale: 1.5,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          "Choose from gallery",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontFamily: Font.inter,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                      height: 60.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: const Color(0xFFE7E7E7),
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: const Color(0xFFCACACA))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Select a Photo",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF434343))),
                            Image.asset("assets/images/pngs/plus_icon.png")
                          ],
                        ),
                      )),
                )
              ],
            ),
          )),
    );
  }
}
