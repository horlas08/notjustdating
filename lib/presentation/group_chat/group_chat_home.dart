// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:auto_route/auto_route.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/group_view_model/group_view_model.dart';
import 'package:ofwhich_v2/domain/group/models/group_model.dart';
import 'package:ofwhich_v2/presentation/group_chat/widgets/group_display_widget.dart';
import 'package:stacked/stacked.dart';
// import 'package:ofwhich_v2/presentation/group_chat/widgets/group_list.dart';

import '../../injectable.dart';
import '../core/font.dart';
// import '../general_widgets/custom_button.dart';
import '../general_widgets/refresh_widget.dart';
import 'widgets/group_appbar.dart';
import 'widgets/group_loader.dart';
// import 'widgets/group_card.dart';
// import 'widgets/group_appbar.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final tabs = [
    "All",
    "My Groups",
    // "New Rooms",
    // "Free Rooms",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  static const List<String> memberImages = [
    'https://example.com/image1.jpg',
    'https://example.com/image2.jpg',
    'https://example.com/image3.jpg',
    'https://example.com/image4.jpg',
    'https://example.com/image5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GroupViewModel>.reactive(
        onViewModelReady: (h) async {
          await h.loginSavedQBUser();
          // await h.initializeChat();
          await h.getCurrentUser();
          await h.getUserGroup();
          await h.getGroups();
          // await h.checkGroupList();
        },
        viewModelBuilder: () => getIt<GroupViewModel>(),
        builder: (context, model, child) {
          return Scaffold(
              body: RefreshWidget(
            onRefresh: () async {
              final Completer<void> completer = Completer<void>();
              Timer(const Duration(seconds: 3), () {
                completer.complete();
              });

              return completer.future.then<void>((_) {
                model.getCurrentUser();
                model.getUserGroup();
                model.getGroups();
                model.checkGroupList();
              });
            },
            child: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(height: 60.h),
                const TopBar(),
                TabBar(
                  labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
                  tabAlignment: TabAlignment.center,
                  labelColor: const Color(0xFF5A5A5A),
                  dividerColor: Colors.transparent,
                  // padding: EdgeInsets.zero,
                  // indicatorPadding: EdgeInsets.zero,
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  tabs: tabs.map((tab) {
                    return Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0.w, vertical: 6.0.w),
                        decoration: BoxDecoration(
                          color: _tabController.index == tabs.indexOf(tab)
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          tab,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: _tabController.index == tabs.indexOf(tab)
                                ? Colors.white
                                : const Color(0xFF5A5A5A),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: TabBarView(controller: _tabController, children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h),
                              Text("Available Groups",
                                  style: TextStyle(
                                      fontFamily: Font.inter,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600)),
                              Text(
                                  "Connect with people of the same interest as you",
                                  style: TextStyle(
                                      fontFamily: Font.inter,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.65,
                                child: model.isBusy
                                    ? const Center(child: ShimmerList())
                                    : model.groupList.isEmpty
                                        ? Container()
                                        : ListView.separated(
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                height: 15.h,
                                              );
                                            },
                                            itemCount: model.groupList.length,
                                            // shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              GroupModel groupModel =
                                                  model.groupList[index];
                                              return GroupWidget(
                                                  groupModel: groupModel);
                                            }),
                              )
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h),
                              Text("User Groups",
                                  style: TextStyle(
                                      fontFamily: Font.inter,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600)),
                              Text(
                                  "Connect with people of the same interest as you",
                                  style: TextStyle(
                                      fontFamily: Font.inter,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: model.isBusy
                                    ? const Center(child: ShimmerList())
                                    : model.userGroupList.isEmpty
                                        ? Container()
                                        : ListView.separated(
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                height: 15.h,
                                              );
                                            },
                                            itemCount:
                                                model.userGroupList.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              GroupModel groupModel =
                                                  model.userGroupList[index];
                                              return GroupWidget(
                                                  groupModel: groupModel);
                                            }),
                              )
                            ],
                          ),
                        ),
                      ),
                      // SingleChildScrollView(),
                      // SingleChildScrollView(),
                    ]))
              ],
            )),
          ));
        });
  }
}
