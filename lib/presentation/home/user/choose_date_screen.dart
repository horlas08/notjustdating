import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ofwhich_v2/domain/user_service/model/user_object.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_appbar.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_button.dart';
import 'package:ofwhich_v2/presentation/home/user/make_payment_screen.dart';
import 'package:ofwhich_v2/presentation/home/user/matched_profile.dart';
import 'package:ofwhich_v2/presentation/home/user/widgets/cards_stack_widget.dart';
import 'package:ofwhich_v2/presentation/home/user/widgets/date_time_picker_screen.dart';

class ChooseDateScreen extends StatefulWidget {
  final UserModel profile;
  const ChooseDateScreen({super.key, required this.profile});

  @override
  State<ChooseDateScreen> createState() => _ChooseDateScreenState();
}

class _ChooseDateScreenState extends State<ChooseDateScreen> {
  final List<Map<String, String>> selectedDates = [];

  void _openDatePicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.95, // 80% height
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            child: CustomDateTimePicker(
              onSelected: (time, date) {
                setState(() {
                  selectedDates.add({
                    "time": time,
                    "date": date,
                  });
                });
                //  Navigator.pop(context); // close after selection
              },
            ),
          ),
        );
      },
    );
  }

  void _removeDate(int index) {
    setState(() {
      selectedDates.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OfWhichAppBar(
        titleText: "Plan a Date",
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 26.h),
            Text(
              "Choose date and time",
              style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5.h),
            Text(
              "Set your availability for your date",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 35.h),
            InkWell(
              onTap: _openDatePicker,
              child: _addDate(),
            ),
            dividerGap(),
            Text(
              "Selected date and time",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 19.h),
            Expanded(
              child: ListView.builder(
                itemCount: selectedDates.length,
                itemBuilder: (context, index) {
                  final item = selectedDates[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 19.h),
                    child: _dateTile(
                      item["time"]!,
                      item["date"]!,
                      () => _removeDate(index),
                    ),
                  );
                },
              ),
            ),
            CustomButton(
              height: 56.h,
              borderRadius: BorderRadius.circular(15.r),
              width: MediaQuery.of(context).size.width,
              onPressed: () async {
                if (selectedDates.isNotEmpty) {
                  final authUser = await getUserSavedLocally();
                  if (!context.mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MakePaymentScreen(
                        profile: widget.profile,
                        authUser: authUser!,
                      ),
                    ),
                  );
                }
              },
              child: Text(
                "Next",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontFamily: Font.inter,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            )
          ],
        ),
      ),
    );
  }

  Widget _dateTile(String title, String date, VoidCallback onDelete) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(182, 182, 182, 1)),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Container(
            height: 86.h,
            width: 86.w,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 191, 202, 0.5),
              border: Border.all(color: const Color.fromRGBO(191, 191, 191, 1)),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Image.asset(
              "assets/images/pngs/calender.png",
              height: 42.h,
              width: 42.w,
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 6.h),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(82, 82, 82, 1),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onDelete,
            child: SvgPicture.asset(
              "assets/images/svgs/delete_icon.svg",
              height: 24.h,
              width: 24.w,
            ),
          ),
        ],
      ),
    );
  }

  Widget _addDate() {
    return Container(
      height: 59.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.02),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "-select date & time",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
          ),
          SvgPicture.asset(
            "assets/images/svgs/plus_icon.svg",
            height: 24.h,
            width: 24.w,
          ),
        ],
      ),
    );
  }
}
