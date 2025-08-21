import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../application/profile/profile_view_model.dart';
import '../../core/font.dart';
import '../../general_widgets/custom_appbar.dart';
import '../../general_widgets/custom_button.dart';
import '../../general_widgets/custom_textfield.dart';
import '../../routes/app_router.dart';

@RoutePage()
class UserAddressInfo extends StatefulWidget {
  const UserAddressInfo(
      {super.key,
      this.selectedPhoto,
      this.firstName,
      this.dob,
      required this.gender,
      required this.relationshipStatus,
      this.preference,
      this.userType,
      this.username});
  final File? selectedPhoto;
  final String? firstName;
  final String? dob;
  final String gender;
  final String relationshipStatus;
  final String? preference;
  final String? userType;
  final String? username;

  @override
  State<UserAddressInfo> createState() => _UserAddressInfoState();
}

class _UserAddressInfoState extends State<UserAddressInfo> {
  final TextEditingController addressController = TextEditingController();

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final addressFocusNode = FocusNode();
  Location? location;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    addressFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Stack(
        children: [
          Scaffold(
            appBar: const CustomAppBar(
              titleText: "Personal Information",
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25.h,
                      ),
                      Text("Your address",
                          style: TextStyle(
                              fontFamily: Font.inter,
                              fontSize: 26.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                      Text("Enter your physical location",
                          style: TextStyle(
                              fontFamily: Font.inter,
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                      SizedBox(height: 30.h),
                      CustomTextFieldWidget(
                        controller: addressController,
                        focusNode: addressFocusNode,
                        filled: true,
                        label: "Address",
                        hintText: "Enter address",
                        labelTextStyle: TextStyle(
                            fontFamily: Font.inter,
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        suffix: Text(
                          "Get location",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        suffixAction: () async {
                          await model.getCoordinatesFromAddress(
                              address: addressController.text);
                        },
                        onSubmitted: (val) async {
                          location = await model.getCoordinatesFromAddress(
                              address: val);
                        },
                      ),
                      SizedBox(height: 12.h),
                      model.location != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Coordinates",
                                    style: TextStyle(
                                        fontFamily: Font.rubik,
                                        fontSize: 14.sp,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Container(
                                  height: 55.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Lat: ${model.location?.latitude} "),
                                        Text(
                                            "Lat: ${model.location?.longitude}"),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(height: 12.h),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0.w),
                    child: CustomButton(
                        onPressed: model.location != null
                            ? () {
                                if (model.location == null) {
                                  _scaffoldMessengerKey.currentState!
                                      .showSnackBar(
                                    SnackBar(
                                      content: const Row(
                                        children: [
                                          Icon(
                                            Icons.error_outline,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              "Please click button to get locatioon",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 4),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      margin: EdgeInsets.all(16),
                                      action: SnackBarAction(
                                        label: 'DISMISS',
                                        textColor: Colors.white,
                                        onPressed: () {
                                          _scaffoldMessengerKey.currentState
                                              ?.hideCurrentSnackBar();
                                        },
                                      ),
                                    ),
                                  );
                                }
                                getIt<AppRouter>().push(ChhoseYourCircle(
                                    preference: widget.preference,
                                    relationshipStatus:
                                        widget.relationshipStatus,
                                    dob: widget.dob,
                                    username: widget.username,
                                    long: model.location?.longitude ?? 0,
                                    lat: model.location?.latitude ?? 0,
                                    address: addressController.text,
                                    firstName: widget.firstName,
                                    selectedPhoto:
                                        widget.selectedPhoto ?? File(""),
                                    gender: widget.gender));
                                // getIt<AppRouter>().push(const ProfileUpdateSuccessRoute());
                              }
                            : null,
                        height: 60.h,
                        borderRadius: BorderRadius.circular(10.r),
                        // bgColor: const Color(0xFF54848A),
                        child: Text("Continue",
                            style: TextStyle(
                                fontFamily: Font.rubik,
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w400))),
                  )
                ],
              ),
            ),
          ),
          if (model.isBusy)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
