import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../injectable.dart';
import '../../core/font.dart';
import '../../general_widgets/custom_appbar.dart';
import '../../general_widgets/custom_button.dart';
import '../../general_widgets/custom_widgets.dart';
import '../../routes/app_router.dart';
import '../../routes/app_router.gr.dart';
import '../model/gender_model.dart';

@RoutePage()
class GenderScreen extends StatefulWidget {
  const GenderScreen(
      {super.key,
      this.selectedPhoto,
      this.firstName,
      this.dob,
      this.userType,
      this.username});
  final File? selectedPhoto;
  final String? firstName;
  final String? username;
  final String? dob;
  final String? userType;

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  int currentIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          titleText: "Personal Information",
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text("What is your gender?",
                      style: TextStyle(
                          fontFamily: Font.inter,
                          fontSize: 26.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text("It’ll help to find people for you",
                      style: TextStyle(
                          fontFamily: Font.inter,
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)),
                  SizedBox(height: 35.h),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: genders.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        GenderModel gender = genders[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          child: GenderWidget(
                              isSelected: currentIndex == index,
                              showDivider: index == 2 ? false : true,
                              gender: gender),
                        );
                      }),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomButton(
                    height: 60.h,
                    borderRadius: BorderRadius.circular(15.r),
                    width: MediaQuery.of(context).size.width,
                    onPressed: currentIndex == -1
                        ? null
                        :
                        // model.isEditNameButtonActive
                        // ?
                        () {
                            getIt<AppRouter>().push(RelationShipStatusRoute(
                                selectedPhoto: widget.selectedPhoto,
                                userType: widget.userType,
                                firstName: widget.firstName,
                                usernname: widget.username,
                                dob: widget.dob,
                                gender: genders[currentIndex].value));
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
              // Column(
              //   children: [],
              // ),
            ],
          ),
        ));
  }
}

class GenderWidget extends StatelessWidget {
  const GenderWidget(
      {super.key,
      required this.gender,
      this.isSelected = false,
      this.showDivider = true});

  final GenderModel gender;
  final bool isSelected;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(gender.title,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
              isSelected
                  ? Image.asset("assets/images/pngs/selection_circle.png",
                      scale: 0.9)
                  : Container(
                      height: 25.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE3E3E3)),
                          shape: BoxShape.circle),
                    ),
              // SizedBox(
              //   width: 5.w,
              // ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          showDivider
              ? Divider(
                  color: Colors.grey.shade400,
                )
              : Container()
        ],
      ),
    );
  }
}
