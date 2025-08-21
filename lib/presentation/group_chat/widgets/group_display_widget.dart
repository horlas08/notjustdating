import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ofwhich_v2/application/group_view_model/group_view_model.dart';
import 'package:ofwhich_v2/application/profile/profile_view_model.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_button.dart';
import 'package:stacked/stacked.dart';

import '../../../domain/group/models/group_model.dart';
import '../../../injectable.dart';
import '../../routes/app_router.dart';
import '../../routes/app_router.gr.dart';

class GroupWidget extends StatelessWidget {
  const GroupWidget({
    super.key,
    required this.groupModel,
  });

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GroupViewModel>.reactive(
      viewModelBuilder: () => getIt<GroupViewModel>(),
      builder: (context, model, child) => Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          height: MediaQuery.of(context).size.height * 0.25,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.grey.shade300)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    minRadius: 15.r,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(groupModel.name ?? "N/A",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(groupModel.description ?? "N/A",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: Font.inter,
                        fontWeight: FontWeight.w300)),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Stack(
                        children:
                            groupModel.members!.asMap().entries.map((entry) {
                          int idx = entry.key;
                          String imageUrl = entry.value.photo ?? "N/A";
                          return Positioned(
                            left: idx * 20.0,
                            top: (MediaQuery.of(context).size.height * 0.1 -
                                    32.0) /
                                2, // Centering CircleAvatar vertically
                            child: CircleAvatar(
                              backgroundImage:
                                  CachedNetworkImageProvider(imageUrl),
                              radius: 16.0.r,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(width: 8.0.w),
                    Container(
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(236, 88, 115, 0.15),
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 0.8),
                            borderRadius: BorderRadius.circular(10.r)),
                        height: 40.0.h,
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                // bool isSubscribed = getIt<ProfileViewModel>()
                                //             .user
                                //             ?.is_subscribed ==
                                //         0
                                //     ? false
                                //     : true;
                                // if (isSubscribed) {
                                model.addMembers(groupModel: groupModel);
                                //   } else {
                                //     showDialog(
                                //         context: context,
                                //         builder: (context) =>
                                //             const LockedGroupDialog());
                                //   }
                              },
                              child: Text("Join Conversation",
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      fontFamily: Font.inter,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w400)),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 25.h,
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class LockedGroupDialog extends StatefulWidget {
  const LockedGroupDialog({
    super.key,
  });

  @override
  State<LockedGroupDialog> createState() => _LockedGroupDialogState();
}

class _LockedGroupDialogState extends State<LockedGroupDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Lock Icon
            SizedBox(
              height: 300.h,
              width: 300.w,
              child: Image.asset(
                "assets/images/pngs/locked_group.png",
                // color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 20.h),

            // Title Text
            Text(
              "Room is Locked",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),

            // Subtitle Text
            Text(
              "Hello there, please know that this room is \navailable for only premium users, kindly \nupgrade your account to access it.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                fontFamily: Font.inter,
                color: const Color(0xFF585858),
              ),
            ),
            SizedBox(height: 10.h),

            CustomButton(
                onPressed: () {
                  getIt<AppRouter>().push(const SupscriptionHome());
                },
                height: 70.h,
                borderRadius: BorderRadius.circular(15.r),
                child: Text(
                  "Subscribe Now",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: Font.inter,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
