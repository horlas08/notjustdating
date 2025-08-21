// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../general_widgets/custom_textfield.dart';

// import 'package:ofwhich/presentation/general_widgets/custom_textfield.dart';

class DateOfBirthForm extends StatefulWidget {
  const DateOfBirthForm({
    Key? key,
    this.onChanged,
  }) : super(key: key);
  final Function(String)? onChanged;

  @override
  _DateOfBirthFormState createState() => _DateOfBirthFormState();
}

class _DateOfBirthFormState extends State<DateOfBirthForm> {
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  FocusNode dayFocusNode = FocusNode();
  FocusNode monthFocusNode = FocusNode();
  FocusNode yearFocusNode = FocusNode();
  String dob = "";
  @override
  void dispose() {
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
    dayFocusNode.dispose();
    monthFocusNode.dispose();
    yearFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          // height: 60.h,
          width: 70.w,
          child: CustomTextFieldWidget(
            controller: dayController,
            hintText: 'DD',
            focusNode: dayFocusNode,
            inputType: TextInputType.text,
            // maxLength: 2,
            onChanged: (value) {
              if (value.length == 2) {
                FocusScope.of(context).requestFocus(monthFocusNode);
              }
            },
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        SizedBox(
          // height: 60.h,
          width: 70.w,
          child: CustomTextFieldWidget(
            controller: monthController,
            focusNode: monthFocusNode,

            hintText: "MM",
            inputType: TextInputType.text,
            // maxLength: 2,
            onChanged: (value) {
              if (value.length == 2) {
                FocusScope.of(context).requestFocus(yearFocusNode);
              }
            },
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        SizedBox(
          // height: 60.h,
          width: 70.w,
          child: CustomTextFieldWidget(
            controller: yearController,
            focusNode: yearFocusNode,
            inputType: TextInputType.text,
            hintText: 'YYYY',
            // maxLength: 4,
            onChanged: (value) {
              if (value.length == 4) {
                FocusScope.of(context).nextFocus();
                dob =
                    // "${dayController.text}/${monthController.text}/${yearController.text}";
                    "${yearController.text}-${monthController.text}-${dayController.text}";
                widget.onChanged!(dob);
              }
            },
          ),
        ),
      ],
    );
  }
}
