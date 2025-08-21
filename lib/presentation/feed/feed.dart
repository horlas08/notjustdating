import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/feed_view_model/feed_view_model.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:stacked/stacked.dart';
import '../../domain/feed/model/feed_post_model.dart';
import '../general_widgets/app_logo.dart';
import '../general_widgets/post_card.dart';
import '../general_widgets/refresh_widget.dart';

@RoutePage()
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
      onViewModelReady: (h) {
        h.getUserFeed();
      },
      viewModelBuilder: () => getIt<FeedViewModel>(),
      builder: (context, model, child) => Scaffold(
          body: RefreshWidget(
        // key if you want to add
        onRefresh: () async {
          model.getUserFeed();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.w),
            child: Column(
              children: [
                const AppLogo(),
                SizedBox(
                  // color: Colors.green,
                  height: MediaQuery.of(context).size.height * 0.86,
                  width: MediaQuery.of(context).size.width,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                        log("called");
                        model.loadMoreUserExploreFeed();
                      }
                      return false;
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: model.isBusy
                              ? const Center(child: CircularProgressIndicator())
                              : model.userFeed.isEmpty
                                  ? const Center(child: Text("Empty Feed"))
                                  : ListView.builder(
                                      itemCount: model.userFeed.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        FeedPostModel post =
                                            model.userFeed[index];
                                        return PostCard(
                                          viewModel: model,
                                          post: post,
                                          scrollController: ScrollController(),
                                        );
                                      },
                                    ),
                        ),
                        if (model.isLoadMoreRunning)
                          Padding(
                            padding: EdgeInsets.all(8.0.w),
                            child: const CircularProgressIndicator(),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
