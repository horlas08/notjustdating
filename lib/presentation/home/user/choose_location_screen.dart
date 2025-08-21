import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ofwhich_v2/domain/user_service/model/user_object.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_appbar.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_button.dart';
import 'package:ofwhich_v2/presentation/home/user/choose_budget_screen.dart';
import 'package:ofwhich_v2/presentation/home/user/matched_profile.dart';
import 'package:ofwhich_v2/presentation/home/user/widgets/add_location_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseLocationScreen extends StatefulWidget {
  final UserModel profile;
  const ChooseLocationScreen({super.key, required this.profile});

  @override
  State<ChooseLocationScreen> createState() => _ChooseLocationScreenState();
}

class _ChooseLocationScreenState extends State<ChooseLocationScreen> {
  final List<Map<String, String>> selectedLocations = [];

  void _openLocationPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CountryStatePickerModal(
          onSelected: (country, state) {
            if (state != null && state.isNotEmpty) {
              setState(() {
                selectedLocations.add({
                  "title": state,
                  "location": "$state, $country",
                });
              });
            } else {
              setState(() {
                selectedLocations.add({
                  "title": country,
                  "location": country,
                });
              });
            }
          },
        );
      },
    );
  }

  void _removeLocation(int index) {
    setState(() {
      selectedLocations.removeAt(index);
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
            SizedBox(height: 36.h),
            Text(
              "Choose your location",
              style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5.h),
            Text(
              "Let’s find your unforgettable date, choose three(3) location you’ll love the date to hold.",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 35.h),

            // Add Location Button
            InkWell(
              onTap: _openLocationPicker,
              child: _addLocation(),
            ),

            dividerGap(),

            Text(
              "Selected locations",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 19.h),

            // Dynamic Location List
            Expanded(
              child: ListView.builder(
                itemCount: selectedLocations.length,
                itemBuilder: (context, index) {
                  final item = selectedLocations[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 19.h),
                    child: _locationTile(
                      item["title"]!,
                      item["location"]!,
                      () => _removeLocation(index),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 35.h),

            // Next Button
            CustomButton(
              height: 56.h,
              borderRadius: BorderRadius.circular(15.r),
              width: MediaQuery.of(context).size.width,
              onPressed: () {
                if(selectedLocations.isNotEmpty){
                       Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChooseBudgetScreen(profile: widget.profile,),
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
             SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }

  Widget _locationTile(String title, String location, VoidCallback onDelete) {
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
              border: Border.all(color: const Color.fromRGBO(191, 191, 191, 1)),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Image.asset(
              "assets/images/pngs/map.png",
              fit: BoxFit.cover,
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
                  location,
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

  Widget _addLocation() {
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
              "Add a Location",
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




// Widget backButton(){
//   return Container(
//     decoration: BoxDecoration(
//       color: Colors.black.withOpacity(0.05),
//       borderRadius: BorderRadius.all(Radius.circular(20))
//     ),
// child: Image.asset("assets/images/svgs/back_button.svg",height: 20.h,width: 20.w,),
//   );
// }

// Widget nextButton(){

// }