import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/font.dart';
import '../../general_widgets/app_back_button.dart';

// import 'package:ofwhich/presentation/routes/app_router.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar(
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
      this.topMargin,
      this.child});
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
  final Widget? child;
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
            Expanded(
              child: Visibility(
                visible: leadingIcon == true ? true : false,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(
                        top: height == null ? 0 : 25.h,
                      ),
                      child: const AppBackButton()),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(
                    top: height == null ? 0 : 25.h,
                  ),
                  child: child ??
                      Text(titleText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: const Color(0xFF535353),
                              fontSize: 18.sp,
                              fontFamily: Font.inter,
                              fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            // showShare == false
            //     ? Expanded(
            //         flex: 2,
            //         child: children.isEmpty
            //             ? Container()
            //             : Container(
            //                 margin: EdgeInsets.only(
            //                   top: topMargin ?? 20.h,
            //                 ),
            //                 padding: EdgeInsets.symmetric(
            //                   // horizontal: 15.w,
            //                   vertical: 5.h,
            //                 ),
            //                 child: Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: children),
            //               ),
            //       )
            //     : Container(
            //         margin: EdgeInsets.only(
            //           top: 25.h,
            //         ),
            //         child: InkWell(
            //           onTap: onTapShare,
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Container(
            //               padding: EdgeInsets.symmetric(
            //                 horizontal: 15.w,
            //                 vertical: 5.h,
            //               ),
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10),
            //                 // color: AltBankColor.dAltBkGold900,
            //               ),
            //               // onPressed: () {},
            //               child: const Text(
            //                 "Share",
            //                 // style: AltBankTextStyle.p1.copyWith(
            //                 //   color: AltBankColor.dAltBkWhite,
            //                 // ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 65.h);
}
