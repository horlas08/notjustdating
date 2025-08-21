import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/profile/profile_view_model.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../general_widgets/custom_appbar.dart';
import '../../../profile/user/choose_your_circle.dart';
import '../../../profile/model/circle_model.dart';
// import '../widgets/multiple_chips.dart';

@RoutePage()
class EditInterest extends StatefulWidget {
  const EditInterest({super.key});

  @override
  State<EditInterest> createState() => _EditInterestState();
}

class _EditInterestState extends State<EditInterest> {
  bool isHobbiesExpanded = false;
  bool isMusicExpanded = false;
  bool isPetsExpanded = false;
  bool isSportExpanded = false;
  final Map<String, List<String>> interests = {
    'Hobbies': [
      'Reading',
      'Gardening',
      'Photography',
      'Cooking',
      'Traveling',
      'Drawing',
      'Writing',
      'Dancing',
      'Knitting',
      'Fishing',
      'Woodworking',
      'Pottery',
      'Scrapbooking',
      'Birdwatching',
      'Collecting',
      'Hiking',
      'Baking',
      'Painting',
      'Sewing',
      'Cycling'
    ],
    'Sport': [
      'Soccer',
      'Basketball',
      'Tennis',
      'Cricket',
      'Running',
      'Cycling',
      'Swimming',
      'Baseball',
      'Golf',
      'Hiking',
      'Boxing',
      'MMA',
      'Rugby',
      'Skiing',
      'Surfing',
      'Skateboarding',
      'Rock Climbing',
      'Horseback Riding',
      'Archery',
      'Badminton'
    ],
    'Music': [
      'Rock',
      'Jazz',
      'Classical',
      'Pop',
      'Hip-Hop',
      'Country',
      'Blues',
      'Electronic',
      'Reggae',
      'Opera',
      'Indie',
      'Folk',
      'Metal',
      'Punk',
      'Soul',
      'R&B',
      'Gospel',
      'K-Pop',
      'Latin',
      'Disco'
    ],
    'Pet': [
      'Dogs',
      'Cats',
      'Birds',
      'Fish',
      'Hamsters',
      'Rabbits',
      'Reptiles',
      'Horses',
      'Ferrets',
      'Guinea Pigs',
      'Parrots',
      'Turtles',
      'Snakes',
      'Chinchillas',
      'Gerbils',
      'Lizards',
      'Frogs',
      'Hedgehogs',
      'Goats',
      'Pigs'
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
          appBar: const OfWhichAppBar(
            titleText: "Edit My Interest",
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    // height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0.r, vertical: 15.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hobbies",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: Font.inter)),
                          SizedBox(height: 15.h),
                          MultiSelectChip(
                            style: TextStyle(
                                fontFamily: Font.rubik,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFEC5873)),
                            onSelectionChanged: (val) {
                              var result = val.map((e) => e.title!);
                              model.interestList.addAll(result);
                              log(model.interestList.toString());
                            },
                            maxSelection: 3,
                            interests: isHobbiesExpanded
                                ? interests["Hobbies"]!
                                    .map((e) => CircleModel(title: e))
                                    .toList()
                                : interests["Hobbies"]!
                                    .sublist(0, 5)
                                    .map((e) => CircleModel(title: e))
                                    .toList(),
                          ),
                          SizedBox(height: 15.h),
                          Align(
                              child: InkWell(
                            onTap: () {
                              setState(() {
                                isHobbiesExpanded = !isHobbiesExpanded;
                              });
                            },
                            child: Text(
                                isHobbiesExpanded ? "Show Less" : "Show More",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF4A4A4A),
                                    fontSize: 14.sp,
                                    fontFamily: Font.inter)),
                          ))
                        ],
                      ),
                    )),
                SizedBox(height: 20.h),
                AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    // height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0.r, vertical: 15.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Music",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: Font.inter)),
                          SizedBox(height: 15.h),
                          MultiSelectChip(
                            style: TextStyle(
                                fontFamily: Font.rubik,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFEC5873)),
                            onSelectionChanged: (val) {},
                            maxSelection: 3,
                            interests: isSportExpanded
                                ? interests["Music"]!
                                    .map((e) => CircleModel(title: e))
                                    .toList()
                                : interests["Music"]!
                                    .sublist(0, 5)
                                    .map((e) => CircleModel(title: e))
                                    .toList(),
                          ),
                          SizedBox(height: 15.h),
                          Align(
                              child: InkWell(
                            onTap: () {
                              setState(() {
                                isSportExpanded = !isSportExpanded;
                              });
                            },
                            child: Text(
                                isSportExpanded ? "Show Less" : "Show More",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF4A4A4A),
                                    fontSize: 14.sp,
                                    fontFamily: Font.inter)),
                          ))
                        ],
                      ),
                    )),
                SizedBox(height: 20.h),
                AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    // height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0.r, vertical: 15.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Sport",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: Font.inter)),
                          SizedBox(height: 15.h),
                          MultiSelectChip(
                            style: TextStyle(
                                fontFamily: Font.rubik,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFEC5873)),
                            onSelectionChanged: (val) {},
                            maxSelection: 3,
                            interests: isMusicExpanded
                                ? interests["Sport"]!
                                    .map((e) => CircleModel(title: e))
                                    .toList()
                                : interests["Sport"]!
                                    .sublist(0, 5)
                                    .map((e) => CircleModel(title: e))
                                    .toList(),
                          ),
                          SizedBox(height: 15.h),
                          Align(
                              child: InkWell(
                            onTap: () {
                              setState(() {
                                isMusicExpanded = !isMusicExpanded;
                              });
                            },
                            child: Text(
                                isMusicExpanded ? "Show Less" : "Show More",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF4A4A4A),
                                    fontSize: 14.sp,
                                    fontFamily: Font.inter)),
                          ))
                        ],
                      ),
                    )),
                SizedBox(height: 20.h),
                AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    // height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0.r, vertical: 15.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pet",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: Font.inter)),
                          SizedBox(height: 15.h),
                          MultiSelectChip(
                            style: TextStyle(
                                fontFamily: Font.rubik,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFEC5873)),
                            onSelectionChanged: (val) {},
                            maxSelection: 3,
                            interests: isPetsExpanded
                                ? interests["Pet"]!
                                    .map((e) => CircleModel(title: e))
                                    .toList()
                                : interests["Pet"]!
                                    .sublist(0, 5)
                                    .map((e) => CircleModel(title: e))
                                    .toList(),
                          ),
                          SizedBox(height: 15.h),
                          Align(
                              child: InkWell(
                            onTap: () {
                              setState(() {
                                isPetsExpanded = !isPetsExpanded;
                              });
                            },
                            child: Text(
                                isPetsExpanded ? "Show Less" : "Show More",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF4A4A4A),
                                    fontSize: 14.sp,
                                    fontFamily: Font.inter)),
                          ))
                        ],
                      ),
                    )),
              ],
            ),
          ))),
    );
  }
}
