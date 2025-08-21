import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../injectable.dart';
import '../core/font.dart';
import '../general_widgets/app_back_button.dart';
import '../general_widgets/custom_button.dart';
import '../routes/app_router.dart';
import '../routes/app_router.gr.dart';
import 'model/user_type.dart';

@RoutePage()
class UserTypeSelectionScreen extends StatefulWidget {
  const UserTypeSelectionScreen({super.key});

  @override
  State<UserTypeSelectionScreen> createState() =>
      _UserTypeSelectionScreenState();
}

class _UserTypeSelectionScreenState extends State<UserTypeSelectionScreen> {
  int currentIndex = -1;
  String? selectedUserType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const AppBackButton(),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text("Select an account",
                      style: TextStyle(
                          fontSize: 18.sp, color: const Color(0xFF535353))),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Text("Select user type",
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontFamily: Font.inter,
                      color: Colors.black,
                      fontWeight: FontWeight.w700)),
              SizedBox(
                height: 6.h,
              ),
              Text("Tell us why you are here on Ofwhich.",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF646464),
                      fontFamily: Font.inter,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.32,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 10.w,
                    );
                  },
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: userTypes.length,
                  itemBuilder: (context, index) {
                    UserType userType = userTypes[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      child: SelectionWidget(
                        isSelected: currentIndex == index,
                        title: userType.title,
                        subTitle: userType.subTitle,
                        iconUrl: userType.iconUrl,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Column(
            children: [
              CustomButton(
                onPressed: currentIndex == -1
                    ? null
                    : () {
                        switch (currentIndex) {
                          case 0:
                            setState(() {
                              selectedUserType = "user";
                            });
                            break;
                          case 1:
                            setState(() {
                              selectedUserType = "content-creator";
                            });
                          default:
                        }

                        getIt<AppRouter>().replace(RegisterRoute(
                            userType: selectedUserType ?? "user"));
                      },
                height: 65.h,
                borderRadius: BorderRadius.circular(10.r),
                width: MediaQuery.of(context).size.width,
                child: Text("Continue",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: Font.inter,
                        color: Colors.white,
                        fontSize: 16.sp)),
              ),
              SizedBox(
                height: 40.h,
              )
            ],
          )
        ],
      ),
    ));
  }
}

class SelectionWidget extends StatefulWidget {
  const SelectionWidget({
    Key? key,
    required this.iconUrl,
    required this.title,
    required this.subTitle,
    required this.isSelected,
  }) : super(key: key);
  final String iconUrl;
  final String title;
  final String subTitle;
  final bool isSelected;

  @override
  State<SelectionWidget> createState() => _SelectionWidgetState();
}

class _SelectionWidgetState extends State<SelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.31,
      width: MediaQuery.of(context).size.width * 0.42,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
              color: widget.isSelected
                  ? Theme.of(context).primaryColor
                  : const Color(0xFFCACACA))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Image.asset(widget.iconUrl),
            SizedBox(
              height: 10.h,
            ),
            Text(widget.title,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: Font.inter,
                    fontWeight: FontWeight.w600)),
            SizedBox(
              height: 10.h,
            ),
            Text(widget.subTitle,
                style: TextStyle(
                    color: const Color(0xFF646464),
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    fontFamily: Font.rubik)),
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: widget.isSelected
                  ? Image.asset("assets/images/pngs/selection_circle.png")
                  : Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE3E3E3)),
                          shape: BoxShape.circle),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
