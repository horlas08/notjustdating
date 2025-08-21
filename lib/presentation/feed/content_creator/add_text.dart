// import 'dart:developer';
import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/domain/auth/models/location_model.dart';
import 'package:ofwhich_v2/domain/user_service/model/user_object.dart';
import 'package:ofwhich_v2/presentation/feed/content_creator/model/post_visibility.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_button.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_textfield.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';
import 'package:stacked/stacked.dart';
// import 'package:video_player/video_player.dart';

import '../../../application/post_view_model/content_creator/post_view_model.dart';
import '../../../injectable.dart';
import '../../core/font.dart';
import '../../general_widgets/custom_drop_down.dart';
import '../../routes/app_router.gr.dart';

@RoutePage()
class UploadPostAddText extends StatefulWidget {
  const UploadPostAddText(
      {super.key, required this.selectedPhoto, required this.type});
  final File selectedPhoto;
  final String type;

  @override
  State<UploadPostAddText> createState() => _UploadPostAddTextState();
}

class _UploadPostAddTextState extends State<UploadPostAddText> {
  TextEditingController controller = TextEditingController();
  PostVisibility? selectedValue;
  LocationModel? location;
  UserModel? user;
  String videoThumbnail = "";

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostViewModel>.reactive(
        onViewModelReady: (h) async {
          h.getUserProfilePhoto();
          selectedValue = postVisibiltiList[0];
          videoThumbnail =
              (await h.getThumbnail(widget.selectedPhoto.path)) ?? "N/A";
        },
        viewModelBuilder: () => getIt<PostViewModel>(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Post",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300,
                      fontFamily: Font.rubik)),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          minRadius: 30.r,
                          backgroundImage: CachedNetworkImageProvider(
                              model.userPhotoUrl ?? ""),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: CustomTextFieldWidget(
                                contentPadding: EdgeInsets.zero,
                                controller: controller,
                                hintText: "Add a comment...",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFE7E7E7),
                                      borderRadius: BorderRadius.circular(5.r)),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0.w),
                                    child: Text("#Hashtags",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: const Color(0xFF656565),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: Font.rubik)),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFE7E7E7),
                                      borderRadius: BorderRadius.circular(5.r)),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0.w),
                                    child: Text("@Mention",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: const Color(0xFF656565),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: Font.rubik)),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                        child: ClipRRect(
                                      // decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: widget.type == "video"
                                          ? Image.file(File(videoThumbnail),
                                              fit: BoxFit.cover)
                                          : Image.file(widget.selectedPhoto,
                                              fit: BoxFit.cover),
                                    )),
                                    Positioned(
                                        right: 10.h,
                                        top: 10.h,
                                        child: Image.asset(
                                            "assets/images/pngs/cancel_square.png",
                                            scale: 1.2))
                                  ],
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              // height: MediaQuery.of(context).size.height * 0.1,
                              child: CustomDropdown(
                                child: DropdownButtonFormField<PostVisibility>(
                                  isExpanded: true,
                                  value: selectedValue,
                                  // dropdownColor: AltBankColor.dAltBkGrey450,
                                  borderRadius: BorderRadius.circular(6.r),
                                  hint: const Text('Post Visibility'),
                                  iconSize: 20,
                                  validator: (value) {
                                    if (value == null) {
                                      return "Selection required";
                                    }
                                    return null;
                                  },
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_sharp),
                                  // itemHeight: 300,
                                  elevation: 0,
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 15.sp),
                                  dropdownColor: Theme.of(context)
                                      .dropdownMenuTheme
                                      .inputDecorationTheme
                                      ?.fillColor,
                                  items: postVisibiltiList.map((value) {
                                    // if (value == dropDownValue) {
                                    return DropdownMenuItem<PostVisibility>(
                                      value: value,
                                      child: Row(
                                        children: [
                                          Image.asset(value.imgUrl, scale: 1.5),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(value.title,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.sp,
                                                  fontFamily: Font.rubik))
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedValue = newValue;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                        height: 20.h,
                        width: MediaQuery.of(context).size.width,
                        child: Divider(color: Colors.grey.withOpacity(0.3))),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 40.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await getIt<AppRouter>()
                                    .push(const TagUsers())
                                    .then((val) {
                                  setState(() {
                                    user =
                                        (val ?? UserModel(id: 1)) as UserModel?;
                                  });
                                });
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                      "assets/images/pngs/profile_icon.png",
                                      color: Colors.black,
                                      height: 25.h),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text("Tag people  ${user?.full_name ?? "N/A"}",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: Font.rubik))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            GestureDetector(
                              onTap: () async {
                                // setState(() async {
                                await getIt<AppRouter>()
                                    .push(const LocationAdd())
                                    .then((value) {
                                  setState(() {
                                    location = (value ??
                                            LocationModel(id: 3, name: ""))
                                        as LocationModel?;
                                  });
                                });

                                // });
                                // location!.copyWith(name: name);
                              },
                              child: Row(
                                children: [
                                  Image.asset("assets/images/pngs/location.png",
                                      color: Colors.black, height: 25.h),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text("Location - ${location?.name ?? "N/A"}",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: Font.rubik))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                    // Row(
                    //   children: [
                    //     CustomButton(
                    //       onPressed: () {},
                    //       height: 70.h,
                    //       bgColor: Theme.of(context).primaryColor,
                    //       width: MediaQuery.of(context).size.width * 0.45,
                    //       borderRadius: BorderRadius.circular(15.r),
                    //       child: Text(
                    //         "Next",
                    //         style: TextStyle(
                    //             fontSize: 16.sp,
                    //             fontWeight: FontWeight.w400,
                    //             fontFamily: Font.inter,
                    //             color: Colors.white),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 10.w,
                    //     ),
                    //     CustomButton(onPressed: () {}),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    onPressed: () {
                      List<String> taggedPeople = [];
                      if (user != null) {
                        String userId = user!.id.toString();
                        taggedPeople.add(userId);
                      }
                      model.uploadFile(
                          destination: "user-uploads",
                          file: widget.selectedPhoto,
                          locationId: location?.id.toString() ?? "",
                          comment: controller.text,
                          taggedPeople: taggedPeople,
                          type: "draft",
                          isPublic: selectedValue?.value ?? "");
                    },
                    height: 70.h,
                    bgColor: const Color(0xFFF6F6F6),
                    width: MediaQuery.of(context).size.width * 0.45,
                    borderRadius: BorderRadius.circular(8.r),
                    child: Text(
                      "Save to Draft",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: Font.inter,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  CustomButton(
                    onPressed: () {
                      List<String> taggedPeople = [];
                      if (user != null) {
                        String userId = user!.id.toString();
                        taggedPeople.add(userId);
                      }
                      model.uploadFile(
                          destination: "user-uploads",
                          file: widget.selectedPhoto,
                          locationId: location?.id.toString() ?? "",
                          comment: controller.text,
                          taggedPeople: taggedPeople,
                          isPublic: selectedValue?.value ?? "");
                    },
                    height: 70.h,
                    bgColor: Theme.of(context).primaryColor,
                    width: MediaQuery.of(context).size.width * 0.45,
                    borderRadius: BorderRadius.circular(8.r),
                    child: model.isBusy
                        ? const CircularProgressIndicator()
                        : Text(
                            "Post",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: Font.inter,
                                color: Colors.white),
                          ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
