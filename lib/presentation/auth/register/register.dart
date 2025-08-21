import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

// import 'package:ofwhich/presentation/routes/app_router.dart';
// import 'package:ofwhich/presentation/routes/app_router.gr.dart';
import 'package:stacked/stacked.dart';

import '../../../application/sign_up/sign_up_view_model.dart';
import '../../../domain/core/validators/auth_validator.dart';
import '../../../injectable.dart';
import '../../core/font.dart';
import '../../general_widgets/custom_appbar.dart';
import '../../general_widgets/custom_button.dart';
import '../../general_widgets/custom_textfield.dart';
import '../../routes/app_router.dart';
import '../../routes/app_router.gr.dart';
// import '../../general_widgets/app_back_button.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.userType});
  final String userType;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => getIt<SignUpViewModel>(),
      builder: (context, model, child) => Scaffold(
          appBar: const OfWhichAppBar(
            backgroundColor: Colors.white,
            titleText: "Create an account",
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
                    //   height: 40.h,
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
                    // Text("Sign up with one of the following.",
                    //     style: TextStyle(
                    //         fontFamily: Font.rubik,
                    //         fontSize: 16.sp,
                    //         color: const Color(0xFF646464),
                    //         fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 36.h,
                    ),
                    CustomTextFieldWidget(
                        controller: controller,
                        filled: true,
                        // contentPadding: EdgeInsets.zero,
                        // prefix: SvgPicture.asset("assets/images/svgs/message_icon.svg"),
                        label: "Email Address",
                        hintText: "Enter Email",
                        validator: (value) => OfWhichValidator().email(value),
                        labelTextStyle: TextStyle(
                             fontFamily: Font.inter,
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400)),

                    CustomButton(
                      height: 59.h,
                      borderRadius: BorderRadius.circular(15.r),
                      width: MediaQuery.of(context).size.width,
                      onPressed: model.isSignupButtonActive
                          ? () {
                              model.signUp(
                                  email: controller.text, userType: "user");
                              // getIt<AppRouter>()
                              //     .push(const EmailConfirmationRoute());
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
                          // model.signInWithGoogle();
                        },
                        height: 60.h,
                        bgColor: Colors.white,
                        borderColor: Colors.grey,
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
                        ),),
                   
                    CustomButton(
                        onPressed: () {},
                        height: 60.h,
                        borderRadius: BorderRadius.circular(15.r),
                        bgColor: Colors.white,
                        borderColor: Colors.grey,
                        child:Container(
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
                    //   height: MediaQuery.of(context).size.height * 0.21,
                    // ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          getIt<AppRouter>()
                              .replace(LoginRoute(userType: widget.userType));
                        },
                        child: Text.rich(
                          TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                 fontFamily: Font.inter,
                                   decoration: TextDecoration.underline,
                              
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              children: [
                                TextSpan(
                                    text: "Log In",
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
