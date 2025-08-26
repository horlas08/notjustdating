// import 'package:flutter/foundation.dart';
// import 'dart:developer';
// import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_appbar.dart';
import 'package:ofwhich_v2/presentation/home/user/matched_profile.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
import 'package:ofwhich_v2/presentation/user_profile/widgets/multiple_chips.dart';
import 'package:ofwhich_v2/presentation/utils/util.dart';
import 'package:provider/provider.dart';

import '../../../application/profile/profile_view_model.dart';
import '../../../injectable.dart';
import '../../core/font.dart';
// import '../general_widgets/custom_button.dart';
import '../../general_widgets/custom_textfield.dart';
import '../../general_widgets/refresh_widget.dart';
import '../../profile/model/circle_model.dart';
import '../../routes/app_router.dart';

// import 'package:flutter/widgets.dart';
@RoutePage()
class UserProfileDetails extends StatefulWidget {
  const UserProfileDetails({super.key});

  @override
  State<UserProfileDetails> createState() => _UserProfileDetailsState();
}

class _UserProfileDetailsState extends State<UserProfileDetails> {
  TextEditingController abboutMe = TextEditingController();
  TextEditingController interests = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
// Widget
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    getIt<ProfileViewModel>().getUserProfile().then((_) {
      abboutMe.text = getIt<ProfileViewModel>().user?.bio ?? "";
    });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // onViewModelReady: (h) {
      //   h.getUserProfile();
      //   abboutMe.text = h.user?.bio ?? "";
      //   // log(h.user?.photo ?? "Emptyyyyyyyy");
      // },
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Color.fromRGBO(245, 245, 245,1),
        appBar: const OfWhichAppBar(
          titleText: "Your Profile",
        ),
        body: RefreshWidget(
          onRefresh: () async {
            model.getUserProfile();
          },
          child: model.isBusy ?
          const Center(child: CircularProgressIndicator(),)
            :SingleChildScrollView(
            
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: model.isBusy
                  && model.user == null ||
                          model.user?.full_name == null ||
                          model.user?.dob == null ||
                          model.user?.photo == null
                      ? Center(
                          child: Text(
                              "Unable to display user details, please contact support",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontFamily: Font.inter)),
                        )
                      : Column(
                    
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20.h),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        model.user?.photo == ""
                                            ? Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    // image: DecorationImage(
                                                    //     fit: BoxFit.cover,
                                                    //     image: FileImage(
                                                    //       File(widget.selectedPhoto!.path),
                                                    //     )),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r)),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.35,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                child: Icon(Icons.add_circle,
                                                    color:
                                                        Colors.grey.shade600))
                                            : Stack(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: CachedNetworkImageProvider(
                                                                model.user
                                                                        ?.photo ??
                                                                    "")),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.r)),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.35,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                  ),
                                                  Positioned(
                                                      top: 10.h,
                                                      left: 10.h,
                                                      child: Container(
                                                        height: 40.h,
                                                        width: 60.w,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .transparent
                                                                .withOpacity(
                                                                    0.4),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.r)),
                                                        child: Text("Main",
                                                            style: TextStyle(
                                                                fontSize: 12.sp,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                      )),
                                                  Positioned(
                                                      left: 40.w,
                                                      right: 40.w,
                                                      bottom: 10.h,
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          model.firstImage =
                                                              await showModalBottomSheet(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return const ImageSelection();
                                                                      }) ??
                                                                  File("");
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.r),
                                                          child: SizedBox(
                                                            // color: Colors.transparent
                                                            //     .withOpacity(0.2),
                                                            height: 60.h,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.06,
                                                            child:
                                                                BackdropFilter(
                                                              filter:
                                                                  ImageFilter
                                                                      .blur(
                                                                sigmaX: 5.0,
                                                                sigmaY: 10.0,
                                                              ),
                                                              // child: getLoginContainer(),

                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            15.0.w),
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                              "assets/images/svgs/camera.svg"),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Text(
                                                                          'Change Photo',
                                                                          style: TextStyle(
                                                                              fontSize: 14.sp,
                                                                              fontFamily: Font.inter,
                                                                              color: Colors.white)),
                                                                    ]),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ))
                                                ],
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
                                                setState(() {
                                                  model.isSecondImageSelected =
                                                      true;
                                                });
                                              },
                                              child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.17,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.28,
                                                  decoration: model.user != null &&
                                                          model.user!.pictures !=
                                                              null
                                                      ? BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10.r),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: CachedNetworkImageProvider(model.user!.pictures![0].file_url ?? "")))
                                                      : const BoxDecoration(),
                                                  child: model.isSecondImageSelected ? null : Icon(Icons.add_circle, color: Colors.grey.shade600)),
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
                                                setState(() {
                                                  model.isThirdImageSelected =
                                                      true;
                                                });
                                              },
                                              child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.17,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.28,
                                                  decoration: model.user != null &&
                                                          model.user!.pictures !=
                                                              null &&
                                                          model.user!.pictures!
                                                              .isNotEmpty &&
                                                          model.user!.pictures!
                                                                  .length >
                                                              1
                                                      ? BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(10.r),
                                                          image: DecorationImage(fit: BoxFit.cover, image: CachedNetworkImageProvider(model.user!.pictures![1].file_url ?? "")))
                                                      : const BoxDecoration(),
                                                  child: model.isThirdImageSelected ? null : Icon(Icons.add_circle, color: Colors.grey.shade600)),
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
                                            model.fourthImage =
                                                await showModalBottomSheet(
                                                        context: context,
                                                        builder: (context) {
                                                          return const ImageSelection();
                                                        }) ??
                                                    File("");
                                            setState(() {
                                              model.isFourthImageSelected =
                                                  true;
                                            });
                                          },
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.17,
                                              width: MediaQuery.of(context).size.width *
                                                  0.28,
                                              decoration: model.user != null &&
                                                      model.user!.pictures !=
                                                          null &&
                                                      model.user!.pictures!.length >
                                                          2
                                                  ? BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: CachedNetworkImageProvider(model.user!.pictures![2].file_url ?? "")))
                                                  : const BoxDecoration(),
                                              child: model.isFourthImageSelected ? null : Icon(Icons.add_circle, color: Colors.grey.shade600)),
                                        ),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            model.fifthImage =
                                                await showModalBottomSheet(
                                                        context: context,
                                                        builder: (context) {
                                                          return const ImageSelection();
                                                        }) ??
                                                    File("");
                                            setState(() {
                                              model.isFifthImageSelected = true;
                                            });
                                          },
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.17,
                                              width: MediaQuery.of(context).size.width *
                                                  0.28,
                                              decoration: model.user != null &&
                                                      model.user!.pictures !=
                                                          null &&
                                                      model.user!.pictures!.length >
                                                          3
                                                  ? BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: CachedNetworkImageProvider(model.user!.pictures![3].file_url ?? "")))
                                                  : const BoxDecoration(),
                                              child: model.isFifthImageSelected ? null : Icon(Icons.add_circle, color: Colors.grey.shade600)),
                                        ),
                                        SizedBox(
                                          width: 11.w,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            model.sixthImage =
                                                await showModalBottomSheet(
                                                        context: context,
                                                        builder: (context) {
                                                          return const ImageSelection();
                                                        }) ??
                                                    File("");
                                            setState(() {
                                              model.isSixthImageSelected = true;
                                            });
                                          },
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.17,
                                              width: MediaQuery.of(context).size.width *
                                                  0.28,
                                              decoration: model.user != null &&
                                                      model.user!.pictures !=
                                                          null &&
                                                      model.user!.pictures!.length >
                                                          4
                                                  ? BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: CachedNetworkImageProvider(model.user!.pictures![4].file_url ?? "")))
                                                  : const BoxDecoration(),
                                              child: model.isSixthImageSelected ? null : Icon(Icons.add_circle, color: Colors.grey.shade600)),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            dividerGap(),
                                Text("About Me",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontFamily: Font.inter)),
                            SizedBox(height: 10.h),
                            FocusScope(
                              onFocusChange: (val) {
                                if (!val && abboutMe.text.isNotEmpty) {
                                  model.editProfile(
                                      bio: abboutMe.text,
                                      navigate: () {
                                        // getIt<AppRouter>().pushAndPopUntil(
                                        //     predicate: (_) => false,
                                        //     const UserProfileDetails());
                                      });
                                }
                              },
                              child: CustomTextFieldWidget(
                                macLines: null,
                                focusNode: focusNode,
                                controller: abboutMe,
                                border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide:  BorderSide(color:Colors.grey.shade300 )),
                                onSubmitted: (val) {
                                  model.editProfile(
                                      bio: abboutMe.text,
                                      navigate: () {
                                        // getIt<AppRouter>().pushAndPopUntil(
                                        //     predicate: (_) => false,
                                        //     const UserProfileDetails());
                                      });
                                },
                                contentPadding: EdgeInsets.all(20.w),
                              ),
                            ),
                             SizedBox(
                              height: 25.h,
                            ),
                                Text("Things to know about me",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontFamily: Font.inter)),
                                     SizedBox(
                              height: 5.h,
                            ),
                                Text("List things to know about you and separate with comma",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(67, 67, 67, 1),
                                    fontFamily: Font.inter)),
                                    SizedBox(height: 10.h),
                            FocusScope(
                              onFocusChange: (val) {
                                if (!val && interests.text.isNotEmpty) {
                                  model.editProfile(
                                      bio: interests.text,
                                      navigate: () {
                                        // getIt<AppRouter>().pushAndPopUntil(
                                        //     predicate: (_) => false,
                                        //     const UserProfileDetails());
                                      });
                                }
                              },
                              child: CustomTextFieldWidget(
                                macLines: null,
                                focusNode: focusNode,
                                controller: interests,
                                border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide:  BorderSide(color:Colors.grey.shade300 )),
                                onSubmitted: (val) {
                                  model.editProfile(
                                      bio: interests.text,
                                      navigate: () {
                                        // getIt<AppRouter>().pushAndPopUntil(
                                        //     predicate: (_) => false,
                                        //     const UserProfileDetails());
                                      });
                                },
                                contentPadding: EdgeInsets.all(20.w),
                              ),
                            ),
                            dividerGap(),
                            // Text("Verification",
                            //     style: TextStyle(
                            //         fontSize: 16.sp,
                            //         fontWeight: FontWeight.w600,
                            //         color: Colors.black,
                            //         fontFamily: Font.inter)),
                            // SizedBox(height: 10.h),
                            // Container(
                            //   height: 70.h,
                            //   width: MediaQuery.of(context).size.width,
                            //   decoration: BoxDecoration(
                            //       color: const Color(0xFFEC5873),
                            //       borderRadius: BorderRadius.circular(20.r)),
                            //   child: Padding(
                            //     padding:
                            //         EdgeInsets.symmetric(horizontal: 15.0.w),
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Row(
                            //           children: [
                            //             SvgPicture.asset(
                            //                 "assets/images/svgs/shield.svg"),
                            //             SizedBox(
                            //               width: 10.w,
                            //             ),
                            //             Text("Verification Incomplete",
                            //                 style: TextStyle(
                            //                     fontFamily: Font.inter,
                            //                     fontSize: 16.sp,
                            //                     fontWeight: FontWeight.w400,
                            //                     color: Colors.white))
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          //  SizedBox(height: 20.h),
                            InkWell(
                              onTap: () {
                                getIt<AppRouter>().push(const EditInterest());
                              },
                              child: Text("My hobbies & interests",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontFamily: Font.inter)),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                                "Tell other what you’re into. Ths will help you find people with similar interest",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: Font.inter)),
                            SizedBox(height: 10.h),
                            model.user == null
                                ? Container()
                                : MultiSelectChip(
                                    interests: model.user!.interests!
                                        .map((e) => CircleModel(title: e))
                                        .toList(),
                                  ),
                          //  SizedBox(height: 20.h),
                        
                            // SizedBox(height: 20.h),
                            // Text("Relationship Status",
                            //     style: TextStyle(
                            //         fontSize: 16.sp,
                            //         fontWeight: FontWeight.w600,
                            //         color: Colors.black,
                            //         fontFamily: Font.inter)),
                            // SizedBox(height: 10.h),
                            // UserProfileTile(
                            //   title: model.user?.relationship_status ?? "",
                            //   imgUrl: "assets/images/svgs/heart_svg.svg",
                            // ),
                           // SizedBox(height: 20.h),
                           dividerGap(),
                            Text("My basics",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontFamily: Font.inter)),
                            SizedBox(height: 5.h),
                            Text("Specify general information about yourself",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF434343),
                                    fontFamily: Font.inter)),
                            SizedBox(height: 10.h),
                            UserProfileTile(
                              title: "Name",
                              imgUrl: "assets/images/svgs/person_svg.svg",
                              subTitle: model.user?.full_name ?? "",
                              onTap: () {
                                getIt<AppRouter>().push(const EditUserName());
                              },
                            ),
                            SizedBox(height: 10.h),
                            UserProfileTile(
                                title: "Age",
                                imgUrl: "assets/images/svgs/birthday_svg.svg",
                                subTitle: model
                                    .calculateUserAge(
                                        date: model.user?.dob ?? "")
                                    .toString(),
                                onTap: () {
                                  getIt<AppRouter>()
                                      .push(const EditUserAgeRoute());
                                }),
                            SizedBox(height: 10.h),
                            UserProfileTile(
                                title: "Gender",
                                imgUrl: "assets/images/svgs/gender_svg.svg",
                                subTitle: model.user?.gender ?? "",
                                onTap: () {
                                  getIt<AppRouter>().push(EditUserGender());
                                }),
                           
                            dividerGap(),
                            Text("Location & Language",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontFamily: Font.inter)),
                            SizedBox(height: 10.h),
                             const UserProfileTile(
                              title: "Location",
                              imgUrl: "assets/images/svgs/location_svg.svg",
                              subTitle: "",
                            ),
                           SizedBox(height: 10.h),
                            const UserProfileTile(
                              title: "English",
                              showIcon: false,
                              imgUrl: "assets/images/svgs/location_svg.svg",
                              subTitle: "",
                            ),
                            
                             dividerGap(),
                            Text("School and Work",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontFamily: Font.inter)),
                            SizedBox(height: 10.h),
                             // SizedBox(height: 10.h),
                            UserProfileTile(
                                title: "Job",
                                imgUrl: "assets/images/svgs/work_svg.svg",
                                subTitle: model.user?.job_title ?? "",
                                onTap: () {
                                  getIt<AppRouter>().push(const EditWork());
                                }),
                                 SizedBox(height: 10.h),
                            UserProfileTile(
                                title: "Studied",
                                imgUrl: "assets/images/svgs/work_svg.svg",
                                subTitle:  "",
                                onTap: () {
                                  getIt<AppRouter>().push(const EditWork());
                                }),
                                dividerGap(),
                            Text("Basic Information",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontFamily: Font.inter)),
                            // SizedBox(height: 5.h),
                            // Text(
                            //     " Specify more information about yourself to find suitable partners",
                            //     style: TextStyle(
                            //         fontSize: 12.sp,
                            //         fontWeight: FontWeight.w400,
                            //         color: const Color(0xFF434343),
                            //         fontFamily: Font.inter)),
                            SizedBox(height: 10.h),
                            UserProfileTile(
                                title: "Height",
                                showIcon: true,
                                imgUrl: "assets/images/svgs/height_svg.svg",
                                subTitle: model.user?.height == null
                                    ? "Edit"
                                    : "${model.user?.height} cm",
                                onTap: () {
                                  getIt<AppRouter>().push(const EditHeight());
                                }),
                            SizedBox(height: 10.h),
                            UserProfileTile(
                                title: "Weight",
                                showIcon: true,
                                imgUrl: "assets/images/svgs/weight_svg.svg",
                                subTitle: model.user?.weight == null
                                    ? "Edit"
                                    : "${model.user?.weight} kg",
                                onTap: () {
                                  getIt<AppRouter>().push(const EditWeight());
                                }),
                                 SizedBox(height: 10.h),
                            UserProfileTile(
                                title: "Body Type",
                                showIcon: true,
                                imgUrl: "assets/images/svgs/education.svg",
                                subTitle: "Edit",
                                onTap: () {
                                 
                                }),
                                  SizedBox(height: 10.h),
                                UserProfileTile(
                                title: "Signs",
                                showIcon: true,
                                imgUrl: "assets/images/svgs/education.svg",
                                subTitle: "Edit",
                                onTap: () {
                                 
                                }),
                                SizedBox(height: 10.h),
                            UserProfileTile(
                                title: "Smoking",
                                showIcon: true,
                                imgUrl: "assets/images/svgs/smoking.svg",
                                subTitle: model.user?.smokes ?? "Edit",
                                onTap: () {
                                  getIt<AppRouter>().push(const EditSmoking());
                                }),
                                   SizedBox(height: 10.h),
                            UserProfileTile(
                                title: "Alcohol",
                                showIcon: true,
                                imgUrl: "assets/images/svgs/drinks.svg",
                                subTitle: model.user?.drinks ?? "Edit",
                                onTap: () {
                                  getIt<AppRouter>().push(const EditDrinking());
                                }),
                                
                           
                            // SizedBox(height: 10.h),
                            // UserProfileTile(
                            //     title: "Exercise",
                            //     showIcon: true,
                            //     imgUrl: "assets/images/svgs/exercise_svg.svg",
                            //     subTitle: model.user?.exercise ?? "Edit",
                            //     onTap: () {
                            //       getIt<AppRouter>().push(const EditExercise());
                            //     }),
                            SizedBox(height: 10.h),
                            UserProfileTile(
                                title: "Education",
                                showIcon: true,
                                imgUrl: "assets/images/svgs/education.svg",
                                subTitle: model.user?.education_level ?? "Edit",
                                onTap: () {
                                  getIt<AppRouter>()
                                      .push(const EditEducation());
                                }),
                            SizedBox(height: 10.h),
                            UserProfileTile(
                                title: "Hobbies",
                                showIcon: true,
                                imgUrl: "assets/images/svgs/kids.svg",
                                subTitle: model.user!.interests?.first.toString() ??
                                    "Edit",
                                onTap: () {
                                  getIt<AppRouter>().push(const EditNoOfKids());
                                }),
                             SizedBox(height: 10.h),
                            UserProfileTile(
                                title: "Sexual orientation",
                                showIcon: true,
                                imgUrl:
                                    "assets/images/svgs/sexual_orientation.svg",
                                subTitle:
                                    model.user?.sexual_orientation ?? "Edit",
                                onTap: () {
                                  getIt<AppRouter>()
                                      .push(const EditSexualOrientation());
                                }),
                         
                            
                            // SizedBox(height: 10.h),
                            // UserProfileTile(
                            //     title: "Pets",
                            //     showIcon: true,
                            //     imgUrl: "assets/images/svgs/pets.svg",
                            //     subTitle: model.user?.pets ?? "Edit",
                            //     onTap: () {
                            //       getIt<AppRouter>().push(const EditPets());
                            //     }),
                            SizedBox(height: 10.h),
                            UserProfileTile(
                                title: "Religion",
                                showIcon: true,
                                imgUrl: "assets/images/svgs/religion.svg",
                                subTitle: model.user?.religion ?? "Edit",
                                onTap: () {
                                  getIt<AppRouter>().push(const EditReligion());
                                }),
                            // SizedBox(height: 10.h),
                            // UserProfileTile(
                            //     title: "Value",
                            //     showIcon: true,
                            //     imgUrl: "assets/images/svgs/values.svg",
                            //     subTitle: model.user?.value ?? "Edit",
                            //     onTap: () {
                            //       getIt<AppRouter>().push(const EditValue());
                            //     }),
                            SizedBox(height: 60.h),
                          ],
                        ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserProfileTile extends StatelessWidget {
  const UserProfileTile(
      {super.key,
      this.imgUrl,
      this.title,
      this.subTitle,
      this.onTap,
      this.showIcon = true});
  final String? imgUrl;
  final String? title;
  final String? subTitle;
  final bool showIcon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
          height: 59.h,
          decoration: BoxDecoration(
            color: Colors.white,
              border: Border.all(color: Color.fromRGBO(231, 231, 231, 1)),
              borderRadius: BorderRadius.circular(15.r)),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    showIcon ? SvgPicture.asset(imgUrl ?? "") : Container(),
                    SizedBox(width: 3.w),
                    Text(title ?? "",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: Font.inter,
                            color:  Colors.black,
                            fontWeight: FontWeight.w400))
                  ],
                ),
                Row(
                  children: [
                    Text(subTitle ?? "",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: Font.inter,
                            color: Colors.black,
                            fontWeight: FontWeight.w400)),
                    SizedBox(width: 3.w),
                    SvgPicture.asset("assets/images/svgs/arrow_right.svg"),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
