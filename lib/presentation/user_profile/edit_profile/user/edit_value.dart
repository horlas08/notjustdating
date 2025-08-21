import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
import 'package:ofwhich_v2/presentation/user_profile/edit_profile/user/model/value_model.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../../application/profile/profile_view_model.dart';
import '../../../general_widgets/custom_appbar.dart';
import '../../../general_widgets/custom_button.dart';
import '../../../routes/app_router.dart';
import '../../../routes/app_router.gr.dart';

@RoutePage()
class EditValue extends StatefulWidget {
  const EditValue({super.key});

  @override
  State<EditValue> createState() => _EditValueState();
}

class _EditValueState extends State<EditValue> {
  int currentIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
          appBar: const OfWhichAppBar(
            titleText: "Values",
            leadingIcon: true,
            backgroundColor: Colors.white,
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
                      Text("What are your values",
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
                        itemCount: valueList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          ValueModel so = valueList[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            child: SelectionWidget(
                                isSelected: currentIndex == index,
                                valueModel: so),
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
                              value: valueList[currentIndex]
                                  .value
                                  .toLowerCase()
                                  .trim(),
                              navigate: () {
                                getIt<AppRouter>()
                                    .replace(const UserProfileDetails());
                              });
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
            ),
          )),
    );
  }
}

class SelectionWidget extends StatelessWidget {
  const SelectionWidget({
    super.key,
    required this.valueModel,
    this.isSelected = false,
  });

  final ValueModel valueModel;
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(valueModel.value,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: Font.inter,
                          color: const Color(0xFF646464))),
                  // Text(valueModel.value,
                  //     style: TextStyle(
                  //         fontSize: 10.sp,
                  //         fontWeight: FontWeight.w400,
                  //         fontFamily: Font.inter,
                  //         color: const Color(0xFF646464)))
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
