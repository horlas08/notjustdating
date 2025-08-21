import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ofwhich_v2/presentation/home/user/matched_profile.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomDateTimePicker extends StatefulWidget {
  final void Function(dynamic, dynamic) onSelected;

  const CustomDateTimePicker({super.key, required this.onSelected});
  @override
  _CustomDateTimePickerState createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  String selectedHour = "12";
  String selectedMinute = "00";
  String selectedPeriod = "AM";

  List<String> hours =
      List.generate(12, (i) => (i + 1).toString().padLeft(2, '0'));
  List<String> minutes = List.generate(60, (i) => i.toString().padLeft(2, '0'));
  List<String> periods = ["AM", "PM"];

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70.h),

            /// Title
            Text(
              "Choose date & time",
              style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5.h),
            Text(
              "Pick a date and time suitable for your date",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),

            SizedBox(height: 35.h),

            /// Custom Calendar Header (Month + Chevron buttons)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "${_monthName(_focusedDay.month)} ${_focusedDay.year}",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.chevron_left, color: Colors.black),
                    onPressed: () {
                      setState(() {
                        _focusedDay = DateTime(
                            _focusedDay.year, _focusedDay.month - 1, 1);
                      });
                    },
                  ),
                ),
                SizedBox(width: 4.w),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(236, 88, 115, 1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.chevron_right, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _focusedDay = DateTime(
                            _focusedDay.year, _focusedDay.month + 1, 1);
                      });
                    },
                  ),
                ),
                SizedBox(width: 8.w),
              ],
            ),

            /// Calendar widget
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              headerVisible: false,
              // calendarStyle: const CalendarStyle(
              //   selectedDecoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: Color.fromRGBO(236, 88, 115, 1),
              //     // borderRadius: BorderRadius.all(Radius.circular(10)),
              //   ),
              // ),

              // calendarStyle: const CalendarStyle(
              //   selectedDecoration: BoxDecoration(
              //     shape: BoxShape
              //         .rectangle, // Use rectangle for custom border radius
              //     color: Color.fromRGBO(236, 88, 115, 1),
              //     borderRadius: BorderRadius.all(Radius.circular(10)),
              //   ),
              // ),

              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Color.fromRGBO(236, 88, 115, 1),
                ),
                selectedTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            dividerGap(),

            /// Time Picker Label
            Text(
              "Choose time",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 22.h),

            /// Time Picker Dropdowns
            /// Time Picker Dropdowns
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Hour Dropdown
                Material(
                  color: Colors.transparent,
                  child: Container(
                    height: 59.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                      color: Colors.white,
                    ),
                    child: DropdownButton<String>(
                      value: selectedHour,
                      isExpanded: true,
                      underline: SizedBox(),
                      icon: Icon(Icons.keyboard_arrow_down, size: 20),
                      dropdownColor: Colors.white,
                      items: hours.map((hour) {
                        return DropdownMenuItem(
                          value: hour,
                          child: Center(
                            child:
                                Text(hour, style: TextStyle(fontSize: 16.sp)),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => selectedHour = value!);
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10),

                /// Minute Dropdown
                Material(
                  color: Colors.transparent,
                  child: Container(
                    height: 59.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                      color: Colors.white,
                    ),
                    child: DropdownButton<String>(
                      value: selectedMinute,
                      isExpanded: true,
                      underline: SizedBox(),
                      icon: Icon(Icons.keyboard_arrow_down, size: 20),
                      dropdownColor: Colors.white,
                      items: minutes.map((minute) {
                        return DropdownMenuItem(
                          value: minute,
                          child: Center(
                            child:
                                Text(minute, style: TextStyle(fontSize: 16.sp)),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => selectedMinute = value!);
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10),

                /// AM/PM Dropdown
                Material(
                  color: Colors.transparent,
                  child: Container(
                    height: 59.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                      color: Colors.white,
                    ),
                    child: DropdownButton<String>(
                      value: selectedPeriod,
                      isExpanded: true,
                      underline: SizedBox(),
                      icon: Icon(Icons.keyboard_arrow_down, size: 20),
                      dropdownColor: Colors.white,
                      items: periods.map((period) {
                        return DropdownMenuItem(
                          value: period,
                          child: Center(
                            child:
                                Text(period, style: TextStyle(fontSize: 16.sp)),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => selectedPeriod = value!);
                      },
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(236, 88, 115, 1),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  final int hour = int.parse(selectedHour) % 12 +
                      (selectedPeriod == "PM" ? 12 : 0);
                  final int minute = int.parse(selectedMinute);

                  final DateTime finalDateTime = DateTime(
                    _selectedDay!.year,
                    _selectedDay!.month,
                    _selectedDay!.day,
                    hour,
                    minute,
                  );
                  final String formattedHour =
                      finalDateTime.hour.toString().padLeft(2, '0');
                  final String formattedMinute =
                      finalDateTime.minute.toString().padLeft(2, '0');

                  final String time =
                      "$formattedHour:$formattedMinute ${selectedPeriod}(GMT+1)";
                  final String date = formatDateWithSuffix(_selectedDay!);

                  print("Selected DateTime: $finalDateTime");
                  widget.onSelected(time, date);

                  Navigator.pop(context);
                },
                child: Text(
                  "Set available date",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDateWithSuffix(DateTime date) {
    // Get day with suffix
    String daySuffix(int dayNum) {
      if (dayNum >= 11 && dayNum <= 13)
        return "th"; // Special case for 11th–13th
      switch (dayNum % 10) {
        case 1:
          return "st";
        case 2:
          return "nd";
        case 3:
          return "rd";
        default:
          return "th";
      }
    }

    String day = date.day.toString();
    String suffix = daySuffix(date.day);
    String month = DateFormat('MMMM').format(date); // September
    String year = date.year.toString();
    String weekday = DateFormat('EEEE').format(date); // Tuesday

    return "$day$suffix $month, $year, $weekday";
  }
}
