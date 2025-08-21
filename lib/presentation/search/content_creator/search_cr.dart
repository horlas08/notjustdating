// ignore_for_file: prefer_const_constructors

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class ContentCreatorSearch extends StatefulWidget {
  const ContentCreatorSearch({super.key});

  @override
  State<ContentCreatorSearch> createState() => _ContentCreatorSearchState();
}

class _ContentCreatorSearchState extends State<ContentCreatorSearch> {
  final List<String> recentSearches = [
    'Daniel Okrah',
    'Felisia Dennis',
    'Victor Smith',
  ];

  final List<String> trends = [
    'Daniel Okrah',
    'Valentines Day',
    'Victor Smith',
    'Felisia Dennis',
  ];

  final Map<String, int> trendPosts = {
    'Daniel Okrah': 1348,
    'Valentines Day': 6000000,
    'Victor Smith': 11784,
    'Felisia Dennis': 89315,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('not just dating'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search User, Contents',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0.r),
                ),
              ),
            ),
            SizedBox(height: 16.0.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Search',
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0.sp),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: recentSearches.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.access_time, size: 20.h),
                  title: Text(recentSearches[index]),
                  trailing: const Icon(Icons.close),
                );
              },
            ),
            SizedBox(height: 16.0.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Relationship trends for you',
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0.sp),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: trends.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(trends[index]),
                    subtitle: Text('${trendPosts[trends[index]]} post'),
                    trailing:const Icon(Icons.trending_up),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications),
      //       label: 'Notifications',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.add),
      //       label: 'Add',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: 'Search',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      //   selectedItemColor: Colors.pink,
      //   unselectedItemColor: Colors.grey,
      //   currentIndex: 3,
      //   onTap: (index) {
      //     // Handle bottom navigation item tap
      //   },
      // ),
    );
  }
}
