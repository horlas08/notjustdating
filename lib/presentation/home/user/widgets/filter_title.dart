import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/font.dart';

class FilterTtitle extends StatelessWidget {
  const FilterTtitle({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
            fontSize: 16.sp,
            fontFamily: Font.inter,
            color: Colors.black,
            fontWeight: FontWeight.w600));
  }
}