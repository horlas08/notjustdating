// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';

class CustomTextFieldWidget extends StatefulWidget {
  CustomTextFieldWidget(
      {Key? key,
      this.initialValue,
      this.label,
      this.hintText,
      this.prefix,
      this.suffix,
      this.suffixAction,
      this.controller,
      this.inputType,
      this.textCapitalization,
      this.validator,
      this.obscureText = false,
      this.isEnabled = true,
      this.color = const Color(0xFF3E4A59),
      this.onChanged,
      this.fontSize,
      this.centerText = false,
      this.readOnly = false,
      this.errorMessage,
      this.onSubmitted,
      this.filled = false,
      this.fillColor,
      this.inputFormatters,
      this.hintStyle,
      this.textStyle,
      this.labelTextStyle,
      this.contentPadding,
      this.onTap,
      this.border,
      this.textInputAction,
      this.focusNode,
      this.maxLength,
      this.macLines = 1})
      : super(key: key);

  // final AppLocalizations? tr;
  final String? initialValue;
  final String? label;
  final String? hintText;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? suffixAction;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final TextCapitalization? textCapitalization;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? hintStyle;
  final EdgeInsets? contentPadding;
  final InputBorder? border;
  final FocusNode? focusNode;
  @required
  bool obscureText;
  final bool? isEnabled;
  final color;
  final fontSize;
  final fillColor;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  @required
  bool centerText;
  @required
  bool readOnly = false;
  final String? errorMessage;
  final bool? filled;
  final TextStyle? textStyle;
  final TextStyle? labelTextStyle;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? macLines;
  // final AutovalidateMode autovalidateMode;

  @override
  _CustomTextFieldWidgetState createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool isTapped = false;
  String? error;
  @override
  Widget build(BuildContext context) {
        var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: widget.centerText
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        widget.label == null
            ? Container()
            : Text(
                widget.label ?? '',
                style: widget.labelTextStyle ??
                    textTheme.bodySmall?.copyWith(
                      fontSize: widget.fontSize ?? 14.sp,
                      color: Colors.grey,
                    ),
              ),
        SizedBox(
          height: size.height * 0.01,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isTapped = !isTapped;
            });
            // print(isTapped);
          },
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscuringCharacter: "●",
            enableSuggestions: false,
            maxLength: widget.maxLength,
            textInputAction: widget.textInputAction,
            onTap: widget.onTap,
            focusNode: widget.focusNode,
            maxLines: widget.macLines,
            cursorColor: Theme.of(context).primaryColor,
            // cursorHeight: 20.0.h,
            readOnly: widget.readOnly,
            controller: widget.controller,
            autocorrect: true,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.sentences,
            initialValue: widget.initialValue,
            obscureText: widget.obscureText,
            // onSaved: (val) => email = val,
            validator: widget.validator,
            //     (String? val) {
            //   // For optional fields in forms, don't validate.
            //   // Just return a null error text. This means there is no validation
            //   // error text to display

            //   if (widget.validator == null) return null;

            //   setState(() {
            //     error = widget.validator!(val);
            //   });
            //   return error;
            // },
            onFieldSubmitted: widget.onSubmitted,
            onChanged: (value) {
              widget.onChanged == null ? null : widget.onChanged!(value);
              // AltBankActivityTimerService().trackUserActivity();
            },

            style: widget.textStyle ??
                Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.black ,fontSize: 16.sp,fontFamily: Font.inter, fontWeight: FontWeight.w400,),
            keyboardType: widget.inputType,
            inputFormatters: widget.inputFormatters,

            decoration: InputDecoration(
              errorText: widget.errorMessage,
              fillColor:
                  widget.fillColor ?? const Color(0xFFF2F2F2).withOpacity(0.3),
              //  errorText: userProvider.getMessage(),
              errorMaxLines:
                  Theme.of(context).inputDecorationTheme.errorMaxLines,
              filled: widget.filled,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 18.0
                      // vertical: .h,
                      ),
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  TextStyle(
                    fontSize: 16.sp,
                    fontFamily: Font.inter,
                      color: const Color.fromRGBO(156, 156, 156, 1), fontWeight: FontWeight.w400),
              // Theme.of(context).inputDecorationTheme.hintStyle!.copyWith(),

              focusedBorder: widget.border ??
                  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
              enabledBorder: widget.border ??
                  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide(color: Colors.grey.shade300)),

              border: widget.border ??
                  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: const BorderSide()),
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  left: 12.0.w,
                  right: 10.0.w,
                ),
                child: widget.prefix,
              ),

              prefixIconConstraints: BoxConstraints(
                maxHeight: 40.0.h,
              ),
              suffixIconConstraints: BoxConstraints(
                  maxHeight: 40.0.h, minWidth: 60.w, maxWidth: 100.w),
              // suffixConstraints:
              suffixIcon: widget.suffix == null
                  ? null
                  : InkResponse(
                      onTap: widget.suffixAction,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 12.0.w,
                          right: 15.0.w,
                        ),
                        child: widget.suffix,
                      ),
                    ),
              //*revisit suffix implementation later
              // suffix: widget.suffix == null
              //     ? null
              //     : GestureDetector(
              //         onTap: () => widget.suffixAction,
              //         child: Padding(
              //             padding: EdgeInsets.only(
              //               left: 10.0.w,
              //               right: 8.0.w,
              //             ),
              //             child: widget.suffix),
              //       ),

              // prefixIcon: Icon(Icons.person),
            ),
          ),
        ),
      ],
    );
  }
}
