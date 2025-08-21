import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_appbar.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_button.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_textfield.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../../application/profile/profile_view_model.dart';
import '../../../../domain/core/validators/auth_validator.dart';
import '../../../routes/app_router.dart';
// import 'package:flutter/widgets.dart';

@RoutePage()
class EditUserName extends StatefulWidget {
  const EditUserName({super.key});

  @override
  State<EditUserName> createState() => _EditUserNameState();
}

class _EditUserNameState extends State<EditUserName> {
  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
          appBar: const OfWhichAppBar(
            titleText: "Edit My Name",
            leadingIcon: true,
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: formKey,
              onChanged: () {
                model.changeButtonState(val: formKey.currentState!.validate());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Text("What is your name",
                          style: TextStyle(
                              fontFamily: Font.inter,
                              fontSize: 26.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text("This name will be seen by other users.",
                          style: TextStyle(
                              fontFamily: Font.rubik,
                              fontSize: 16.sp,
                              color: const Color(0xFF646464),
                              fontWeight: FontWeight.w400)),
                      SizedBox(height: 20.h),
                      CustomTextFieldWidget(
                          controller: controller,
                          contentPadding: EdgeInsets.zero,
                          label: "Full Name*",
                          validator: (value) =>
                              OfWhichValidator().userName(value),
                          labelTextStyle: TextStyle(
                              fontFamily: Font.rubik,
                              fontSize: 14.sp,
                              color: const Color(0xFF646464),
                              fontWeight: FontWeight.w400)),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text("Note: this can only be edited ones",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: const Color(
                                0xFFFF0000,
                              ),
                              fontWeight: FontWeight.w400))
                    ],
                  ),
                  Column(
                    children: [
                      CustomButton(
                        height: 65.h,
                        borderRadius: BorderRadius.circular(10.r),
                        width: MediaQuery.of(context).size.width,
                        onPressed: model.isEditNameButtonActive
                            ? () {
                                log("callleddddddddddddd");
                                // widget.userType == "user"
                                model.editProfile(
                                    fullName: controller.text.trim(),
                                    navigate: () {
                                      getIt<AppRouter>().pushAndPopUntil(
                                          predicate: (_) => false,
                                          const UserProfileDetails());
                                    });
                              }
                            : null,
                        child: model.isBusy
                            ? const CircularProgressIndicator()
                            : Text("Save",
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
