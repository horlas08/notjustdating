// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/chat/model/data.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_appbar.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_button.dart';
// import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
// import 'package:ofwhich_v2/presentation/general_widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../application/chat_view_model/chat_view_model.dart';
import '../../application/home_view_model/home_view_model.dart';
import '../../application/post_view_model/content_creator/post_view_model.dart';
import '../../domain/auth/models/location_model.dart';
// import '../general_widgets/app_logo.dart';
import '../../domain/user_service/model/date_model.dart';
import '../general_widgets/custom_drop_down.dart';
import '../routes/app_router.dart';
import '../routes/app_router.gr.dart';

@RoutePage()
class PlanADateScreen extends StatefulWidget {
  const PlanADateScreen({super.key, this.dateUserId, this.dateId, this.type});

  final num? dateUserId;
  final num? dateId;
  final String? type;

  @override
  State<PlanADateScreen> createState() => _PlanADateScreenState();
}

class _PlanADateScreenState extends State<PlanADateScreen> {
  final _formKey = GlobalKey<FormState>();

  LocationModel? firstLocation;
  LocationModel? secondLocation;
  LocationModel? thirdLocation;

  String? selectedBudget;

  List<DateTime?> _selectedDateTimes = [null, null, null];

  final List<String> _labels = [
    'First Option',
    'Second Option',
    'Third Option'
  ];

  Future<void> _pickDateTime(BuildContext context, int index) async {
    final DateTime now = DateTime.now();
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTimes[index] ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 28)), // Limit to 4 weeks from now
    );

    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(_selectedDateTimes[index] ?? DateTime.now()),
      );

      if (time != null) {
        setState(() {
          _selectedDateTimes[index] =
              DateTime(date.year, date.month, date.day, time.hour, time.minute);
        });
      }
    }
  }

  String _formatDateTime(DateTime? dt, int index) {
    if (dt == null) return 'Select ${_labels[index]}';
    return DateFormat('yyyy-MM-dd HH:mm').format(dt);
  }

  // Get all selected non-null datetimes
  List<DateTime> getSelectedDateTimes() {
    return _selectedDateTimes
        .where((dt) => dt != null)
        .cast<DateTime>()
        .toList();
  }

  // Check how many datetimes are selected
  int getSelectedCount() {
    return _selectedDateTimes.where((dt) => dt != null).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OfWhichAppBar(
        titleText: "Plan A Date",
        titleTextColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Consumer2<HomeViewModel, ChatViewModel>(
          builder: (context, parentModel, chatViewModel, child) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 40.h),
                // const Center(child: AppLogo()),
                // SizedBox(height: 20.h),
                Text(
                  "Plan A Date With....",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontFamily: Font.inter,
                      fontWeight: FontWeight.w400),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Location Details',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 20.h,
                      ),

                      ViewModelBuilder<PostViewModel>.reactive(
                        viewModelBuilder: () => getIt<PostViewModel>(),
                        onViewModelReady: (c) {
                          c.getLocations();
                        },
                        builder: (context, model, child) => CustomDropdown(
                          useParent: true,
                          borderColor: Colors.grey.shade300,
                          label: " First Location",
                          child: DropdownButton<LocationModel>(
                            isExpanded: true,
                            value: firstLocation,

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
                              setState(() {
                                firstLocation = newValue;
                              });
                              // parentModel.setSelectedLocation(newValue);
                              // setState(() {
                              //   model.drop2SelectedValue = newValue;
                              // });
                            },
                          ),
                        ),
                      ),
                      // CustomTextFieldWidget(
                      //   label: "Primary Location",
                      //   controller: _preferredLocationController,
                      // ),

                      SizedBox(
                        height: 10.h,
                      ),
                      ViewModelBuilder<PostViewModel>.reactive(
                        viewModelBuilder: () => getIt<PostViewModel>(),
                        onViewModelReady: (c) {
                          c.getLocations();
                        },
                        builder: (context, model, child) => CustomDropdown(
                          useParent: true,
                          borderColor: Colors.grey.shade300,
                          label: "Second Location",
                          child: DropdownButton<LocationModel>(
                            isExpanded: true,
                            value: secondLocation,

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
                              setState(() {
                                secondLocation = newValue;
                              });
                              parentModel.setSelectedLocation(newValue);
                              // setState(() {
                              //   model.drop2SelectedValue = newValue;
                              // });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ViewModelBuilder<PostViewModel>.reactive(
                        viewModelBuilder: () => getIt<PostViewModel>(),
                        onViewModelReady: (c) {
                          c.getLocations();
                        },
                        builder: (context, model, child) => CustomDropdown(
                          useParent: true,
                          borderColor: Colors.grey.shade300,
                          label: "Third Location",
                          child: DropdownButton<LocationModel>(
                            isExpanded: true,
                            value: thirdLocation,

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
                              setState(() {
                                thirdLocation = newValue;
                              });
                              parentModel.setSelectedLocation(newValue);
                              // setState(() {
                              //   model.drop2SelectedValue = newValue;
                              // });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),

                      SizedBox(height: 24.h),
                      Text('Budget',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10.h),
                      // const Text(
                      //     "",styl),
                      // SizedBox(height: 15.h),
                      // CustomTextFieldWidget(
                      //   label: "Enter Budget",
                      //   controller: _budgetController,
                      //   inputType: TextInputType.number,
                      //   hintText: "Enter your budget for this date",
                      // ),
                      CustomDropdown(
                        useParent: true,
                        borderColor: Colors.grey.shade300,
                        labelStyle:
                            TextStyle(fontSize: 12.sp, color: Colors.grey),
                        label:
                            "This indicates how much you are willing to spend on the date",
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedBudget,

                          hint: const Text('Budget'),
                          iconSize: 15,
                          icon: const Icon(Icons.keyboard_arrow_down_sharp),
                          // itemHeight: 300,
                          elevation: 0,
                          style: const TextStyle(color: Colors.black),
                          dropdownColor: Colors.white,
                          items: budgetList.map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedBudget = newValue;
                            });
                            // parentModel.setSelectedLocation(newValue);
                            // setState(() {
                            //   model.drop2SelectedValue = newValue;
                            // });
                          },
                        ),
                      ),
                      SizedBox(height: 24.h),

                      const Text('Date and Time',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20.h),
                      ...List.generate(
                          3,
                          (index) => Padding(
                                padding: EdgeInsets.only(bottom: 16.w),
                                child: GestureDetector(
                                  onTap: () => _pickDateTime(context, index),
                                  child: Container(
                                    padding: EdgeInsets.all(16.w),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              _selectedDateTimes[index] != null
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.5)
                                                  : Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                      color: _selectedDateTimes[index] != null
                                          ? Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.2)
                                          : Colors.white,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          color: _selectedDateTimes[index] !=
                                                  null
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey,
                                        ),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: Text(
                                            _formatDateTime(
                                                _selectedDateTimes[index],
                                                index),
                                            style: TextStyle(
                                              color:
                                                  _selectedDateTimes[index] !=
                                                          null
                                                      ? Colors.black
                                                      : Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                        if (_selectedDateTimes[index] != null)
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectedDateTimes[index] =
                                                    null;
                                              });
                                            },
                                            child: Icon(Icons.close,
                                                color: Colors.red, size: 20.w),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                      const SizedBox(height: 40),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     if (_formKey.currentState!.validate()) {
                      //       debugPrint("Form Submitted!");
                      //       debugPrint(
                      //           "Primary Location: ${_primaryLocationController.text}");
                      //       debugPrint(
                      //           "Preferred Location: ${_preferredLocationController.text}");
                      //       debugPrint(
                      //           "Default Location: ${_defaultLocationController.text}");
                      //       debugPrint("Budget: ${_budgetController.text}");
                      //       debugPrint("Selected DateTime: $_selectedDateTime");
                      //     }
                      //   },
                      //   child: const Text('Submit'),
                      // )

                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${getSelectedCount()}/3 options selected',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: getSelectedCount() > 0
                                ? Colors.green.shade700
                                : Colors.grey.shade600,
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Submit button (only enabled if at least one datetime is selected)

                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0.w),
                        child: CustomButton(
                            height: 60.h,
                            onPressed: getSelectedCount() > 0
                                ? () {
                                    // Handle submission with selected datetimes
                                    // List<DateTime> selected =
                                    //     getSelectedDateTimes();
                                    // log('Selected DateTimes: $selected');

                                    // getIt<AppRouter>().push(PayForDateRoute(
                                    //     paymentAmount: 100.00,
                                    //     merchantName: "Stuff"));
                                    // chatViewModel.planDate(
                                    //     locations: [
                                    //       firstLocation?.id ?? 0,
                                    //       secondLocation?.id ?? 0,
                                    //       thirdLocation?.id ?? 0
                                    //     ],
                                    //     payment_method: "card",
                                    //     budget: selectedBudget,
                                    //     dates: _selectedDateTimes
                                    //         .map((e) =>
                                    //             DateModel.fromDateTime(e!))
                                    //         .toList());
                                    getIt<AppRouter>().push(PayForDateRoute(
                                        dateId: widget.dateId,
                                        dateUserId: widget.dateUserId,
                                        type: widget.type,
                                        locations: [
                                          firstLocation?.id ?? 0,
                                          secondLocation?.id ?? 0,
                                          thirdLocation?.id ?? 0
                                        ],
                                        paymentMethod: "card",
                                        budget: selectedBudget,
                                        dates: _selectedDateTimes
                                            .map((e) =>
                                                DateModel.fromDateTime(e!))
                                            .toList()));

                                    // You can now use these selected datetimes
                                    // For example: widget.onDateTimesSelected?.call(selected);
                                  }
                                : null,
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontFamily: Font.inter,
                                  fontWeight: FontWeight.w400),
                            )),
                      ),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //     onPressed: getSelectedCount() > 0
                      //         ? () {
                      //             // Handle submission with selected datetimes
                      //             List<DateTime> selected =
                      //                 getSelectedDateTimes();
                      //             print('Selected DateTimes: $selected');

                      //             // You can now use these selected datetimes
                      //             // For example: widget.onDateTimesSelected?.call(selected);
                      //           }
                      //         : null,
                      //     child: Text('Submit Selected Times'),
                      //   ),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
