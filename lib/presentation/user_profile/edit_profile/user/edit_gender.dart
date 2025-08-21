import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../../application/profile/profile_view_model.dart';
import '../../../core/font.dart';
import '../../../general_widgets/custom_appbar.dart';
import '../../../general_widgets/custom_button.dart';
import '../../../profile/model/gender_model.dart';
import '../../../routes/app_router.gr.dart';

@RoutePage()
class EditUserGender extends StatefulWidget {
  const EditUserGender(
      {super.key, this.selectedPhoto, this.firstName, this.dob, this.userType});
  final File? selectedPhoto;
  final String? firstName;
  final String? dob;
  final String? userType;

  @override
  State<EditUserGender> createState() => _EditUserGenderState();
}

class _EditUserGenderState extends State<EditUserGender> {
  int currentIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
          appBar: const OfWhichAppBar(
            titleText: "Edit my gender",
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
                    // Text("What is your gender?",
                    //     style: TextStyle(
                    //         fontFamily: Font.inter,
                    //         fontSize: 26.sp,
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.w600)),
                    // SizedBox(
                    //   height: 15.h,
                    // ),
                    // Text("It’ll help is to find people for you",
                    //     style: TextStyle(
                    //         fontFamily: Font.rubik,
                    //         fontSize: 16.sp,
                    //         color: const Color(0xFF646464),
                    //         fontWeight: FontWeight.w400)),
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
                        }),

                    SizedBox(height: 10.h),
                    Text("Note: this can only be edited once",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: Font.inter,
                            color: const Color(0xFFFF0000),
                            fontWeight: FontWeight.w400)),
                  ],
                ),
                Column(
                  children: [
                    CustomButton(
                      height: 60.h,
                      borderRadius: BorderRadius.circular(10.r),
                      width: MediaQuery.of(context).size.width,
                      onPressed: () {
                        model.editProfile(
                            gender: genders[currentIndex].value,
                            navigate: () {
                              getIt<AppRouter>().pushAndPopUntil(
                                  predicate: (_) => false,
                                  const UserProfileDetails());
                            });
                      },
                      // model.isEditNameButtonActive
                      // ?
                      // () {
                      // getIt<AppRouter>().push(RelationShipStatusRoute(
                      //     selectedPhoto: widget.selectedPhoto,
                      //     firstName: widget.firstName,
                      //     dob: widget.dob,
                      //     gender: genders[currentIndex].value));
                      // },
                      // : null,
                      child: Text("Save",
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
