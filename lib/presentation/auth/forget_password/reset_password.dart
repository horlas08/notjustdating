import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';

// import 'package:ofwhich/presentation/routes/app_router.gr.dart';
// import 'package:ofwhich/presentation/auth/create_password/account_creation_success.dart';
import 'package:stacked/stacked.dart';

import '../../../application/sign_up/sign_up_view_model.dart';
import '../../../domain/core/validators/auth_validator.dart';
import '../../../injectable.dart';
import '../../core/font.dart';
import '../../general_widgets/custom_appbar.dart';
import '../../general_widgets/custom_button.dart';
import '../../general_widgets/custom_textfield.dart';
import '../../routes/app_router.gr.dart';
// import '../../routes/app_router.dart';

@RoutePage()
class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, this.userType, this.email});
  final String? userType;
  final String? email;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  TextEditingController defaultPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool showPassword = false;
  bool showComfirmPassword = false;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => getIt<SignUpViewModel>(),
      builder: (context, model, child) => Scaffold(
        appBar: const CustomAppBar(titleText: "Reset Password"),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: () {
                model.changeCreatePasswordButtonState(
                    val: formKey.currentState!.validate());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),

                  Text(
                      "Create a secure password different from your previous password, including symbols and numbers",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: 30.h,
                  ),
                  // CustomTextFieldWidget(

                  CustomTextFieldWidget(
                      obscureText: model.obscurePassword,
                      controller: controller,
                      filled: true,
                      // contentPadding: EdgeInsets.zero,
                      suffix: model.obscurePassword
                          ? SvgPicture.asset(
                              "assets/images/svgs/hide_password.svg")
                          : SvgPicture.asset(
                              "assets/images/svgs/show_password.svg"),
                      suffixAction: () {
                        model.togglePasswordVisibilty();
                        // context.router.pop();
                      },
                      onChanged: (val) {
                        model.passwordStrengthShecker(val);
                      },
                      // prefix:
                      //     SvgPicture.asset("assets/images/svgs/password_lock.svg"),
                      label: "Password",
                      hintText: "Enter your password",
                      validator: (value) => OfWhichValidator().password(value),
                      labelTextStyle: TextStyle(
                          fontFamily: Font.rubik,
                          fontSize: 14.sp,
                          color: const Color(0xFF535353),
                          fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomTextFieldWidget(
                      filled: true,
                      obscureText: model.obscureConfirmPassword,
                      controller: confirmPassword,
                      // contentPadding: EdgeInsets.zero,
                      suffix: model.obscureConfirmPassword
                          ? SvgPicture.asset(
                              "assets/images/svgs/hide_password.svg")
                          : SvgPicture.asset(
                              "assets/images/svgs/show_password.svg"),
                      suffixAction: () {
                        model.toggleConfirmPasswordVisibility();
                        // context.router.pop();
                      },
                      onChanged: (val) {},
                      // prefix:
                      //     SvgPicture.asset("assets/images/svgs/password_lock.svg"),
                      label: "Confirm Password",
                      hintText: "Enter your password",
                      validator: (value) => OfWhichValidator().confirmPassword(
                          controller.text, confirmPassword.text),
                      labelTextStyle: TextStyle(
                          fontFamily: Font.rubik,
                          fontSize: 14.sp,
                          color: const Color(0xFF535353),
                          fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                      width: 400.w,
                      height: 200.h,
                      child: StreamBuilder<int?>(
                          stream: model.streamController.stream,
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              model.password_strength_color = Colors.grey;
                              model.password_strength_level = 0;
                              model.password_strength = "";
                            } else if (snapshot.data == 0) {
                              model.password_strength_color = Colors.grey;
                              model.password_strength_level = 0;
                              model.password_strength = "";
                            } else if (snapshot.data == 1) {
                              model.password_strength_color = Colors.red;
                              model.password_strength_level = 0.3;
                              model.password_strength = "weak";
                            } else if (snapshot.data == 2) {
                              model.password_strength_color = Colors.yellow;
                              model.password_strength_level = 0.65;
                              model.password_strength = "moderate";
                            } else if (snapshot.data == 3) {
                              model.password_strength_color = Colors.green;
                              model.password_strength_level = 1;
                              model.password_strength = "good";
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Password strength: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 8.w),
                                      width: 70,
                                      child: Text(model.password_strength),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: LinearProgressIndicator(
                                    value: model.password_strength_level,
                                    color: model.password_strength_color,
                                    backgroundColor: Colors.grey,
                                  ),
                                ),
                                CustomButton(
                                  height: 65.h,
                                  borderRadius: BorderRadius.circular(15.r),
                                  width: MediaQuery.of(context).size.width,
                                  onPressed: model.isCreatePasswordButtonActive
                                      ? () {
                                          getIt<AppRouter>().push(
                                              PasswordResetSuccess(
                                                  userType: "user"));
                                          // model.updateDefaultPassword(
                                          //     email: widget.email,
                                          //     newPassword: controller.text,
                                          //     userType:
                                          //         widget.userType ?? "user");
                                        }
                                      : null,
                                  child: model.isBusy
                                      ? const CircularProgressIndicator()
                                      : Text("Reset Password",
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.white,
                                              fontFamily: Font.inter,
                                              fontWeight: FontWeight.w400)),
                                )
                              ],
                            );
                          })),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
