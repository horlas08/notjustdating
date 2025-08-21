import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:ofwhich/injectable.dart';
// import 'package:ofwhich/presentation/routes/app_router.dart';
// import 'package:footfan/injectable.dart';

// import '../router/app_router.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onTap, this.arrowColor});
  final VoidCallback? onTap;
  final Color? arrowColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.pop(context);
            // getIt<AppRouter>().pop();
          },
      child: Container(
        height: 41.h,
        width: 41.w,
        decoration: BoxDecoration(
            //border: Border.all(color: const Color(0xFF9D9D9D), width: 0.6.w),
            //  borderRadius: BorderRadius.circular(8.r)
            ),
        child: SvgPicture.asset(
          "assets/images/svgs/back_button.svg",
          //  height: 41.h,
          //   width: 41.w,
          color: arrowColor ?? Colors.grey[700],
        ),
      ),
    );
  }
}
