// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';

class CustomBottomNavItem extends StatefulWidget {
  final String? icon;
  final String? title;
  final String? iconActive;
  final bool isSelected;
  final Function? onTap;
  final bool isThird;
  final double? iconHeight;
  final double? iconWidth;
  // final Color? color;
  const CustomBottomNavItem(
      {
      // @required this.title,
      Key? key,
      required this.icon,
      required this.iconActive,
      this.isSelected = false,
      required this.onTap,
      this.isThird = false,
      // this.color,
      this.title,
      this.iconHeight,
      this.iconWidth})
      : super(key: key);

  @override
  _CustomBottomNavItemState createState() => _CustomBottomNavItemState();
}

class _CustomBottomNavItemState extends State<CustomBottomNavItem> {
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return InkWell(
        onTap: () {
          widget.onTap!();
        },
        child: Container(
           //color: Colors.blue,
          height: 58.h,
          width: 58.w,
          // width: 60.w,
          // width: size.width / 3.4,
          child: Stack(
            alignment: Alignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: widget.iconHeight ?? 58.h,
                width: widget.iconWidth ?? 58.w,
                decoration: BoxDecoration(color: widget.isSelected ?  Theme.of(context).primaryColor: Color.fromRGBO(0, 0, 0, 0.05),borderRadius: BorderRadius.all(Radius.circular(30.r))) ,
                child: Image.asset(
                  widget.icon!,
                  // height: 40.h,
                  //fit: BoxFit.contain,
                  color: !widget.isThird
                      ? widget.isSelected
                          ? Colors.white
                          : Colors.black
                      : null,
                ),
              ),
              
            ],
          ),
        ));
  }
}
