// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/post_view_model/content_creator/post_view_model.dart';
import 'package:ofwhich_v2/domain/auth/models/location_model.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_drop_down.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../../application/home_view_model/home_view_model.dart';
import '../../../../injectable.dart';
import '../../../core/font.dart';
import '../../../general_widgets/custom_button.dart';
// import '../../../general_widgets/custom_textfield.dart';
import '../constants/constants.dart';

import 'double_sided_slider.dart';
import 'filter_title.dart';

class FilterWidget extends StatefulWidget {
  final HomeViewModel homeViewModel;
  const FilterWidget({super.key, required this.homeViewModel});
  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  int selectedIndex = 0;
  int selectedSorting = 0;
  RangeValues? distanceRange;
  RangeValues? ageRange;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<HomeViewModel>().getSavedFilterValues();
    });
    // getIt<HomeViewModel>().getSavedFilterValues();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      // viewModelBuilder: () => getIt<HomeViewModel>(),
      builder: (context, parentModel, child) => FractionallySizedBox(
        heightFactor: 0.9,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0.w),
                    child: Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color:
                            const Color(0xFF535353), // Ensures consistent color
                        decoration: TextDecoration.none, // No underline
                      ),
                    ),
                  ),
                ),
                // CustomTextFieldWidget(
                //   label: "Location",
                //   contentPadding: EdgeInsets.zero,
                //   fillColor: Colors.grey[100],
                //   filled: true,
                //   labelTextStyle: TextStyle(
                //       fontFamily: Font.rubik,
                //       fontSize: 15.sp,
                //       color: const Color(0xFF535353)),
                //   hintText: "Lagos,Ogudu",
                //   hintStyle: TextStyle(
                //       fontFamily: Font.inter,
                //       fontSize: 14.5.sp,
                //       color: const Color(0xFF434343)),
                // ),
                ViewModelBuilder<PostViewModel>.reactive(
                  viewModelBuilder: () => getIt<PostViewModel>(),
                  onViewModelReady: (c) {
                    c.getLocations();
                  },
                  builder: (context, model, child) => CustomDropdown(
                    useParent: true,
                    borderColor: Colors.grey.shade300,
                    label: "Location",
                    child: DropdownButton<LocationModel>(
                      isExpanded: true,
                      value: parentModel.selectedLocation,

                      hint: const Text('Lagos,Ogudu'),
                      iconSize: 15,
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      // itemHeight: 300,
                      elevation: 0,
                      style: const TextStyle(color: Colors.black),
                      dropdownColor: Colors.white,
                      items: model.locations.map((value) {
                        return DropdownMenuItem<LocationModel>(
                          value: value,
                          child: Text(
                            value.name,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        parentModel.setSelectedLocation(newValue);
                        // setState(() {
                        //   model.drop2SelectedValue = newValue;
                        // });
                      },
                    ),
                  ),
                ),

                SizedBox(height: 15.h),
                const FilterTtitle(
                  title: "My Interests",
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: interestTypes.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: Container(
                            alignment: Alignment.center,
                            // height: 50.h,
                            decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0.w, vertical: 5.w),
                              child: Text(interestTypes[index],
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: Font.rubik,
                                      color: selectedIndex == index
                                          ? Colors.white
                                          : const Color(0xFF3D3D3D))),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                const FilterTtitle(
                  title: "Sort By",
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: sortBBy.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSorting = index;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: Container(
                            alignment: Alignment.center,
                            // height: 50.h,
                            decoration: BoxDecoration(
                                color: selectedSorting == index
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0.w, vertical: 5.w),
                              child: Text(sortBBy[index],
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: Font.rubik,
                                      color: selectedSorting == index
                                          ? Colors.white
                                          : const Color(0xFF3D3D3D))),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                const FilterTtitle(
                  title: "Distance",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                  child: CustomRangeSlider(
                    division: 10,
                    minValue: 0,
                    maxValue: 100,
                    startValue: (parentModel.filterDataModel?.radiusStart ?? 20)
                        .toDouble(),
                    endValue: (parentModel.filterDataModel?.radiusEnd ?? 80)
                        .toDouble(),
                    multiplierValue: 1,
                    stepSize: 2, //
                    // minValue: 0,
                    // maxValue: 25,
                    // startValue: 5.0,
                    // endValue: 25.0,
                    // multiplierValue: 5.0,
                    // division: 5,
                    onChange: (val) {
                      setState(() {
                        distanceRange = val;
                      });
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                const FilterTtitle(
                  title: "Age",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                  child: CustomRangeSlider(
                    division: 10,
                    minValue: 18,
                    maxValue: 80,
                    // startValue: 18,
                    // endValue: 80,

                    startValue:
                        (parentModel.filterDataModel?.ageRangeStart ?? 18)
                            .toDouble(),
                    endValue: (parentModel.filterDataModel?.ageRangeEnd ?? 80)
                        .toDouble(),
                    multiplierValue: 1,
                    stepSize: 2, //
                    isType1: false,
                    onChange: (val) {
                      setState(() {
                        ageRange = val;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      bgColor: const Color(0xFfEAEAEA),
                      borderRadius: BorderRadius.circular(20.r),
                      height: MediaQuery.sizeOf(context).height * 0.08,
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      onPressed: () {
                        parentModel.getFeed();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Reset Filter",
                        style: TextStyle(
                            color: const Color(0xFF7E7E7E),
                            fontFamily: Font.inter,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    CustomButton(
                      borderRadius: BorderRadius.circular(20.r),
                      height: MediaQuery.sizeOf(context).height * 0.08,
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      onPressed: () {
                        // if (ageRange != null && distanceRange != null) {
                        parentModel.getFilterdFeed(
                            locationId: parentModel.selectedLocation?.id,
                            radiusStart:
                                parentModel.filterDataModel?.radiusStart ??
                                    distanceRange!.start.toInt(),
                            radiusEnd: parentModel.filterDataModel?.radiusEnd ??
                                distanceRange!.end.toInt(),
                            ageRangeStart:
                                parentModel.filterDataModel?.ageRangeStart ??
                                    ageRange!.start.toInt(),
                            ageRangeEnd:
                                parentModel.filterDataModel?.ageRangeEnd ??
                                    ageRange!.end.toInt());
                        Navigator.pop(context);
                        // }
                      },
                      child: Text(
                        "Apply",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: Font.inter,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
