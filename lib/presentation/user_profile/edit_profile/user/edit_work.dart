import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/profile/profile_view_model.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_appbar.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../../domain/core/validators/auth_validator.dart';
import '../../../general_widgets/custom_button.dart';
import '../../../routes/app_router.dart';
import '../../../routes/app_router.gr.dart';

@RoutePage()
class EditWork extends StatefulWidget {
  const EditWork({super.key});

  @override
  State<EditWork> createState() => _EditWorkState();
}

class _EditWorkState extends State<EditWork> {
  final formKey = GlobalKey<FormState>();
  TextEditingController designation = TextEditingController();
  TextEditingController employer = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const OfWhichAppBar(
            titleText: "Edit my work",
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

                      CustomTextFieldWidget(
                          controller: designation,
                          contentPadding: EdgeInsets.zero,
                          label: "Designation*",
                          validator: (value) =>
                              OfWhichValidator().isEmptyField(value),
                          labelTextStyle: TextStyle(
                              fontFamily: Font.rubik,
                              fontSize: 14.sp,
                              color: const Color(0xFF646464),
                              fontWeight: FontWeight.w400)),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextFieldWidget(
                          controller: employer,
                          contentPadding: EdgeInsets.zero,
                          label: "Employer*",
                          validator: (value) =>
                              OfWhichValidator().isEmptyField(value),
                          labelTextStyle: TextStyle(
                              fontFamily: Font.rubik,
                              fontSize: 14.sp,
                              color: const Color(0xFF646464),
                              fontWeight: FontWeight.w400)),
                      // Text("Note: this can only be edited ones",
                      //     style: TextStyle(
                      //         fontSize: 16.sp,
                      //         color: const Color(
                      //           0xFFFF0000,
                      //         ),
                      //         fontWeight: FontWeight.w400))
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
                                    job_title: designation.text.trim(),
                                    employer: employer.text.trim(),
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
