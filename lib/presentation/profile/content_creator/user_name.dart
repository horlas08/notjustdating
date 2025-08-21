import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
// import 'package:ofwhich_v2/presentation/profile/content_creator/profile_photo.dart';
import 'package:stacked/stacked.dart';

import '../../../application/profile/profile_view_model.dart';
import '../../../domain/core/validators/auth_validator.dart';
import '../../../injectable.dart';
import '../../general_widgets/custom_appbar.dart';
import '../../general_widgets/custom_button.dart';
import '../../routes/app_router.dart';
import '../../routes/app_router.gr.dart';

@RoutePage()
class UserNamePage extends StatefulWidget {
  const UserNamePage({super.key, this.userType, this.firstName});
  final String? userType;
  final String? firstName;

  @override
  State<UserNamePage> createState() => _UserNamePageState();
}

class _UserNamePageState extends State<UserNamePage> {
  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
        appBar: const OfWhichAppBar(
          titleText: "Personal Information",
          leadingIcon: false,
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
                    Text("Create Username",
                        style: TextStyle(
                            fontFamily: Font.inter,
                            fontSize: 26.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                        "Choose a username, or take our friendly suggestion, you can update it when ever you like.",
                        style: TextStyle(
                            fontFamily: Font.rubik,
                            fontSize: 16.sp,
                            color: const Color(0xFF646464),
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 20.h),
                    CustomTextFieldWidget(
                        controller: controller,
                        contentPadding: EdgeInsets.zero,
                        label: "Username*",
                        validator: (value) =>
                            OfWhichValidator().userName(value),
                        labelTextStyle: TextStyle(
                            fontFamily: Font.rubik,
                            fontSize: 14.sp,
                            color: const Color(0xFF646464),
                            fontWeight: FontWeight.w400)),
                  ],
                ),
                Column(
                  children: [
                    CustomButton(
                      height: 60.h,
                      borderRadius: BorderRadius.circular(10.r),
                      width: MediaQuery.of(context).size.width,
                      onPressed: model.isEditNameButtonActive
                          ? () {
                              getIt<AppRouter>().push(ContentCrProfilePhoto(
                                  firstName: widget.firstName,
                                  userType: widget.userType,
                                  username: controller.text));
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
        ),
      ),
    );
  }
}
