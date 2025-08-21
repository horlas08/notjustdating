// ignore_for_file: prefer_const_constructors

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:ofwhich_v2/application/chat_view_model/chat_view_model.dart';
import 'package:ofwhich_v2/domain/user_service/model/user_object.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/general_widgets/app_back_button.dart';
// import 'package:ofwhich_v2/presentation/general_widgets/custom_button.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_textfield.dart';
import 'package:ofwhich_v2/presentation/home/user/constants/swipe_enum.dart';
import 'package:ofwhich_v2/presentation/home/user/widgets/app_image_widget.dart';
import 'package:provider/provider.dart';

// import 'package:stacked/stacked.dart';

import '../../../application/home_view_model/home_view_model.dart';
import '../../../application/profile/profile_view_model.dart';
import '../../core/font.dart';
import '../../core/title_case.dart';
import '../../general_widgets/report_modal.dart';
import '../../profile/model/circle_model.dart';
import '../../profile/user/choose_your_circle.dart';
import 'widgets/action_bbutton_widget.dart';
import 'widgets/cards_stack_widget.dart';

@RoutePage()
class SelectedProfileScreen extends StatefulWidget {
  const SelectedProfileScreen(
      {super.key,
      this.profile,
      required this.selectedProfileCallBack,
      required this.currentIndex,
      // required this.animationController,
      required this.swipeNotifier,
      required this.viewModel});
  final UserModel? profile;
  final int? currentIndex;
  final VoidCallback selectedProfileCallBack;
  final ValueNotifier<Swipe> swipeNotifier;
  // final AnimationController animationController;
  final HomeViewModel viewModel;

  @override
  State<SelectedProfileScreen> createState() => _SelectedProfileScreenState();
}

class _SelectedProfileScreenState extends State<SelectedProfileScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    // widget.selectedProfileCallBack.call();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final swipeAction = widget.swipeNotifier.value;

        if (swipeAction == Swipe.left) {
          // Handle left swipe logic
          debugPrint('Swiped Left: Dislike profile');
        } else if (swipeAction == Swipe.right) {
          // Handle right swipe logic
          debugPrint('Swiped Right: Like profile');
          widget.selectedProfileCallBack.call();
        }

        // Reset animation and notifier
        _animationController.reset();
        widget.swipeNotifier.value = Swipe.none;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      // viewModelBuilder: () => getIt<HomeViewModel>(),
      // onViewModelReady: (h) {},
      builder: (context, model, child) => Scaffold(
          body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: widget.swipeNotifier,
          builder: (context, swipe, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0.w,
                        right: 0.w,
                        bottom: 100.h,
                        top: -20.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50.r),
                              bottomRight: Radius.circular(50.r)),
                          child: Hero(
                              tag: "profile_photo",
                              child: AppImageWidget(
                                imageUrl: widget.profile?.photo ?? "",
                              )),
                        ),
                      ),
                      Positioned(top: 40.h, left: 10.w, child: AppBackButton()),
                      Positioned(
                        bottom: -5.h,
                        left: 10.w,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 46.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ActionButtonWidget(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // getIt<AppRouter>().pop();
                                    // widget.swipeNotifier.value = Swipe.left;
                                    // _animationController
                                    //     .forward(); // Start animation on left swipe
                                  },
                                  icon: Image.asset(
                                      "assets/images/pngs/dislike.png")),
                              const SizedBox(width: 20),
                              ActionButtonWidget(
                                containerHeight: 100.h,
                                backgroundColor: const Color(0xFFEC5873),
                                onPressed: () {
                                  // getIt<AppRouter>().pop();
                                  model.likeProfile(user: widget.profile);
                                  // getIt<AppRouter>().pop();
                                  Navigator.pop(context);
                                  // widget.swipeNotifier.value = Swipe.right;
                                  // _animationController
                                  //     .forward(); // Start animation on right swipe
                                },
                                icon: Transform.scale(
                                    scale: 1.1,
                                    child: Image.asset(
                                        "assets/images/pngs/heart.png")),
                              ),
                              const SizedBox(width: 20),
                              ActionButtonWidget(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return FlowerBottomSheet(
                                              viewModel: model,
                                              currentIndex:
                                                  widget.currentIndex!);
                                        });
                                  },
                                  icon: Image.asset(
                                      "assets/images/pngs/sparkle.png")),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Text.rich(TextSpan(
                        text: widget.profile?.full_name ?? "N/A",
                        style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: Font.inter),
                        children: [
                          widget.profile != null && widget.profile!.dob != null
                              ? TextSpan(
                                  text:
                                      "  ${getIt<ProfileViewModel>().calculateUserAge(date: widget.profile?.dob ?? "")}",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: Font.inter),
                                )
                              : TextSpan(
                                  text: "N/A",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: Font.inter))
                        ])),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                        ),
                        Text(
                          "Lagos ",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: Font.inter),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      "About Me",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: Font.inter),
                    ),
                    Text(
                      widget.profile?.bio ?? "",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: Font.inter),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      "Interests",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: Font.inter),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    widget.profile == null
                        ? Container()
                        : MultiSelectChip(
                            interests: widget.profile!.interests!
                                .map((e) => CircleModel(title: e))
                                .toList(),
                          ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      "Langauges I know",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: Font.inter),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30.r),
                          color: const Color.fromRGBO(236, 88, 115, 0.09)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0.w, vertical: 10.w),
                        child: Container(
                          // width: 120.w,
                          constraints:
                              BoxConstraints(maxWidth: 130.w, minWidth: 35.w),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Image.asset("assets/images/pngs/language_icon.png"),
                            SizedBox(
                              width: 6.w,
                            ),
                            Text('English',
                                style: TextStyle(
                                    fontFamily: Font.rubik,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400)),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      "Basic Information",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: Font.inter),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Table(
                      border: TableBorder.all(color: const Color(0xFFE1E1E1)),
                      children: [
                        TableRow(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0.w, vertical: 10.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Height",
                                          style: TextStyle(
                                              color: const Color(0xFF868686),
                                              fontSize: 12.sp,
                                              fontFamily: Font.inter,
                                              fontWeight: FontWeight.w400)),
                                      Text(
                                          "${widget.profile?.height ?? "N/A"} cm",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: Font.inter,
                                              color: Color(0XFF454545))),
                                    ],
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0.w, vertical: 10.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Location",
                                          style: TextStyle(
                                              color: const Color(0xFF868686),
                                              fontSize: 12.sp,
                                              fontFamily: Font.inter,
                                              fontWeight: FontWeight.w400)),
                                      Text("N/A",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: Font.inter,
                                              color: Color(0XFF454545))),
                                    ],
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0.w, vertical: 10.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Degree",
                                          style: TextStyle(
                                              color: const Color(0xFF868686),
                                              fontSize: 12.sp,
                                              fontFamily: Font.inter,
                                              fontWeight: FontWeight.w400)),
                                      Text(
                                          widget.profile?.education_level ??
                                              "N/A",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: Font.inter,
                                              color: Color(0XFF454545))),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                        TableRow(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0.w, vertical: 10.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Religion",
                                          style: TextStyle(
                                              color: const Color(0xFF868686),
                                              fontSize: 12.sp,
                                              fontFamily: Font.inter,
                                              fontWeight: FontWeight.w400)),
                                      Text(widget.profile?.religion ?? "N/A",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: Font.inter,
                                              color: const Color(0XFF454545))),
                                    ],
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0.w, vertical: 10.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Job",
                                          style: TextStyle(
                                              color: const Color(0xFF868686),
                                              fontSize: 12.sp,
                                              fontFamily: Font.inter,
                                              fontWeight: FontWeight.w400)),
                                      Text(widget.profile?.job_title ?? "N/A",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: Font.inter,
                                              color: Color(0XFF454545))),
                                    ],
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0.w, vertical: 10.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Sexual Orientation",
                                          style: TextStyle(
                                              color: const Color(0xFF868686),
                                              fontSize: 12.sp,
                                              fontFamily: Font.inter,
                                              fontWeight: FontWeight.w400)),
                                      Text(
                                          widget.profile?.sexual_orientation ??
                                              "N/A",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: Font.inter,
                                              color: Color(0XFF454545))),
                                    ],
                                  ),
                                ),
                              ),
                            ])
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text("Verification",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: Font.inter)),
                    SizedBox(height: 10.h),
                    Container(
                      height: 70.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: const Color(0xFFEC5873),
                          borderRadius: BorderRadius.circular(20.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    "assets/images/svgs/shield.svg"),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text("Verification Incomplete",
                                    style: TextStyle(
                                        fontFamily: Font.inter,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // widget.profile != null && widget.profile?.pictures != null
                    //     ? Column(
                    //         children: [
                    //           Text("My Gallery",
                    //               style: TextStyle(
                    //                   fontSize: 16.sp,
                    //                   fontWeight: FontWeight.w600,
                    //                   color: Colors.black,
                    //                   fontFamily: Font.inter)),
                    //           SizedBox(height: 10.h),
                    //           Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Container(
                    //                     height:
                    //                         MediaQuery.of(context).size.height *
                    //                             0.5,
                    //                     width: MediaQuery.of(context).size.width *
                    //                         0.55,
                    //                     decoration: BoxDecoration(
                    //                         borderRadius:
                    //                             BorderRadius.circular(20.r),
                    //                         image: DecorationImage(
                    //                             fit: BoxFit.cover,
                    //                             image: widget.profile!.pictures!
                    //                                         .length >
                    //                                     1
                    //                                 ? CachedNetworkImageProvider(
                    //                                     widget
                    //                                             .profile
                    //                                             ?.pictures![0]
                    //                                             .file_url ??
                    //                                         "")
                    //                                 : AssetImage(
                    //                                         "assets/images/pngs/secondImage.png")
                    //                                     as ImageProvider))),
                    //                 Column(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceBetween,
                    //                   children: [
                    //                     Container(
                    //                         height: MediaQuery.of(context)
                    //                                 .size
                    //                                 .height *
                    //                             0.24,
                    //                         width:
                    //                             MediaQuery.of(context).size.width *
                    //                                 0.33,
                    //                         decoration: BoxDecoration(
                    //                             borderRadius:
                    //                                 BorderRadius.circular(20.r),
                    //                             image: DecorationImage(
                    //                                 fit: BoxFit.cover,
                    //                                 image: widget
                    //                                             .profile!
                    //                                             .pictures!
                    //                                             .length >
                    //                                         2
                    //                                     ? CachedNetworkImageProvider(widget
                    //                                             .profile
                    //                                             ?.pictures![1]
                    //                                             .file_url ??
                    //                                         "")
                    //                                     : AssetImage("assets/images/pngs/secondImage.png")
                    //                                         as ImageProvider))),
                    //                     SizedBox(
                    //                       height: 10.h,
                    //                     ),
                    //                     Container(
                    //                         height: MediaQuery.of(context).size.height *
                    //                             0.24,
                    //                         width: MediaQuery.of(context).size.width *
                    //                             0.33,
                    //                         decoration: BoxDecoration(
                    //                             borderRadius:
                    //                                 BorderRadius.circular(20.r),
                    //                             image: DecorationImage(
                    //                                 fit: BoxFit.cover,
                    //                                 image: widget.profile!.pictures!.length > 3
                    //                                     ? CachedNetworkImageProvider(widget
                    //                                             .profile
                    //                                             ?.pictures![2]
                    //                                             .file_url ??
                    //                                         "")
                    //                                     : AssetImage("assets/images/pngs/secondImage.png")
                    //                                         as ImageProvider)),
                    //                         child: Container(
                    //                             alignment: Alignment.center,
                    //                             color: Colors.transparent
                    //                                 .withOpacity(0.7),
                    //                             child: Text("More photos", style: TextStyle(fontSize: 15.sp, color: Colors.white, fontFamily: Font.inter))))
                    //                   ],
                    //                 )
                    //               ])
                    //         ],
                    //       )
                    //     : Container(),

                    widget.profile != null && widget.profile?.pictures != null
                        ? Builder(
                            builder: (context) {
                              final pictures = widget.profile?.pictures ?? [];
                              imageUrl(int index) => pictures.length > index
                                  ? pictures[index].file_url
                                  : null;

                              if (pictures.isEmpty) {
                                // No images
                                return Container();
                              } else if (pictures.length == 1) {
                                // One image
                                return Column(
                                  children: [
                                    Text("My Gallery",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontFamily: Font.inter)),
                                    SizedBox(height: 10.h),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(
                                              imageUrl(0) ?? ""),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (pictures.length == 2) {
                                // Two images
                                return Column(
                                  children: [
                                    Text("My Gallery",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontFamily: Font.inter)),
                                    SizedBox(height: 10.h),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    CachedNetworkImageProvider(
                                                        imageUrl(0) ?? ""),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    CachedNetworkImageProvider(
                                                        imageUrl(1) ?? ""),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                // Three or more images
                                return Column(
                                  children: [
                                    Text("My Gallery",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontFamily: Font.inter)),
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.55,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                  imageUrl(0) ?? ""),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.24,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.33,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          imageUrl(1) ?? ""),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.24,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.33,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          imageUrl(2) ?? ""),
                                                ),
                                              ),
                                            ),
                                            if (pictures.length > 3)
                                              Container(
                                                alignment: Alignment.center,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.24,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.33,
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                child: Text(
                                                  "More photos",
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: Colors.white,
                                                    fontFamily: Font.inter,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                            },
                          )
                        : Container(),

                    SizedBox(
                      height: 20.h,
                    ),
                    Text("Complement*",
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                            fontFamily: Font.inter)),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextFieldWidget(
                      hintText: "Write a complement",
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        showBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            builder: (
                              context,
                            ) {
                              return ReportModal(
                                userId: widget.profile?.id.toString() ?? "0",
                              );
                            });
                      },
                      child: Center(
                          child: Text(
                              "Report ${widget.profile?.full_name?.capitalizeFirstText() ?? 'N/A'} ",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red))),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  // Widget _buildChips() {
  //   List<Widget> chips = [];
  //   // List<String> selectedChoices = [];
  //   for (int i = 0; i < interests.length - 6; i++) {
  //     CircleModel interest = interests[i];
  //     GestureDetector choiceChip = GestureDetector(
  //       onTap: () {
  //         // setState(() {
  //         //   selectedIndex = i;
  //         // });
  //         // log(i.toString());
  //       },
  //       child: Container(
  //         decoration: BoxDecoration(
  //             border: Border.all(color: Colors.grey),
  //             borderRadius: BorderRadius.circular(30.r),
  //             color: const Color.fromRGBO(236, 88, 115, 0.09)),
  //         child: Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 10.w),
  //           child: Container(
  //             // width: 120.w,
  //             constraints: BoxConstraints(maxWidth: 160.w, minWidth: 50.w),
  //             child: Row(mainAxisSize: MainAxisSize.min, children: [
  //               Image.asset(interest.imgUrl ?? ""),
  //               SizedBox(
  //                 width: 6.w,
  //               ),
  //               Text(interest.title ?? '',
  //                   style: TextStyle(
  //                       fontFamily: Font.rubik,
  //                       fontSize: 16.sp,
  //                       fontWeight: FontWeight.w400)),
  //             ]),
  //           ),
  //         ),
  //       ),
  //     );

  //     chips.add(choiceChip);
  //   }
  //   return SizedBox(
  //     width: MediaQuery.of(context).size.width,
  //     child: Wrap(
  //       runSpacing: 10.0.w,
  //       spacing: 5.w,

  //       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: chips,
  //     ),
  //   );
  // }
}
