import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/domain/user_service/model/user_gift.dart';

import '../../../core/font.dart';

class FlowerCard extends StatelessWidget {
  const FlowerCard(
      {super.key,
      // required this.flowercurrentIndex,
      this.height,
      this.width,
      required this.gift,
      required this.isSelected});

  // final int flowercurrentIndex;
  final UserGift? gift;
  final bool isSelected;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80.h,
      height: height ?? 100.w,
      width: width ?? 90.w,
      decoration: BoxDecoration(
          // color: Colors.green
          boxShadow: const [],
          border: Border.all(
              color: isSelected
                  ? const Color(0xFFEC5873)
                  : const Color(0xFF9C9C9C)),
          borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(flower.imageAsset ?? ""),
          CachedNetworkImage(
            imageUrl: gift!.image,
            errorWidget: (context, url, x) {
              return Image.asset("assets/images/pngs/flower1.png");
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(gift!.unit_price.toString(),
              style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF575757),
                  fontWeight: FontWeight.w400,
                  fontFamily: Font.inter))
        ],
      ),
    );
  }
}
