import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AppPinCodeTextField extends StatefulWidget {
  const AppPinCodeTextField({
    super.key,
    required this.errorController,
    required this.textEditingController,
    this.onCompleted,
    this.pinType,
  });

  final StreamController<ErrorAnimationType>? errorController;
  final TextEditingController textEditingController;
  final PinCodeFieldShape? pinType;
  final Function(String?)? onCompleted;

  @override
  State<AppPinCodeTextField> createState() => _AppPinCodeTextFieldState();
}

class _AppPinCodeTextFieldState extends State<AppPinCodeTextField> {
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      // autoDismissKeyboard: false,
      appContext: context,
      // backgroundColor: const Color(0xFFF9FAFB),
      pastedTextStyle: const TextStyle(
        color: Colors.transparent,
        fontWeight: FontWeight.bold,
      ),
      length: 5,
      obscureText: true,
      obscuringCharacter: '●',
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      validator: (v) {
        if (v!.length < 3) {
          return "Please fill all fields";
        } else {
          return null;
        }
      },
      pinTheme: PinTheme(
          shape: widget.pinType ?? PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(15.r),
          fieldHeight: 60.h,
          fieldWidth: 60.w,
          borderWidth: 0.0.w,
          selectedBorderWidth: 0.5.w,
          activeBorderWidth: 0.5.w,
          inactiveBorderWidth: 0.5.w,
          selectedColor: Theme.of(context).primaryColor,
          selectedFillColor: const Color(0xFFF9FAFB),
          inactiveColor: Colors.grey.withOpacity(0.6),
          //  const Color(0xFFCACACA).withOpacity(0.2),

          inactiveFillColor: Colors.transparent,
          activeFillColor: const Color(0xFFE7E7E7).withOpacity(0.3),
          activeColor: Colors.grey.shade300),
      cursorColor: Colors.black,
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      errorAnimationController: widget.errorController,
      controller: widget.textEditingController,
      keyboardType: TextInputType.number,
      boxShadows: const [
        BoxShadow(
          offset: Offset(0, 1),
          color: Colors.black12,
          blurRadius: 10,
        )
      ],
      onCompleted: widget.onCompleted,
      onChanged: (value) {
        debugPrint(value);
      },
      beforeTextPaste: (text) {
        debugPrint("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }
}
