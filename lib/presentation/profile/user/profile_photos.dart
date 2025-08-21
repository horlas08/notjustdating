import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/presentation/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../application/profile/profile_view_model.dart';
import '../../../injectable.dart';
import '../../core/font.dart';
import '../../general_widgets/custom_appbar.dart';
import '../../general_widgets/custom_button.dart';
import '../../routes/app_router.dart';
import '../../routes/app_router.gr.dart';

@RoutePage()
class ProfilePhotosScreen extends StatefulWidget {
  const ProfilePhotosScreen(
      {super.key,
      this.selectedPhoto,
      this.userName,
      this.userType,
      this.fullname});
  final File? selectedPhoto;
  final String? userName;
  final String? fullname;
  final String? userType;
  @override
  State<ProfilePhotosScreen> createState() => _ProfilePhotosScreenState();
}

class _ProfilePhotosScreenState extends State<ProfilePhotosScreen> {
  String secondImagePath = "";
  String thirdImagePath = "";

  String fourthImagePath = "";
  String fifthImagePath = "";
  String sixthImagePath = "";

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
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                    Text("You can replace the photos at any time",
                        style: TextStyle(
                            fontFamily: Font.inter,
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 35.h),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(widget.selectedPhoto!.path),
                                      )),
                                  borderRadius: BorderRadius.circular(20.r)),
                              height: MediaQuery.of(context).size.height * 0.28,
                              width: MediaQuery.of(context).size.width * 0.6,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    model.secondImage =
                                        await showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return const ImageSelection();
                                                }) ??
                                            File("");

                                    secondImagePath =
                                        await model.uploadUserPhoto(
                                            image: model.secondImage!,
                                            loadingStarted: () {
                                              setState(() {
                                                model.isSecondImageLoading =
                                                    true;
                                              });
                                            },
                                            loadingFinished: () {
                                              setState(() {
                                                model.isSecondImageLoading =
                                                    false;
                                              });
                                            },
                                            setDone: () {
                                              setState(() {
                                                model.isSecondImagUploadDone =
                                                    true;
                                              });
                                            });
                                    // setState(() {
                                    //   model.isSecondImageLoading = false;
                                    // });
                                  },
                                  child: model.isSecondImageLoading
                                      ? const CircularProgressIndicator()
                                      : Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.135,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.28,
                                          decoration: model
                                                  .isSecondImagUploadDone
                                              ? BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image:
                                                          CachedNetworkImageProvider(
                                                              secondImagePath)))
                                              : BoxDecoration(
                                                  color: Colors.grey,
                                                  // image: DecorationImage(
                                                  //     fit: BoxFit.cover,
                                                  //     image: FileImage(
                                                  //       File(widget.selectedPhoto!.path),
                                                  //     )),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r)),
                                          child: Icon(Icons.add_circle,
                                              color: Colors.grey.shade600)),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    model.thirdImage =
                                        await showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return const ImageSelection();
                                                }) ??
                                            File("");

                                    thirdImagePath =
                                        await model.uploadUserPhoto(
                                            image: model.thirdImage!,
                                            loadingStarted: () {
                                              setState(() {
                                                model.isThirdImageLoading =
                                                    true;
                                              });
                                            },
                                            loadingFinished: () {
                                              setState(() {
                                                model.isThirdImageLoading =
                                                    false;
                                              });
                                            },
                                            setDone: () {
                                              setState(() {
                                                model.isThirdImageUploadDone =
                                                    true;
                                              });
                                            });
                                  },
                                  child: model.isThirdImageLoading
                                      ? const CircularProgressIndicator()
                                      : Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.135,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.28,
                                          decoration: model
                                                  .isThirdImageUploadDone
                                              ? BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image:
                                                          CachedNetworkImageProvider(
                                                              thirdImagePath)))
                                              : BoxDecoration(
                                                  color: Colors.grey,
                                                  // image: DecorationImage(
                                                  //     fit: BoxFit.cover,
                                                  //     image: FileImage(
                                                  //       File(widget.selectedPhoto!.path),
                                                  //     )),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r)),
                                          child: Icon(Icons.add_circle,
                                              color: Colors.grey.shade600)),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                model.fourthImage = await showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return const ImageSelection();
                                        }) ??
                                    File("");

                                fourthImagePath = await model.uploadUserPhoto(
                                    image: model.fourthImage!,
                                    loadingStarted: () {
                                      setState(() {
                                        model.isFourthImageLoading = true;
                                      });
                                    },
                                    loadingFinished: () {
                                      setState(() {
                                        model.isFourthImageLoading = false;
                                      });
                                    },
                                    setDone: () {
                                      setState(() {
                                        model.isFourthImageUploadDone = true;
                                      });
                                    });
                              },
                              child: model.isFourthImageLoading
                                  ? const CircularProgressIndicator()
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.135,
                                      width: MediaQuery.of(context).size.width *
                                          0.28,
                                      decoration: model.isFourthImageUploadDone
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          fourthImagePath)))
                                          : BoxDecoration(
                                              color: Colors.grey,
                                              // image: DecorationImage(
                                              //     fit: BoxFit.cover,
                                              //     image: FileImage(
                                              //       File(widget.selectedPhoto!.path),
                                              //     )),
                                              borderRadius:
                                                  BorderRadius.circular(20.r)),
                                      child: Icon(Icons.add_circle,
                                          color: Colors.grey.shade600)),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            GestureDetector(
                              onTap: () async {
                                model.fifthImage = await showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return const ImageSelection();
                                        }) ??
                                    File("");

                                fifthImagePath = await model.uploadUserPhoto(
                                    image: model.fifthImage!,
                                    loadingStarted: () {
                                      setState(() {
                                        model.isFifthImageLoading = true;
                                      });
                                    },
                                    loadingFinished: () {
                                      setState(() {
                                        model.isFifthImageLoading = false;
                                      });
                                    },
                                    setDone: () {
                                      setState(() {
                                        model.isFifthImageUploadDone = true;
                                      });
                                    });
                              },
                              child: model.isFifthImageLoading
                                  ? const CircularProgressIndicator()
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.135,
                                      width: MediaQuery.of(context).size.width *
                                          0.28,
                                      decoration: model.isFifthImageUploadDone
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          fifthImagePath)))
                                          : BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(20.r)),
                                      child: Icon(Icons.add_circle,
                                          color: Colors.grey.shade600)),
                            ),
                            SizedBox(
                              width: 11.w,
                            ),
                            GestureDetector(
                              onTap: () async {
                                model.sixthImage = await showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return const ImageSelection();
                                        }) ??
                                    File("");

                                sixthImagePath = await model.uploadUserPhoto(
                                    image: model.sixthImage!,
                                    loadingStarted: () {
                                      setState(() {
                                        model.isSixthImageLoading = true;
                                      });
                                    },
                                    loadingFinished: () {
                                      setState(() {
                                        model.isSixthImageLoading = false;
                                      });
                                    },
                                    setDone: () {
                                      setState(() {
                                        model.isSixthImageUploadDone = true;
                                      });
                                    });
                              },
                              child: model.isSixthImageLoading
                                  ? const CircularProgressIndicator()
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.135,
                                      width: MediaQuery.of(context).size.width *
                                          0.28,
                                      decoration: model.isSixthImageUploadDone
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          sixthImagePath)))
                                          : BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(20.r)),
                                      child: Icon(Icons.add_circle,
                                          color: Colors.grey.shade600)),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    CustomButton(
                      height: 60.h,
                      borderRadius: BorderRadius.circular(10.r),
                      width: MediaQuery.of(context).size.width,
                      onPressed:
                          // model.isEditNameButtonActive
                          // ?
                          () {
                        getIt<AppRouter>().push(DateOfBirthRoute(
                            userType: widget.userType ?? "user",
                            selectedPhoto: widget.selectedPhoto,
                            usernname: widget.userName,
                            firstName: widget.fullname));
                        log("firstName :::: ${widget.fullname}");
                        log("username:::::${widget.userName}");
                      },
                      // : null,
                      child: Text("Next",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontFamily: Font.inter,
                              fontWeight: FontWeight.w400)),
                    ),
                    SizedBox(height: 20.h)
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
