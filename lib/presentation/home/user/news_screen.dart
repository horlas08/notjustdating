import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_appbar.dart';

@RoutePage()
class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OfWhichAppBar(
        titleText: "News and Article",
        leadingIcon: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              _searchBar(),
              SizedBox(
                height: 20.h,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 35.h),
                    child: newsTile(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _searchBar() {
  return Container(
    height: 60.h,
    padding: EdgeInsets.symmetric(horizontal: 14.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        border: Border.all(color: const Color.fromRGBO(215, 215, 215, 1))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_outlined,
              size: 24.sp,
            )),
        Expanded(
            child: Text(
          "Search an article",
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ))
      ],
    ),
  );
}

Widget newsTile() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 175.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
          child: Image.asset(
            "assets/images/pngs/news.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(
        height: 15.h,
      ),
      Text(
        "Lorem Ipsum is simply dummy text",
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
      ),
      SizedBox(
        height: 8.h,
      ),
      Text(
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
      ),
    ],
  );
}
