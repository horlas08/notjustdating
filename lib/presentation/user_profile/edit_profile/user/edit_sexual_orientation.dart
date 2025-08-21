import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/profile/profile_view_model.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';
import 'package:ofwhich_v2/presentation/user_profile/edit_profile/user/model/sexual_model.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../core/font.dart';
import '../../../general_widgets/custom_appbar.dart';
import '../../../general_widgets/custom_button.dart';
import '../../../routes/app_router.gr.dart';

@RoutePage()
class EditSexualOrientation extends StatefulWidget {
  const EditSexualOrientation({super.key});

  @override
  State<EditSexualOrientation> createState() => _EditSexualOrientationState();
}

class _EditSexualOrientationState extends State<EditSexualOrientation> {
  int currentIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
          appBar: const OfWhichAppBar(
            titleText: "Edit my sexual orientation",
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
                    Text("What's your relationship status",
                        style: TextStyle(
                            fontFamily: Font.inter,
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
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
                        SexaulOrientationModel so = relationships[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          child: SelectionWidget(
                              isSelected: currentIndex == index,
                              relationshipModel: so),
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
                        model.editProfile(
                            sexual_orientation: relationships[currentIndex]
                                .value
                                .toLowerCase()
                                .trim(),
                            navigate: () {
                              getIt<AppRouter>()
                                  .replace(const UserProfileDetails());
                            });
                        // getIt<AppRouter>().push(DatingInterestRoute(
                        //     selectedPhoto: widget.selectedPhoto,
                        //     dob: widget.dob,
                        //     gender: widget.gender,
                        //     firstName: widget.firstName,
                        //     relationshipStatus:
                        //         relationships[currentIndex].title ?? ""));
                      },
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

class SelectionWidget extends StatelessWidget {
  const SelectionWidget({
    super.key,
    required this.relationshipModel,
    this.isSelected = false,
  });

  final SexaulOrientationModel relationshipModel;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFCACACA)),
            borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(relationshipModel.value,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: Font.inter,
                          color: const Color(0xFF646464))),
                  Text(relationshipModel.value,
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: Font.inter,
                          color: const Color(0xFF646464)))
                ],
              ),
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
            ],
          ),
        ));
  }
}
