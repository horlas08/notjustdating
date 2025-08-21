import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ofwhich_v2/application/login_view_model/login_view_model.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';

// import 'package:ofwhich_v2/application/login_view_model/login_view_model.dart';
// import 'package:ofwhich/injectable.dart';
// import 'package:ofwhich/presentation/core/font.dart';
// import 'package:ofwhich/presentation/general_widgets/custom_appbar.dart';
// import 'package:ofwhich/presentation/general_widgets/custom_textfield.dart';
import 'package:stacked/stacked.dart';

import '../../../domain/core/validators/auth_validator.dart';
import '../../../injectable.dart';
import '../../general_widgets/check_box.dart';
import '../../general_widgets/custom_appbar.dart';
import '../../general_widgets/custom_button.dart';
import '../../general_widgets/custom_textfield.dart';
import '../../routes/app_router.dart';
import '../../routes/app_router.gr.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.userType});
  final String? userType;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isChecked = false;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => getIt<LoginViewModel>(),
      builder: (context, model, child) => Scaffold(
          appBar: const OfWhichAppBar(
            backgroundColor: Colors.white,
            titleText: "Log In",
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                onChanged: () {
                  model.changeButtonState(
                      val: formKey.currentState!.validate());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 10.h,
                    // ),

                    // Text("Welcome here",
                    //     style: TextStyle(
                    //         fontFamily: Font.inter,
                    //         fontSize: 26.sp,
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.w600)),
                    // SizedBox(
                    //   height: 15.h,
                    // ),
                    // Text("Sign in your existing Ofwhich account.",
                    //     style: TextStyle(
                    //         fontFamily: Font.rubik,
                    //         fontSize: 16.sp,
                    //         color: const Color(0xFF646464),
                    //         fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomTextFieldWidget(
                        controller: controller,

                        // contentPadding: EdgeInsets.zero,
                        filled: true,
                        // prefix: SvgPicture.asset("assets/images/svgs/message_icon.svg"),
                        label: "Email Address",
                        hintText: "Enter Email",
                        validator: (value) => OfWhichValidator().email(value),
                        labelTextStyle: TextStyle(
                            fontFamily: Font.inter,
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextFieldWidget(
                        controller: passwordController,
                        contentPadding: EdgeInsets.zero,
                        obscureText: true,

                         suffix: SvgPicture.asset("assets/images/svgs/password_show.svg"),
                        label: "Password",
                        hintText: "Enter password",
                        // validator: (value) =>
                        //     OfWhichValidator().password(value),
                        labelTextStyle: TextStyle(
                            fontFamily: Font.inter,
                            fontSize: 14.sp,
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 26.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                color: true ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: const Color.fromRGBO(172, 172, 172, 1),
                                  width: 1,
                                ),
                              ),
                              child: true //state vale
                                  ? const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.black,
                                    )
                                  : null,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'Keep me signed in',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: Font.inter,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Text("Forgot Password?",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: Font.inter,
                                color: Colors.black)),
                      ],
                    ),

                    CustomButton(
                      height: 59.h,
                      borderRadius: BorderRadius.circular(10.r),
                      width: MediaQuery.of(context).size.width,
                      onPressed: model.isSignInButtonActive
                          ? () {
                              model.signIn(
                                  email: controller.text,
                                  password: passwordController.text);
                            }
                          : null,
                      child: model.isBusy
                          ? const CircularProgressIndicator()
                          : Text("Continue",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontFamily: Font.inter,
                                  fontWeight: FontWeight.w400)),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Colors.grey, // Or any color
                            thickness: 1,
                            endIndent:
                                10, // Optional spacing before the center gap
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: Align(
                            child: Text("or",
                                style: TextStyle(
                                    fontFamily: Font.inter,
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ), // The gap between the lines
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 10, // Optional spacing after the center gap
                          ),
                        ),
                      ],
                    ),

                    CustomButton(
                        onPressed: () {
                          model.signInWithGoogle();
                        },
                        height: 60.h,
                        bgColor: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                        borderColor: Colors.grey,
                        borderSize: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  "assets/images/svgs/google_logo.svg"),
                              Expanded(
                                child: Text("Continue with Google",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: Font.inter,
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ],
                          ),
                        )),
                  
                    CustomButton(
                        onPressed: () {},
                        height: 60.h,
                        bgColor: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                        borderColor: Colors.grey,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  "assets/images/svgs/apple_logo.svg"),
                             
                              Expanded(
                                child: Text("Continue with Apple",
                                textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: Font.inter,
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 36.h,
                    ),
                    // Expanded(child: Container()),
                    // Container(
                    //   height: MediaQuery.of(context).size.height * 0.08,
                    // ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          getIt<AppRouter>().replace(RegisterRoute(
                              userType: widget.userType ?? "user"),);
                        },
                        child: Text.rich(
                          TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                  fontFamily: Font.inter,
                                   decoration: TextDecoration.underline,
                              
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              children: [
                                TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                        fontFamily: Font.inter,
                                        decoration: TextDecoration.underline,
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400))
                              ]),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
