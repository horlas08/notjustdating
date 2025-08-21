import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/font.dart';
import 'app_back_button.dart';

// import 'package:ofwhich/presentation/routes/app_router.dart';

class OfWhichAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OfWhichAppBar(
      {super.key,
      this.height,
      this.titleText = "Default",
      this.titleTextColor,
      this.backgroundColor,
      this.elevation,
      this.leadingIcon = true,
      this.showShare = false,
      this.onTap,
      this.onTapShare,
      this.shadwoColor,
      this.children = const [],
      this.topMargin});
  final double? height;
  final String titleText;
  final Color? titleTextColor;
  final Color? backgroundColor;
  final double? elevation;
  final bool leadingIcon;
  final bool showShare;
  final VoidCallback? onTap;
  final VoidCallback? onTapShare;
  final Color? shadwoColor;
  final List<Widget> children;
  final double? topMargin;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          backgroundColor ?? Theme.of(context).colorScheme.background,
      automaticallyImplyLeading: false,
      elevation: elevation ?? 0.0,
      // shadowColor: shadwoColor ?? AltBankColor.dAltBkGrey500,
      title: Padding(
        padding: EdgeInsets.only(top: height == null ? 0 : 0.h),
        child: Row(
          children: [
            Visibility(
              visible: leadingIcon == true ? true : false,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    margin: EdgeInsets.only(
                      top: height == null ? 0 : 25.h,
                    ),
                    child: const AppBackButton( arrowColor: Colors.black,)),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(
                    top: height == null ? 0 : 25.h,
                  ),
                  child: Text(titleText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color:  Colors.black,
                          fontSize: 16.sp,
                          fontFamily: Font.inter,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            showShare == false
                ? Expanded(
                    child: children.isEmpty
                        ? Container()
                        : Container(
                            margin: EdgeInsets.only(
                              top: topMargin ?? 25.h,
                            ),
                            padding: EdgeInsets.symmetric(
                              // horizontal: 15.w,
                              vertical: 5.h,
                            ),
                            child: Row(children: children),
                          ),
                  )
                : Container(
                    margin: EdgeInsets.only(
                      top: 25.h,
                    ),
                    child: InkWell(
                      onTap: onTapShare,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: AltBankColor.dAltBkGold900,
                          ),
                          // onPressed: () {},
                          child: const Text(
                            "Share",
                            // style: AltBankTextStyle.p1.copyWith(
                            //   color: AltBankColor.dAltBkWhite,
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 65.h);
}

// import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onSharePressed;
  final VoidCallback? onBookmarkPressed;
  final String? titleText;

  const CustomAppBar({
    super.key,
    this.onBackPressed,
    this.onSharePressed,
    this.onBookmarkPressed,
    this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: CircleAvatar(
          backgroundColor: Colors.grey.withOpacity(0.2),
          minRadius: 20.5,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
          ),
        ),
      ),
      title: Text(
        titleText ??
            'Article Title', // Replace with your dynamic title if needed
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      centerTitle: false,
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [],
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
