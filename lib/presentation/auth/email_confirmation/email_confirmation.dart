import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ofwhich/injectable.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

import '../../../application/sign_up/sign_up_view_model.dart';
import '../../../injectable.dart';
import '../../core/font.dart';
import '../../general_widgets/app_pin_code_textfield.dart';
import '../../general_widgets/custom_appbar.dart';
import '../../general_widgets/custom_button.dart';
import '../../general_widgets/gradient_text.dart';
// import '../../routes/app_router.dart';

@RoutePage()
class EmailConfirmationScreen extends StatefulWidget {
  const EmailConfirmationScreen({super.key, this.email, this.userType});
  final String? email;
  final String? userType;

  @override
  State<EmailConfirmationScreen> createState() =>
      _EmailConfirmationScreenState();
}

class _EmailConfirmationScreenState extends State<EmailConfirmationScreen> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";
  bool isButtonActive = false;
  final formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;
  late Timer _timer;
  int otpCountDown = 59;
  bool restartOtpTimer = false;
  bool showButton = false;

  startOtpTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (otpCountDown == 0) {
        setState(() {
          _timer.cancel();
          showButton = true;
        });
      } else {
        setState(() {
          otpCountDown--;
        });
      }
    });
  }

  @override
  void initState() {
    startOtpTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => getIt<SignUpViewModel>(),
      builder: (context, model, child) => Scaffold(
          appBar: const OfWhichAppBar(
              titleText: "Verify your email", backgroundColor: Colors.white),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.0.w, vertical: 20.h),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: () {
                  model.changeOtpButtonnState(
                      val: formKey.currentState!.validate());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 70.h,
                    // ),
                    // const AppBackButton(),
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    // Text("Enter confirmation code",
                    //     style: TextStyle(
                    //         fontSize: 24.sp,
                    //         fontFamily: Font.inter,
                    //         fontWeight: FontWeight.w700,
                    //         color: Colors.black)),
                    // SizedBox(height: 10.h),
                    Text.rich(TextSpan(
                        text:
                            "We’ve sent a 6-digits code to your email address,\nEnter it below to verify your identity",
                        // children: [
                        //   TextSpan(
                        //       text: " ${widget.email}",
                        //       style: TextStyle(
                        //           color: Colors.black,
                        //           fontSize: 16.sp,
                        //           fontWeight: FontWeight.w500))
                        // ],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontFamily: Font.inter,
                            // color: Colors.black,
                            fontWeight: FontWeight.w400))),
                    SizedBox(
                      height: 35.h,
                    ),
                    // Text(
                    //   "6-digit code",
                    //   style: TextStyle(
                    //       fontSize: 16.sp,
                    //       fontWeight: FontWeight.w400,
                    //       fontFamily: Font.inter),
                    // ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text("6-digit code",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 20.h,
                    ),
                    AppPinCodeTextField(
                        errorController: errorController,
                        onCompleted: (val) {
                          model.verifyEmail(
                              email: widget.email,
                              verificationCode: textEditingController.text,
                              userType: widget.userType);
                        },
                        textEditingController: textEditingController),

                    GestureDetector(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text.rich(TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                restartOtpTimer = await model.resendOtp(
                                    email: widget.email ?? "",
                                    userType: widget.userType ?? "");

                                if (restartOtpTimer) {
                                  setState(() {
                                    otpCountDown = 59;
                                    showButton = false;
                                  });
                                  startOtpTimer();
                                }
                              },
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: Font.inter,
                                color: Colors.black,
                                //  showButton
                                //     ? Theme.of(context).primaryColor
                                //     :
                                fontWeight: FontWeight.w400),
                            children: [
                              WidgetSpan(
                                  alignment: PlaceholderAlignment.baseline,
                                  baseline: TextBaseline.alphabetic,
                                  child: GradientText(
                                    "00:$otpCountDown",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: Font.inter,
                                        foreground: Paint()
                                          ..shader = const LinearGradient(
                                            colors: [
                                              Color.fromRGBO(196, 0, 0, 1),
                                              Color.fromRGBO(254, 151, 56, 1),
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ).createShader(
                                              Rect.fromLTWH(0, 0, 20, 25)),

                                        // color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(196, 0, 0, 1),
                                        Color.fromRGBO(254, 151, 56, 1),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  )
                                  //    GradientText(
                                  //     "00:$otpCountDown",
                                  //     style: TextStyle(
                                  //       fontSize: 16.sp,
                                  //       fontFamily: Font.inter,
                                  //       foreground: Paint()
                                  //         ..shader = LinearGradient(
                                  //           colors:  [
                                  //             Color.fromRGBO(196, 0, 0, 1),
                                  //             Color.fromRGBO(254, 151, 56, 1),
                                  //           ],
                                  //           begin: Alignment.centerLeft,
                                  //           end: Alignment.centerRight,
                                  //         ).createShader(Rect.fromLTWH(0, 0, 20, 25)),
                                  //      // color: Colors.black,
                                  //       fontWeight: FontWeight.w700),
                                  // )
                                  )
                            ])),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomButton(
                        onPressed: model.isOtpButtonActive
                            ? () {
                                // getIt<AppRouter>().push(const CreatePasswordRoute());
                                model.verifyEmail(
                                    email: widget.email,
                                    verificationCode:
                                        textEditingController.text,
                                    userType: widget.userType);
                              }
                            : null,
                        height: 65.h,
                        borderRadius: BorderRadius.circular(15.r),
                        child: model.isBusy
                            ? const CircularProgressIndicator()
                            : Text("Continue",
                                style: TextStyle(
                                    fontFamily: Font.rubik,
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400))),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
