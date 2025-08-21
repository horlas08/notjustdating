import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../application/profile/profile_view_model.dart';
import '../../core/font.dart';
import '../../general_widgets/custom_appbar.dart';
import '../../general_widgets/custom_button.dart';
import '../model/gender_model.dart';

@RoutePage()
class ContentCreatorGender extends StatefulWidget {
  const ContentCreatorGender(
      {super.key,
      this.userType,
      this.firstName,
      this.username,
      this.selectedPhoto,
      this.dob});
  final String? userType;
  final String? firstName;
  final String? username;
  final File? selectedPhoto;
  final String? dob;
  @override
  State<ContentCreatorGender> createState() => _ContentCreatorGenderState();
}

class _ContentCreatorGenderState extends State<ContentCreatorGender> {
  int currentIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
          appBar: const OfWhichAppBar(
            titleText: "Personal Information",
            leadingIcon: true,
            backgroundColor: Colors.white,
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
                      height: 15.h,
                    ),
                    Text("It’ll help is to find people for you",
                        style: TextStyle(
                            fontFamily: Font.rubik,
                            fontSize: 16.sp,
                            color: const Color(0xFF646464),
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 20.h),
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
                                gender: gender),
                          );
                        })
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
                        log(widget.userType ?? "Emptyyyyyyyyy");
                        model.updateProfile(
                            dob: widget.dob,
                            fullName: widget.firstName,
                            profilePhoto: widget.selectedPhoto ?? File(""),
                            userType: widget.userType,
                            gender: genders[currentIndex].value);
                      },
                      // : null,
                      child: model.isBusy
                          ? const CircularProgressIndicator.adaptive()
                          : Text("Next",
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

class GenderWidget extends StatelessWidget {
  const GenderWidget({
    super.key,
    required this.gender,
    this.isSelected = false,
  });

  final GenderModel gender;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0.w),
      child: Row(
        children: [
          isSelected
              ? Image.asset("assets/images/pngs/selection_circle.png",
                  scale: 1.5)
              : Container(
                  height: 20.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE3E3E3)),
                      shape: BoxShape.circle),
                ),
          SizedBox(
            width: 5.w,
          ),
          Text(gender.title)
        ],
      ),
    );
  }
}
