import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ofwhich_v2/lib/presentation/routes/app_router.gr.dart';

import '../../../injectable.dart';
import '../../core/font.dart';
import '../../general_widgets/custom_appbar.dart';
import '../../general_widgets/custom_button.dart';
import '../../routes/app_router.dart';
import '../../routes/app_router.gr.dart';
import '../model/relationship_model.dart';

@RoutePage()
class RelationShipStatusScreen extends StatefulWidget {
  const RelationShipStatusScreen(
      {super.key,
      this.selectedPhoto,
      this.firstName,
      this.userType,
      this.usernname,
      this.dob,
      required this.gender});
  final File? selectedPhoto;
  final String? firstName;
  final String? usernname;
  final String? dob;
  final String gender;
  final String? userType;
  @override
  State<RelationShipStatusScreen> createState() =>
      _RelationShipStatusScreenState();
}

class _RelationShipStatusScreenState extends State<RelationShipStatusScreen> {
  int currentIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: "Personal Information",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text("Relationship status",
                      style: TextStyle(
                          fontFamily: Font.inter,
                          fontSize: 26.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text("You can change your status at any time",
                      style: TextStyle(
                          fontFamily: Font.inter,
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)),
                  SizedBox(height: 20.h),
                  ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 15.h,
                      );
                    },
                    shrinkWrap: true,
                    itemCount: relationships.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      RelationshipModel relationshipModel =
                          relationships[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        child: RelationshipWidget(
                            isSelected: currentIndex == index,
                            relationshipModel: relationshipModel),
                      );
                    },
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
                        getIt<AppRouter>().push(DatingInterestRoute(
                            selectedPhoto: widget.selectedPhoto,
                            dob: widget.dob,
                            username: widget.usernname,
                            userType: widget.userType,
                            gender: widget.gender,
                            firstName: widget.firstName,
                            relationshipStatus:
                                relationships[currentIndex].title ?? ""));
                      },
                      // : null,
                      child: Text("Next",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontFamily: Font.inter,
                              fontWeight: FontWeight.w400))),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RelationshipWidget extends StatelessWidget {
  const RelationshipWidget({
    super.key,
    required this.relationshipModel,
    this.isSelected = false,
  });

  final RelationshipModel relationshipModel;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 90.h,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(
        //     border: Border.all(color: const Color(0xFFCACACA)),
        //     borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(relationshipModel.title ?? "",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: Font.inter,
                              color: Colors.black)),
                      Text(relationshipModel.subtTtile ?? "",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: Font.inter,
                              color: const Color(0xFF595959)))
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
              const Divider(
                color: Colors.grey,
                thickness: 0.7,
              )
            ],
          ),
        ));
  }
}
