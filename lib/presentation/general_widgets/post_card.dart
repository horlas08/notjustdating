// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/feed_view_model/feed_view_model.dart';
import 'package:ofwhich_v2/domain/feed/model/feed_post_model.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.scrollController,
    required this.viewModel,
  });

  final FeedPostModel post;
  final ScrollController scrollController;
  final FeedViewModel viewModel;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> with WidgetsBindingObserver {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isVideoInitialized = false;
  bool _isError = false;
  bool isLiked = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    if (widget.post.file_name.contains(".mp4")) {
      _initializeVideoPlayer();
    }
    widget.scrollController.addListener(_onScroll);
    widget.viewModel.getSavedUser();
    widget.viewModel
        .checkIfLiked(postId: widget.post.id, users: widget.post.likes.users)
        .then((value) {
      isLiked = value;
    });
    // log("like uersssssss " + widget.post.likes.users.length.toString());
    super.initState();
  }

  void _onScroll() {
    if (_isVideoInitialized && _chewieController != null) {
      final RenderObject? renderObject = context.findRenderObject();
      if (renderObject != null && renderObject is RenderBox) {
        final offset = renderObject.localToGlobal(Offset.zero);
        if (offset.dy + renderObject.size.height < 0 ||
            offset.dy > MediaQuery.of(context).size.height) {
          // Video is out of view
          _videoPlayerController?.pause();
        } else {
          // Video is in view
          _videoPlayerController?.play();
        }
      }
    }
  }

  Future<void> _initializeVideoPlayer() async {
    // log(getIt<FirebaseAuth>().currentUser?. ??
    // "Empytttttttttttt........");
    try {
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.post.file_url!));
      await _videoPlayerController!.initialize();
      await _videoPlayerController!.setLooping(true);
      await _videoPlayerController!.play();

      _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          autoInitialize: true,
          autoPlay: true,
          showOptions: false,
          // showControls: true,
          additionalOptions: (context) {
            return <OptionItem>[
              OptionItem(onTap: (context) {}, iconData: Icons.favorite, title: ""),
              OptionItem(onTap: (context) {}, iconData: Icons.favorite, title: ""),
              OptionItem(onTap: (context) {}, iconData: Icons.favorite, title: "")
            ];
          },
          looping: true,
          customControls: const MaterialControls(
            showPlayButton: true,
          ),
          showControls: true,
          allowMuting: true);

      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
      }
    } catch (e) {
      log("errorrr:::::::::::$e");
      if (mounted) {
        setState(() {
          _isError = true;
        });
      }
      // print("Error initializing video: $e");
    }
  }

  // bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.w),
      child: widget.viewModel.isVideo(link: widget.post.file_name)
          ? Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width,
              child: Stack(children: [
                _isError
                    ? const Center(child: Text('Error loading video'))
                    : _isVideoInitialized && _chewieController != null
                        ? Chewie(controller: _chewieController!)
                        : Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: const CircularProgressIndicator(),
                            ),
                          ),
                Positioned(
                    bottom: 50.h,
                    left: 0.w,
                    right: 0.w,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              InkResponse(
                                onTap: () async {
                                  log("getting calledddddd");
                                  // model.checkIfLiked(
                                  //     users: widget.post.likes.users);
                                  bool response = await widget.viewModel
                                      .likeAPost(
                                          post_id: widget.post.id,
                                          users: widget.post.likes.users);
                                  setState(() {
                                    isLiked = response;
                                  });
                                  // setState(() {
                                  //   isLiked = model.checkIfLiked(
                                  //       users: widget.post.likes.users);
                                  //   log("oofnernifkerofer$isLiked");
                                  // });
                                },
                                child: isLiked
                                    ? const Icon(Icons.favorite,
                                        color: Colors.red)
                                    : Image.asset(
                                        "assets/images/pngs/favourite.png",
                                        scale: 2.0),
                              ),
                              SizedBox(width: 20.w),
                              Image.asset("assets/images/pngs/chat.png",
                                  scale: 2.0),
                              SizedBox(width: 20.w),
                              Image.asset("assets/images/pngs/share.png",
                                  scale: 2.0),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(widget.post.comment,
                              style: TextStyle(
                                  fontFamily: Font.inter,
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(height: 10.h),
                          Text(
                              "View all ${widget.post.comments.total_count} comments",
                              style: TextStyle(
                                  fontFamily: Font.inter,
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400))
                        ],
                      ),
                    ))
              ]))
          : Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.post.file_url ?? "")),
                  borderRadius: BorderRadius.circular(20.r)),
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  // Text(post.comment,
                  //     style: TextStyle(fontSize: 15.sp)),
                  Positioned(
                      bottom: 50.h,
                      left: 0.w,
                      right: 0.w,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkResponse(
                                  onTap: () async {
                                    log(isLiked.toString());
                                    if (isLiked) {
                                      bool response = await widget.viewModel
                                          .unlikePost(
                                              post_id: widget.post.id,
                                              users: widget.post.likes.users);
                                      log("response from unnnLikePost :::::$response");
                                      setState(() {
                                        isLiked = !response;
                                      });
                                    } else {
                                      bool response = await widget.viewModel
                                          .likeAPost(
                                              post_id: widget.post.id,
                                              users: widget.post.likes.users);
                                      setState(() {
                                        isLiked = response;
                                      });
                                      log("response from likePost :::::$response");
                                    }
                                  },
                                  child: isLiked
                                      ? const Icon(Icons.favorite,
                                          color: Colors.red)
                                      : Image.asset(
                                          "assets/images/pngs/favourite.png",
                                          scale: 2.0),
                                ),
                                SizedBox(width: 20.w),
                                InkResponse(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          // return DraggableScrollableSheet(
                                          //   initialChildSize: 0.5,
                                          //   minChildSize: 0.3,
                                          //   maxChildSize: 0.9,
                                          //   builder: (BuildContext context,
                                          //       ScrollController
                                          //           scrollController) {
                                          return CommentModal(
                                            viewModel: widget.viewModel,
                                            post: widget.post,
                                          );
                                          //   },
                                          // );
                                          // return CommentModal();
                                        });
                                  },
                                  child: Image.asset(
                                      "assets/images/pngs/chat.png",
                                      scale: 2.0),
                                ),
                                SizedBox(width: 20.w),
                                Image.asset("assets/images/pngs/share.png",
                                    scale: 2.0),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Text(widget.post.comment,
                                style: TextStyle(
                                    fontFamily: Font.inter,
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 10.h),
                            Text(
                                "View all ${widget.post.comments.total_count} comments",
                                style: TextStyle(
                                    fontFamily: Font.inter,
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400))
                          ],
                        ),
                      ))
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_videoPlayerController == null) return;
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _videoPlayerController?.pause();
    } else if (state == AppLifecycleState.resumed) {
      _videoPlayerController?.play();
    }
  }
}

class CommentModal extends StatefulWidget {
  const CommentModal({
    super.key,
    required this.post,
    required this.viewModel,

    // required this.scrollController,
  });
  final FeedPostModel post;
  final FeedViewModel viewModel;
  // final ScrollController scrollController;

  @override
  State<CommentModal> createState() => _CommentModalState();
}

class _CommentModalState extends State<CommentModal>
    with WidgetsBindingObserver {
  double _modalHeight = 0.7;

  @override
  void initState() {
    super.initState();
    widget.viewModel.getPost(postId: widget.post.id);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset > 0) {
      // Keyboard is visible
      setState(() {
        _modalHeight = 0.9; // Adjust the height when keyboard is visible
      });
    } else {
      // Keyboard is not visible
      setState(() {
        _modalHeight = 0.7; // Original height
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: MediaQuery.of(context).size.height * _modalHeight,
      width: MediaQuery.of(context).size.width,
      child: SizedBox(
          child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<List<UserModelForPost>>(
                  stream: widget.viewModel.commentStrean,
                  builder: (context, snapshot) {
                    // UserModelForPost users = snapshot.data!;
                    if (snapshot.hasData) {
                      List<UserModelForPost> users = snapshot.data!;
                      return ListView.builder(
                        itemCount: users.length,
                        // controller: widget.scrollController,
                        // itemCount: widget.viewModel.postModel != null
                        //     ? widget.viewModel.postModel!.comments.total_count
                        //     : widget.post.comments.total_count,
                        itemBuilder: (context, index) {
                          UserModelForPost user = users[index];
                          // widget.viewModel.postModel != null
                          //     ? widget.viewModel.postModel!.comments
                          //         .users[index]
                          //     : widget.post.comments.users[index];
                          return CommentWidget(
                            username: user.full_name,
                            comment: user.comment ?? "N/A",
                            timeAgo: '${index + 1}h',
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ),
          Divider(height: 1.h),
          CommentInputField(
            post: widget.post,
            viewModel: widget.viewModel,
          ),
        ],
      )),
    );
  }
}

class CommentWidget extends StatelessWidget {
  final String username;
  final String comment;
  final String timeAgo;

  const CommentWidget({
    super.key,
    required this.username,
    required this.comment,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 16.0,
            child: Text(
              username[0].toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 12.0.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: ' $comment',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.0.h),
                Text(
                  timeAgo,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.favorite_border, size: 20.h),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class CommentInputField extends StatefulWidget {
  const CommentInputField(
      {super.key, required this.post, required this.viewModel});

  final FeedPostModel post;
  final FeedViewModel viewModel;
  @override
  _CommentInputFieldState createState() => _CommentInputFieldState();
}

class _CommentInputFieldState extends State<CommentInputField> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
      viewModelBuilder: () => getIt<FeedViewModel>(),
      builder: (context, model, child) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 4.0.w),
          color: Colors.white,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 16.0.r,
                child: Text(
                  'U',
                  style: TextStyle(color: Colors.white, height: 10.h),
                ),
              ),
              SizedBox(width: 8.0.w),
              Expanded(
                child: CustomTextFieldWidget(
                  controller: controller,
                  hintText: "Add a comment...",
                  border: InputBorder.none,
                  // decoration: InputDecoration(
                  //   hintText: 'Add a comment...',
                  //   border: InputBorder.none,
                  // ),
                ),
              ),
              model.isBusy
                  ? const CircularProgressIndicator()
                  : TextButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          widget.viewModel.comment(
                              post_id: widget.post.id,
                              comment: controller.text);
                          controller.clear();
                        }
                      },
                      child: Text('Post'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
