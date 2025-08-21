// ignore_for_file: library_private_types_in_public_api

// import 'dart:developer';

// import 'dart:developer';
import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/profile/profile_view_model.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_appbar.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';
import 'package:provider/provider.dart';
// import 'package:stacked/stacked.dart';

// import '../../../injectable.dart';
import '../../core/font.dart';
import '../../general_widgets/custom_button.dart';
// import '../routes/app_router.dart';
// import '../routes/app_router.gr.dart';
import '../../routes/app_router.gr.dart';
import '../model/circle_model.dart';

@RoutePage()
class ChhoseYourCircle extends StatefulWidget {
  const ChhoseYourCircle(
      {super.key,
      this.selectedPhoto,
      this.firstName,
      this.dob,
      this.userType,
      this.username,
      required this.gender,
      this.preference,
      required this.relationshipStatus,
      this.address,
      required this.lat,
      required this.long});
  final File? selectedPhoto;
  final String? firstName;
  final String? dob;
  final String gender;
  final String relationshipStatus;
  final String? preference;
  final String? userType;
  final String? username;
  final String? address;
  final num lat, long;

  @override
  State<ChhoseYourCircle> createState() => _ChhoseYourCircleState();
}

class _ChhoseYourCircleState extends State<ChhoseYourCircle> {
  int selectedIndex = -1;
  List<CircleModel> selectedInterests = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
          appBar: const CustomAppBar(
            titleText: "Personal Information",
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.0.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Choose Your Interest",
                          style: TextStyle(
                              fontSize: 26.sp,
                              fontFamily: Font.clashDisplay,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      Text("Specify interests that you might like.",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: const Color(0xFF646464),
                              fontWeight: FontWeight.w400)),
                      SizedBox(
                        height: 40.h,
                      ),
                      // _buildChips(),
                      // Builder(builder: (context) {
                      MultiSelectChip(
                        interests: interests,
                        maxSelection: 5,
                        onSelectionChanged: (selectedList) {
                          setState(() {
                            selectedInterests = selectedList;
                          });
                        },
                      ),
                    ],
                  ),
                  // }),
                  Column(
                    children: [
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.2,
                      // ),
                      CustomButton(
                          onPressed: selectedInterests.length < 5
                              ? null
                              : () async {
                                  await model.updateInterestList(
                                      interests: selectedInterests
                                          .map((e) => e.title ?? "")
                                          .toList());
                                  await model.updateProfile(
                                      preference: widget.preference,
                                      relationship: widget.relationshipStatus,
                                      dob: widget.dob,
                                      usernname: widget.username,
                                      userType: widget.userType,
                                      fullName: widget.firstName,
                                      address: widget.address,
                                      lat: widget.lat,
                                      long: widget.long,
                                      // interests: selectedInterests
                                      //     .map((e) => e.title ?? "")
                                      //     .toList(),
                                      profilePhoto:
                                          widget.selectedPhoto ?? File(""),
                                      gender: widget.gender);
                                  // getIt<AppRouter>().push(const ProfileUpdateSuccessRoute());
                                },
                          height: 60.h,
                          borderRadius: BorderRadius.circular(15.r),
                          // bgColor: const Color(0xFF54848A),
                          child: model.isBusy
                              ? const CircularProgressIndicator()
                              : Text("Done",
                                  style: TextStyle(
                                      fontFamily: Font.rubik,
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400))),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     // model.updateProfile(
                      //     //     preference: widget.preference,
                      //     //     relationship: widget.relationshipStatus,
                      //     //     dob: widget.dob,
                      //     //     usernname: widget.username,
                      //     //     userType: widget.userType,
                      //     //     fullName: widget.firstName,
                      //     //     address: widget.address,
                      //     //     lat: widget.lat,
                      //     //     long: widget.long,
                      //     //     interests: [],
                      //     //     profilePhoto: widget.selectedPhoto ?? File(""),
                      //     //     gender: widget.gender);
                      //     getIt<AppRouter>().push(
                      //         ProfileUpdateSuccessRoute(userType: "user"));
                      //     // getIt<AppRouter>().replace(const BottomNav());
                      //   },
                      //   child: Align(
                      //     child: Text("Skip, I’ll do this later",
                      //         style: TextStyle(
                      //             fontSize: 16.sp,
                      //             fontWeight: FontWeight.w400,
                      //             fontFamily: Font.rubik,
                      //             color: const Color(0xFF838383))),
                      //   ),
                      // ),
                      SizedBox(
                        height: 30.h,
                      )
                    ],
                  )
                ]),
          )),
    );
  }
}

// class MultiSelectChip extends StatefulWidget {
//   final List<CircleModel>? interests;
//   final Function(List<CircleModel>)? onSelectionChanged;
//   final Function(List<CircleModel>)? onMaxSelected;
//   final int? maxSelection;

//   const MultiSelectChip(
//       {super.key,
//       this.onSelectionChanged,
//       this.onMaxSelected,
//       this.maxSelection,
//       this.interests});

//   @override
//   _MultiSelectChipState createState() => _MultiSelectChipState();
// }

// class _MultiSelectChipState extends State<MultiSelectChip> {
//   // String selectedChoice = "";
//   List<CircleModel> selectedChoices = [];

//   _buildChoiceList() {
//     List<Widget> choices = [];

//     widget.interests?.forEach((item) {
//       choices.add(Container(
//         padding: const EdgeInsets.all(2.0),
//         child: ChoiceChip(
//           label: Container(
//             decoration: BoxDecoration(
//                 border: Border.all(
//                     color: selectedChoices.contains(item)
//                         ? Colors.black
//                         : Colors.grey),
//                 borderRadius: BorderRadius.circular(30.r)),
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 10.w),
//               child: Container(
//                 // width: 120.w,
//                 constraints: BoxConstraints(maxWidth: 160.w, minWidth: 50.w),
//                 child: Row(mainAxisSize: MainAxisSize.min, children: [
//                   Image.asset(item.imgUrl ?? ""),
//                   SizedBox(
//                     width: 6.w,
//                   ),
//                   Text(item.title ?? '',
//                       style: TextStyle(
//                           fontFamily: Font.rubik,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w400)),
//                 ]),
//               ),
//             ),
//           ),
//           selected: selectedChoices.contains(item),
//           onSelected: (selected) {
//             if (selectedChoices.length == (widget.maxSelection ?? -1) &&
//                 !selectedChoices.contains(item)) {
//               widget.onMaxSelected?.call(selectedChoices);
//             } else {
//               setState(() {
//                 selectedChoices.contains(item)
//                     ? selectedChoices.remove(item)
//                     : selectedChoices.add(item);
//                 widget.onSelectionChanged?.call(selectedChoices);
//               });
//             }
//           },
//         ),
//       ));
//     });

//     return choices;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       children: _buildChoiceList(),
//     );
//   }
// }

class MultiSelectChip extends StatefulWidget {
  final List<CircleModel>? interests;
  final Function(List<CircleModel>)? onSelectionChanged;
  final Function(List<CircleModel>)? onMaxSelected;
  final int? maxSelection;
  final TextStyle? style;

  const MultiSelectChip(
      {super.key,
      this.onSelectionChanged,
      this.onMaxSelected,
      this.maxSelection,
      this.style,
      this.interests});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<CircleModel> selectedChoices = [];

  void toggleSelection(CircleModel item) {
    setState(() {
      if (selectedChoices.contains(item)) {
        selectedChoices.remove(item);
        widget.onSelectionChanged?.call(selectedChoices);
      } else {
        if (widget.maxSelection == null ||
            selectedChoices.length < widget.maxSelection!) {
          selectedChoices.add(item);
          widget.onSelectionChanged?.call(selectedChoices);
        } else {
          // Do not add the item if max selection is reached
          return;
        }
      }
      widget.onSelectionChanged?.call(selectedChoices);
    });
  }

  _buildChoiceList() {
    List<Widget> choices = [];

    widget.interests?.forEach((item) {
      final isSelected = selectedChoices.contains(item);
      choices.add(GestureDetector(
        onTap: () {
          toggleSelection(item);
          // log(selectedChoices.toString());
        },
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 55.h,
            decoration: BoxDecoration(
              // color: const Color.fromRGBO(236, 88, 115, 0.09),
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : const Color.fromRGBO(0, 0, 0, 0.05),

              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  item.imgUrl == null || item.imgUrl!.isEmpty
                      ? Image.asset("assets/images/pngs/travel.png")
                      : Image.asset(item.imgUrl ?? "", scale: 0.5),
                  SizedBox(width: 6.w),
                  Text(
                    item.title ?? '',
                    style: widget.style ??
                        TextStyle(
                          fontFamily: Font.rubik,
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
