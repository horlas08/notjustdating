import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/feed_view_model/feed_view_model.dart';
import 'package:ofwhich_v2/application/profile/profile_view_model.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../domain/feed/model/draft_model.dart';
import '../../../domain/feed/model/feed_post_model.dart';
import '../../general_widgets/app_logo.dart';
import 'dummy_data/post_model.dart';

@RoutePage()
class ContentCreatorProfile extends StatefulWidget {
  const ContentCreatorProfile({super.key});

  @override
  State<ContentCreatorProfile> createState() => _ContentCreatorProfileState();
}

class _ContentCreatorProfileState extends State<ContentCreatorProfile>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    getIt<ProfileViewModel>().getUserSavedLocally();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // onViewModelReady: (h) {
      //   h.getUserSavedLocally();
      // },
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  const AppLogo(),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        getIt<AppRouter>().push(const ContentCreatorSettings());
                      },
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.0.w),
                            child: Image.asset(
                                'assets/images/pngs/settings_icon.png',
                                height: 30.h),
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Align(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        maxRadius: 70.r,
                        backgroundImage:
                            CachedNetworkImageProvider(model.user?.photo ?? ""),
                      ),
                      Positioned(
                          bottom: 1.w,
                          right: -1.h,
                          child: Image.asset(
                              "assets/images/pngs/edit_profile.png"))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(model.user?.full_name ?? "",
                  style: TextStyle(
                      fontFamily: Font.inter,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600)),
              SizedBox(
                height: 5.h,
              ),
              Text("@${model.user?.username ?? "N/A"}",
                  style: TextStyle(
                      fontFamily: Font.inter,
                      fontSize: 16.sp,
                      color: const Color(0xFF434343),
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                height: 60.h,
                child: TabBar(
                  controller: controller,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 2.w,
                  tabs: [
                    Text("Approved",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: Font.inter)),
                    Text("Pending",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: Font.inter)),
                    Text("Draft",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: Font.inter))
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: TabBarView(
                  controller: controller,
                  children: [
                    ViewModelBuilder<FeedViewModel>.reactive(
                        viewModelBuilder: () => getIt<FeedViewModel>(),
                        onViewModelReady: (h) async {
                          await h.getUserPosts();
                          h.sortApprovedPost();
                        },
                        builder: (context, model, child) {
                          return model.approvedPost.isEmpty
                              ? const Center(child: Text("No data"))
                              : GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              2, // Number of columns
                                          crossAxisSpacing: 10.0.w,
                                          mainAxisSpacing: 8.0.w,
                                          childAspectRatio: 0.78),
                                  itemCount: model.approvedPost.length,
                                  itemBuilder: (context, index) {
                                    FeedPostModel post =
                                        model.approvedPost[index];
                                    return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        child: CachedNetworkImage(
                                            imageUrl: post.file_url ?? "N/A",
                                            fit: BoxFit.cover));
                                  });
                        }),
                    ViewModelBuilder<FeedViewModel>.reactive(
                        viewModelBuilder: () => getIt<FeedViewModel>(),
                        onViewModelReady: (h) async {
                          await h.getUserPosts();
                          h.sortUserPost();
                        },
                        builder: (context, model, child) {
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // Number of columns
                                      crossAxisSpacing: 10.0.w,
                                      mainAxisSpacing: 8.0.w,
                                      childAspectRatio: 0.75),
                              itemCount: model.pendingPost.length,
                              itemBuilder: (context, index) {
                                FeedPostModel post = model.pendingPost[index];
                                log(model.pendingPost.length.toString());
                                return Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    //  width:MediaQuery.of(context).size.w
                                    child: Stack(children: [
                                      // CachedNetworkImage(
                                      //     imageUrl: post.file_url ?? "N/A",
                                      //     fit: BoxFit.cover),
                                      Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.transparent
                                              .withOpacity(0.5),
                                          alignment: Alignment.center,
                                          child: Text("Pending \nApproval",
                                              style: TextStyle(
                                                  fontFamily: Font.inter,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white)))
                                    ]));
                              });
                        }),
                    ViewModelBuilder<FeedViewModel>.reactive(
                        onViewModelReady: (h) {
                          h.getDrafts();
                        },
                        viewModelBuilder: () => getIt<FeedViewModel>(),
                        builder: (context, model, child) {
                          return model.isBusy
                              ? const Center(
                                  child:
                                      CircularProgressIndicator()) // Show loading indicator
                              : model.draftList.isEmpty
                                  ? const Center(
                                      child: Text(
                                          'No data available')) // Show no data message
                                  : GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, // Number of columns
                                        crossAxisSpacing: 10.0.w,
                                        mainAxisSpacing: 8.0.w,
                                        childAspectRatio: 0.78,
                                      ),
                                      itemCount: model.draftList.length,
                                      itemBuilder: (context, index) {
                                        DraftModel post =
                                            model.draftList[index];
                                        return SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          child: CachedNetworkImage(
                                            imageUrl: post.file_url ?? "N/A",
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    );
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
