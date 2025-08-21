// import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
import 'package:provider/provider.dart';
// import 'package:stacked/stacked.dart';
// import 'package:ofwhich_v2/presentation/routes/app_router.dart';

import '../../../../application/profile/profile_view_model.dart';
import '../../../core/font.dart';
import '../../../general_widgets/custom_appbar.dart';
import '../../../general_widgets/custom_button.dart';
import '../../../profile/widgets/date_of_birth_textfields.dart';

@RoutePage()
class EditUserAgeScreen extends StatefulWidget {
  const EditUserAgeScreen({
    super.key,
  });

  @override
  State<EditUserAgeScreen> createState() => _EditUserAgeScreenState();
}

class _EditUserAgeScreenState extends State<EditUserAgeScreen> {
  String dob = "";
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
          appBar: OfWhichAppBar(
            titleText: "Edit my age",
            leadingIcon: true,
            backgroundColor: Colors.white,
            onTap: () {},
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    Text("Enter your date of Birth",
                        style: TextStyle(
                            fontFamily: Font.inter,
                            fontSize: 26.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text("User will see only your age.",
                        style: TextStyle(
                            fontFamily: Font.rubik,
                            fontSize: 16.sp,
                            color: const Color(0xFF646464),
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 20.h),
                    DateOfBirthForm(
                      onChanged: (val) {
                        setState(() {
                          dob = val;
                        });
                      },
                    ),
                    SizedBox(height: 10.h),
                    Text("Note: this can only be edited once",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: Font.inter,
                            color: const Color(0xFFFF0000),
                            fontWeight: FontWeight.w400))
                  ],
                ),
                Column(
                  children: [
                    CustomButton(
                      height: 60.h,
                      borderRadius: BorderRadius.circular(10.r),
                      width: MediaQuery.of(context).size.width,
                      onPressed:
                          // model.isEditNameButtonActive
                          // ?
                          () {
                        // getIt<AppRouter>().push(GenderRoute(
                        //     selectedPhoto: widget.selectedPhoto,
                        //     firstName: widget.firstName,
                        //     dob: dob));
                        _showAlertDialog(context, model: model);
                      },
                      // : null,
                      child: Text("Next",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontFamily: Font.inter,
                              fontWeight: FontWeight.w400)),
                    ),
                    SizedBox(height: 20.h)
                  ],
                ),
              ],
            ),
          )),
    );
  }

  void _showAlertDialog(BuildContext context,
      {required ProfileViewModel model}) {
    int age = calculateUserAge(date: dob);
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('Are you $age year(s)'),
        content: const Text('Make sure that your age is correct'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Change'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              model.editProfile(
                  dob: dob,
                  navigate: () {
                    getIt<AppRouter>().replace(const UserProfileDetails());
                  });
            },
            child: const Text('Accept'),
          ),
        ],
      ),
    );
  }

  int calculateUserAge({required String? date}) {
    List<String> parts = date!.split('-');
    int birthYear = int.parse(parts[0]);
    int birthMonth = int.parse(parts[1]);
    int birthDay = int.parse(parts[2]);

    DateTime birthDate = DateTime(birthYear, birthMonth, birthDay);
    DateTime currentDate = DateTime.now();

    int age = currentDate.year - birthDate.year;

    // Check if the birthday hasn't occurred yet this year
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    // if (kDebugMode) {
    //   print('Age: $age');
    // }
    return age;
  }
}
