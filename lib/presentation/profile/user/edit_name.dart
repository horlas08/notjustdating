import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:stacked/stacked.dart';

import '../../../application/profile/profile_view_model.dart';
import '../../../domain/core/validators/auth_validator.dart';
import '../../../injectable.dart';
import '../../core/font.dart';
import '../../general_widgets/custom_appbar.dart';
import '../../general_widgets/custom_button.dart';
import '../../general_widgets/custom_textfield.dart';
import '../../routes/app_router.dart';
import '../../routes/app_router.gr.dart';

@RoutePage()
class EditNameScreen extends StatefulWidget {
  const EditNameScreen({super.key, this.userType});
  final String? userType;

  @override
  State<EditNameScreen> createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
          appBar: const CustomAppBar(
            titleText: "Personal Information",
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                        height: 5.h,
                      ),
                      Text("This name will be seen by other users.",
                          style: TextStyle(
                              fontFamily: Font.inter,
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                      SizedBox(height: 35.h),
                      CustomTextFieldWidget(
                          controller: controller,
                          // contentPadding: EdgeInsets.zero,
                          label: "Full Name*",
                          validator: (value) =>
                              OfWhichValidator().userName(value),
                          labelTextStyle: TextStyle(
                              fontFamily: Font.inter,
                              fontSize: 14.sp,
                             // color: Colors.black,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),

                  SizedBox(height: 19.h,),
                  Column(
                    children: [
                      CustomButton(
                        height: 59.h,
                        borderRadius: BorderRadius.circular(15.r),
                        width: MediaQuery.of(context).size.width,
                        onPressed: model.isEditNameButtonActive
                            ? () {
                                log("firstName :::: ${controller.text}");
                                widget.userType == "user"
                                    ? getIt<AppRouter>().push(UserNameUserPage(
                                        userType: "user",
                                        firstName: controller.text))
                                    : getIt<AppRouter>().push(UserNamePage(
                                        userType: "content-creator",
                                        firstName: controller.text));
                              }
                            : null,
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
                ],
              ),
            ),
          )),
    );
  }
}
