import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
import 'package:stacked/stacked.dart';

import '../../../application/login_view_model/login_view_model.dart';
import '../../../domain/core/validators/auth_validator.dart';
import '../../core/font.dart';
import '../../general_widgets/custom_appbar.dart';
import '../../general_widgets/custom_button.dart';
import '../../general_widgets/custom_textfield.dart';
import '../../routes/app_router.dart';

@RoutePage()
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final controller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isButtonActive = false;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => getIt<LoginViewModel>(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: const CustomAppBar(titleText: "Forget Password"),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: () {
                  setState(() {
                    isButtonActive = formKey.currentState!.validate();
                  });
                },
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                        "Enter the phone number connected to your niibow account",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextFieldWidget(
                        controller: controller,

                        // contentPadding: EdgeInsets.zero,
                        filled: true,
                        // prefix: SvgPicture.asset("assets/images/svgs/message_icon.svg"),
                        label: "Email Address",
                        validator: (value) => OfWhichValidator().email(value),
                        labelTextStyle: TextStyle(
                            fontFamily: Font.rubik,
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomButton(
                      height: 65.h,
                      borderRadius: BorderRadius.circular(15.r),
                      width: MediaQuery.of(context).size.width,
                      onPressed: isButtonActive
                          ? () {
                              getIt<AppRouter>().push(ForgotPasswordOtp());
                            }
                          : null,
                      child:
                          // model.isBusy
                          //     ? const CircularProgressIndicator()
                          //     :
                          Text("Continue",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontFamily: Font.inter,
                                  fontWeight: FontWeight.w400)),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
