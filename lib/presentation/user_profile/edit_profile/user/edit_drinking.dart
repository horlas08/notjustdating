import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/profile/profile_view_model.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_appbar.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../../injectable.dart';
import '../../../general_widgets/custom_button.dart';
import '../../../routes/app_router.gr.dart';
import 'model/drinnkinng_model.dart';

@RoutePage()
class EditDrinking extends StatefulWidget {
  const EditDrinking({super.key});

  @override
  State<EditDrinking> createState() => _EditDrinkingState();
}

class _EditDrinkingState extends State<EditDrinking> {
  int currentIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
          appBar: const OfWhichAppBar(
            titleText: "Drinking",
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
                    Text("Do you drink",
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
                      itemCount: drinkingTypes.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        DrinkingModel so = drinkingTypes[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          child: SelectionWidget(
                              isSelected: currentIndex == index,
                              drinkingModel: so),
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
                            drinks: drinkingTypes[currentIndex]
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
          )),
    );
  }
}

class SelectionWidget extends StatelessWidget {
  const SelectionWidget({
    super.key,
    required this.drinkingModel,
    this.isSelected = false,
  });

  final DrinkingModel drinkingModel;
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
                  Text(drinkingModel.value,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: Font.inter,
                          color: const Color(0xFF646464))),
                  // Text(drinkingModel.value,
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
