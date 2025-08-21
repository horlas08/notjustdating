// import 'package:altbank/presentation/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  // final String? label;
  // final VoidCallback onPressed;
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Widget? child;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final double? padding;
  // final Gradient gradient;
  final Color? borderColor;
  final double? borderSize;
  final double? marginTop;
  final double buttonElevation;
  final BorderRadius? borderRadius;
  final bool useGradient;
  final Color? shadowColor;

  const CustomButton({
    super.key,
    this.width = double.infinity,
    this.height,
    required this.onPressed,
    this.bgColor,
    this.textColor = Colors.white,
    this.fontSize = 15,
    this.padding = 10.0,
    this.borderColor,
    this.marginTop = 20.0,
    this.useGradient = true,
    this.borderSize,
    this.buttonElevation = 0.0,
    this.shadowColor,
    // this.gradient = const LinearGradient(
    //   colors: [Color(0XFFF2D473), Color(0XFFB89645)],
    //   begin: Alignment.topCenter,
    //   end: Alignment.bottomCenter,
    // ),
    this.child,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: marginTop ?? 0.0),
      child:
          //* just incase
          // elevation: buttonElevation,
          // shadowColor: shadowColor ?? Colors.grey[300],
          // borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(40.r)),
          Container(
              height: height ?? 45.0.h,
              width: width ?? double.infinity,
              decoration: const BoxDecoration(
                  // gradient: useGradient ? gradient : null,
                  ),
              child: MaterialButton(
                enableFeedback: false,
                padding: EdgeInsets.all(padding ?? 0.0),
                elevation: buttonElevation,
                color: bgColor ?? Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  side: borderColor == null
                      ? BorderSide(
                          color: onPressed == null
                              ? Colors.grey
                              : Colors.transparent,
                        )
                      : BorderSide(
                          width: borderSize ?? 1,
                          color: borderColor ?? Theme.of(context).primaryColor,
                        ),
                  borderRadius: borderRadius ??
                      const BorderRadius.all(
                        Radius.circular(15),
                      ),
                ),

                // textColor: Colors.green,

                disabledColor:
                    //  Colors.black26,
                    // Colors.white,
                    Theme.of(context).disabledColor,

                disabledTextColor: Colors.grey.shade400,
                onPressed: onPressed,
                child: child ?? Container(),
              )),
    );
  }
}
