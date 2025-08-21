import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppImageWidget extends StatelessWidget {
  const AppImageWidget({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fitHeight,
      errorWidget: (context, url, x) {
        return Container(
            color: Colors.grey,
            child: Icon(
              Icons.person,
              size: 100.h,
            ));
      },
    );
  }
}
