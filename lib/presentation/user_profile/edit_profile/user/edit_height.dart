import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';
import 'package:provider/provider.dart';
// import 'package:stacked/stacked.dart';

import '../../../../application/profile/profile_view_model.dart';
import '../../../../injectable.dart';
import '../../../core/font.dart';
import '../../../general_widgets/custom_appbar.dart';
import '../../../general_widgets/custom_button.dart';
import '../../../routes/app_router.gr.dart';

@RoutePage()
class EditHeight extends StatefulWidget {
  const EditHeight({super.key});

  @override
  State<EditHeight> createState() => _EditHeightState();
}

class _EditHeightState extends State<EditHeight> {
  int _selectedWeightIndex = 9; // Default to 61 kg (index 9)

  // Generate a list of weights from 52 kg to 71 kg
  final List<int> _height = List<int>.generate(1000, (i) => 20 + i);
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // Initialize the scroll controller with the default selected index
  }

  @override
  void dispose() {
    // Dispose the scroll controller when the widget is disposed
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
        appBar: const OfWhichAppBar(
          titleText: "Edit my height",
          leadingIcon: true,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.74,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      )),
                  child: ListView.builder(
                    // shrinkWrap: false,
                    // controller: _scrollController,
                    // itemExtent: 50, // Set height for each item
                    physics: const BouncingScrollPhysics(), // Snapping behavior
                    itemCount: _height.length,
                    itemBuilder: (context, index) {
                      // The current weight to display
                      final height = _height[index];
                      // Highlight the selected weight
                      final isSelected = _selectedWeightIndex == index;

                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedWeightIndex = index;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: isSelected
                                    ? Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 2)
                                    : null,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8.0.w),
                              child: Text(
                                '$height cm',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontFamily: Font.inter,
                                  color: isSelected
                                      ? Theme.of(context).primaryColor
                                      : Colors.black,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // SizedBox(
                //   height: 300.h,
                //   child: ListWheelScrollView.useDelegate(
                //     itemExtent: 50,
                //     onSelectedItemChanged: (index) {
                //       setState(() {
                //         _selectedWeightIndex = index;
                //       });
                //     },
                //     physics: const FixedExtentScrollPhysics(),
                //     childDelegate: ListWheelChildBuilderDelegate(
                //       builder: (context, index) {
                //         // The current weight to display
                //         final weight = _weights[index];
                //         // Highlight the selected weight
                //         final isSelected = _selectedWeightIndex == index;

                //         return Center(
                //           child: Text(
                //             '$weight kg',
                //             style: TextStyle(
                //               fontSize: 24,
                //               color: isSelected ? Colors.pink : Colors.black,
                //               fontWeight: isSelected
                //                   ? FontWeight.bold
                //                   : FontWeight.normal,
                //             ),
                //           ),
                //         );
                //       },
                //       childCount: _weights.length,
                //     ),
                //   ),
                // ),
                SizedBox(height: 20.h),
              ]),

              Column(children: [
                CustomButton(
                  height: 70.h,
                  borderRadius: BorderRadius.circular(10.r),
                  width: MediaQuery.of(context).size.width,
                  onPressed: () {
                    model.editProfile(
                        weight: _height[_selectedWeightIndex].toString(),
                        navigate: () {
                          getIt<AppRouter>().pushAndPopUntil(
                              predicate: (_) => false,
                              const UserProfileDetails());
                        });
                  },

                  // : null,
                  child: Text("Save",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontFamily: Font.inter,
                          fontWeight: FontWeight.w400)),
                ),
                SizedBox(height: 20.h)
              ]),
              // ElevatedButton(
              //   onPressed: () {
              //     // Action to save the selected weight
              //     final selectedWeight = _weights[_selectedWeightIndex];
              //     print('Selected weight: $selectedWeight kg');
              //     // Implement save functionality here
              //   },
              //   style: ElevatedButton.styleFrom(
              //     primary: Colors.pink, // Button color
              //     padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              //   child: Text(
              //     'Save',
              //     style: TextStyle(fontSize: 18),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
