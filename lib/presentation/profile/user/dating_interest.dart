// import 'dart:developer';
import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:stacked/stacked.dart';

import '../../../application/profile/profile_view_model.dart';
import '../../../injectable.dart';
import '../../core/font.dart';
import '../../general_widgets/custom_appbar.dart';
import '../../general_widgets/custom_button.dart';
import '../../routes/app_router.dart';
import '../../routes/app_router.gr.dart';
import '../model/interest_model.dart';
// import '../routes/app_router.dart';
// import '../routes/app_router.gr.dart';

@RoutePage()
class DatingInterestScreen extends StatefulWidget {
  const DatingInterestScreen(
      {super.key,
      this.selectedPhoto,
      this.firstName,
      this.dob,
      this.userType,
      this.username,
      required this.gender,
      required this.relationshipStatus});
  final File? selectedPhoto;
  final String? firstName;
  final String? username;
  final String? dob;
  final String gender;
  final String relationshipStatus;
  final String? userType;

  @override
  State<DatingInterestScreen> createState() => _DatingInterestScreenState();
}

class _DatingInterestScreenState extends State<DatingInterestScreen> {
  int currentIndex = -1;
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text("Who are you looking for",
                      style: TextStyle(
                          fontFamily: Font.inter,
                          fontSize: 26.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text("You’ll only see ones that you choose",
                      style: TextStyle(
                          fontFamily: Font.inter,
                          fontSize: 16.sp,
                          color: Colors.black.withOpacity(0.9),
                          fontWeight: FontWeight.w400)),
                  SizedBox(height: 30.h),
                  ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 15.h,
                      );
                    },
                    shrinkWrap: true,
                    itemCount: interest.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      InterestModel interestModel = interest[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        child: InterestWidget(
                          interestModel: interestModel,
                          isSelected: currentIndex == index,
                          showDivider: index == 2 ? false : true,
                        ),
                      );
                    },
                  ),
                  CustomButton(
                    height: 60.h,
                    borderRadius: BorderRadius.circular(10.r),
                    width: MediaQuery.of(context).size.width,
                    onPressed:
                        // model.isEditNameButtonActive
                        // ?
                        () {
                      getIt<AppRouter>().push(UserAddressInfo(
                          preference: interest[currentIndex].value,
                          relationshipStatus: widget.relationshipStatus,
                          dob: widget.dob,
                          username: widget.username,

                          // dob: "26/12/1998",
                          firstName: widget.firstName,
                          selectedPhoto: widget.selectedPhoto ?? File(""),
                          gender: widget.gender));
                      // model.updateProfile(
                    },
                    // : null,
                    child: model.isBusy
                        ? const CircularProgressIndicator()
                        : Text("Complete",
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
              //   children: [

              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class InterestWidget extends StatelessWidget {
  const InterestWidget(
      {super.key,
      required this.interestModel,
      this.isSelected = false,
      this.showDivider = true});

  final InterestModel interestModel;
  final bool isSelected;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 70.h,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(
        //     border: Border.all(color: const Color(0xFFCACACA)),
        //     borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0.w,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(interestModel.title,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: Font.inter,
                              color: const Color(0xFF646464))),
                    ],
                  ),
                  isSelected
                      ? Image.asset("assets/images/pngs/selection_circle.png",
                          scale: 0.9)
                      : Container(
                          height: 25.h,
                          width: 25.w,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xFFE3E3E3)),
                              shape: BoxShape.circle),
                        ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              showDivider
                  ? const Divider(
                      color: Colors.grey,
                      thickness: 0.7,
                    )
                  : Container()
            ],
          ),
        ));
  }
}
