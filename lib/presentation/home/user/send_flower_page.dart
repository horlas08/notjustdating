import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/presentation/general_widgets/app_back_button.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_button.dart';
import 'package:stacked/stacked.dart';

import '../../../application/home_view_model/home_view_model.dart';
import '../../../domain/user_service/model/user_gift.dart';
import '../../../domain/user_service/model/user_object.dart';
import '../../../injectable.dart';
import '../../core/font.dart';
import 'widgets/flower_card.dart';

@RoutePage()
class SendFlowerToUser extends StatelessWidget {
  const SendFlowerToUser({super.key, required this.user, required this.gift});
  final UserModel user;
  final UserGift gift;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => getIt<HomeViewModel>(),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                const AppBackButton(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    CircleAvatar(
                      radius: 90.r,
                      backgroundImage: CachedNetworkImageProvider(user.photo!,
                          errorListener: (val) {}),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text("Send Flower",
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: Font.inter,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "You’re about to send a flower to ${user.full_name}, \nKindly know that sending flower doesn't guarantee a match from her, but only give you higher chance of match.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: const Color(0xFF575757)),
                    ),
                    SizedBox(height: 30.h),
                    FlowerCard(
                      gift: gift,
                      isSelected: true,
                      height: MediaQuery.sizeOf(context).height * 0.17,
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                    CustomButton(
                      onPressed: () {
                        model.sendGiftToUser(
                            amount: gift.unit_price,
                            beneficiaryId: user.id ?? 1,
                            user: user,
                            giftId: gift.id);
                      },
                      height: 70.h,
                      borderRadius: BorderRadius.circular(10.r),
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontFamily: Font.inter,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
