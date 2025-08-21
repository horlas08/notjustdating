import 'package:auto_route/annotations.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/feed_view_model/feed_view_model.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/general_widgets/post_card.dart';
import 'package:stacked/stacked.dart';

import '../../../domain/feed/model/feed_post_model.dart';
import '../../core/font.dart';
import '../../general_widgets/app_logo.dart';

@RoutePage()
class ContentCreatorHomePage extends StatefulWidget {
  const ContentCreatorHomePage({super.key});

  @override
  State<ContentCreatorHomePage> createState() => _ContentCreatorHomePageState();
}

class _ContentCreatorHomePageState extends State<ContentCreatorHomePage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  ScrollController? controller1;
  ScrollController? controller2;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller1 = ScrollController();
    controller2 = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
      onViewModelReady: (g) async {
        g.getUserFeed();
      },
      viewModelBuilder: () => getIt<FeedViewModel>(),
      builder: (context, model, child) => Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),
              const AppLogo(),
              SizedBox(height: 20.h),
              Container(
                height: 70.h,
                width: MediaQuery.of(context).size.width,
                color: const Color.fromRGBO(71, 91, 216, 0.26),
                child: TabBar(
                  controller: controller,
                  tabs: [
                    Text("Explore",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: Font.inter)),
                    Text("For You",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: Font.inter))
                  ],
                ),
              ),
              SizedBox(
                  // color: Colors.green,
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(
                    controller: controller,
                    children: [
                      ViewModelBuilder<FeedViewModel>.reactive(
                        viewModelBuilder: () => getIt<FeedViewModel>(),
                        builder: (context, model, child) =>
                            NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                              // log("called");
                              model.loadMoreUserExploreFeed();
                            }
                            return false;
                          },
                          child: model.isUserExploreFeedFirstRun
                              ? const CircularProgressIndicator()
                              : model.userFeed.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No feed for user',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            controller: controller1,
                                            itemCount: model.userFeed.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              FeedPostModel post =
                                                  model.userFeed[index];
                                              return PostCard(
                                                viewModel: model,
                                                post: post,
                                                scrollController: controller1!,
                                              );
                                            },
                                          ),
                                        ),
                                        if (model
                                            .isUserExploreFeedLoadMoreRunning)
                                          Padding(
                                            padding: EdgeInsets.all(8.0.w),
                                            child:
                                                const CircularProgressIndicator(),
                                          )
                                      ],
                                    ),
                        ),
                      ),
                      ViewModelBuilder<FeedViewModel>.reactive(
                          viewModelBuilder: () => getIt<FeedViewModel>(),
                          onViewModelReady: (g) async {
                            await g.getUserPosts();
                            // g.getUserPosts();
                            g.sortApprovedPost();
                          },
                          builder: (context, model, child) {
                            return NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                                  // log("called");
                                  // model.loadMoreFeed();
                                }
                                return false;
                              },
                              child: model.isFirstRunLoading
                                  ? const CircularProgressIndicator()
                                  : model.userPost.isEmpty
                                      ? Center(
                                          child: Text(
                                            'No feed for user',
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount:
                                                    model.approvedPost.length,
                                                controller: controller2,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  FeedPostModel post =
                                                      model.approvedPost[index];
                                                  return PostCard(
                                                    viewModel: model,
                                                    post: post,
                                                    scrollController:
                                                        controller2!,
                                                  );
                                                },
                                              ),
                                            ),
                                            if (model.isLoadMoreRunning)
                                              Padding(
                                                padding: EdgeInsets.all(8.0.w),
                                                child:
                                                    const CircularProgressIndicator(),
                                              ),
                                          ],
                                        ),
                            );
                          }),
                    ],
                  )),
            ],
          ),
        ),
      )),
    );
  }
}
