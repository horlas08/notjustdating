import 'dart:developer';
import 'dart:io';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';

import '../../application/profile/profile_view_model.dart';
import '../../injectable.dart';
import '../core/font.dart';

class ImageSelection extends StatefulWidget {
  const ImageSelection({super.key});

  @override
  State<ImageSelection> createState() => _ImageSelectionState();
}

class _ImageSelectionState extends State<ImageSelection> {
  File? selectedPhoto;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.w),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.17,
        child: Column(
          children: [
            InkResponse(
              onTap: () async {
                selectedPhoto =
                    await getIt<ProfileViewModel>().selextImage(type: "camera");
                Navigator.pop(context);
                // getIt<AppRouter>().pop(selectedPhoto);
                log(selectedPhoto?.path ?? "Emtpy");
              },
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/pngs/camera_icon.png",
                    scale: 1.5,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "Open camera",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: Font.inter,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
                height: 10.h,
                width: MediaQuery.of(context).size.width,
                child: const Divider()),
            SizedBox(height: 20.h),
            InkResponse(
              onTap: () async {
                selectedPhoto =
                    await getIt<ProfileViewModel>().selextImage(type: "camera");
                if (context.mounted) {
                  Navigator.pop(context);
                }
                // getIt<AppRouter>().pop(selectedPhoto);
              },
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/pngs/gallery_icon.png",
                    scale: 1.5,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "Choose from gallery",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: Font.inter,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

class Util {
  static String formatData({required int dateString}) {
    // int timeStamp = int.parse(dateString);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dateString);

    // Determine if it's AM or PM
    String period = dateTime.hour >= 12 ? 'PM' : 'AM';

    // Convert hour to 12-hour format
    int hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;

    // Format the date and time as dd-mm-yyyy hh:mm AM/PM
    String formattedDate =
        // '${dateTime.day.toString().padLeft(2, '0')}-'
        //                        '${dateTime.month.toString().padLeft(2, '0')}-'
        //                        '${dateTime.year} '
        '${hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')} $period';

    // print(formattedDate); // Output: 10-09-2024 01:11 AM
    return formattedDate; // Output: 10-09-2024 01:11
  }
}
