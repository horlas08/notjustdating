import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../injectable.dart';
import '../../core/font.dart';
import '../../general_widgets/custom_appbar.dart';
import '../../general_widgets/custom_button.dart';
import '../../routes/app_router.dart';
import '../../routes/app_router.gr.dart';
import '../widgets/date_of_birth_textfields.dart';

@RoutePage()
class DateOfBirthScreen extends StatefulWidget {
  const DateOfBirthScreen(
      {super.key,
      this.selectedPhoto,
      this.firstName,
      required this.userType,
      this.usernname});
  final File? selectedPhoto;
  final String? firstName;
  final String? usernname;
  final String userType;

  @override
  State<DateOfBirthScreen> createState() => _DateOfBirthScreenState();
}

class _DateOfBirthScreenState extends State<DateOfBirthScreen> {
  String dob = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          titleText: "Personal Information",
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
                    height: 5.h,
                  ),
                  Text("User will see only your age.",
                      style: TextStyle(
                          fontFamily: Font.inter,
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)),
                  SizedBox(height: 35.h),
                  Text(
                    "Date of birth",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: Font.inter,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 10.h),
                  DateOfBirthForm(
                    onChanged: (val) {
                      setState(() {
                        dob = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  CustomButton(
                    height: 60.h,
                    borderRadius: BorderRadius.circular(15.r),
                    width: MediaQuery.of(context).size.width,
                    onPressed:
                        // model.isEditNameButtonActive
                        // ?
                        () {
                      // _showAlertDialog(context);
                      showAgeConfirmationDialog(
                          context, calculateUserAge(date: dob));
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
              // Column(
              //   children: [],
              // ),
            ],
          ),
        ));
  }

  void _showAlertDialog(BuildContext context) {
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
              log("firstName :::: ${widget.firstName}");
              log("username:::::${widget.userType}");
              getIt<AppRouter>().push(GenderRoute(
                  selectedPhoto: widget.selectedPhoto,
                  firstName: widget.firstName,
                  username: widget.usernname,
                  userType: widget.userType,
                  dob: dob));
            },
            child: const Text('Accept'),
          ),
        ],
      ),
    );
  }

  int calculateUserAge({required String? date}) {
    List<String> parts = date!.split('-');
    int birthDay = int.parse(parts[2]);
    int birthMonth = int.parse(parts[1]);
    int birthYear = int.parse(parts[0]);

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
    // }
  }

  void showAgeConfirmationDialog(BuildContext context, int age) {
    showDialog(
      context: context,
      builder: (context) => AgeConfirmationDialog(
        age: age,
        onAccept: () {
          Navigator.pop(context);
          getIt<AppRouter>().push(GenderRoute(
              selectedPhoto: widget.selectedPhoto,
              firstName: widget.firstName,
              username: widget.usernname,
              userType: widget.userType,
              dob: dob));
          // Handle accept logic
        },
        onChange: () {
          Navigator.pop(context);
          // Handle change logic
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';

class AgeConfirmationDialog extends StatelessWidget {
  final int age;
  final VoidCallback onAccept;
  final VoidCallback onChange;

  const AgeConfirmationDialog({
    super.key,
    required this.age,
    required this.onAccept,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Cake icon
            Container(
              padding: const EdgeInsets.all(16),
              child: SvgPicture.asset('assets/images/svgs/cake.svg'),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              'Are you $age years old?',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              'Are you sure this is your correct age as you can’t change it later',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 24),

            // Accept button
            SizedBox(
              width: double.infinity,
              // height: MediaQuery.sizeOf(context).height * 0.06,
              child: ElevatedButton(
                onPressed: onAccept,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Accept'),
              ),
            ),
            const SizedBox(height: 12),

            // Change button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onChange,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Change'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
