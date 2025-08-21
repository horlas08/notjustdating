import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_button.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

import '../../../application/post_view_model/content_creator/post_view_model.dart';
// import '../../../application/profile/profile_view_model.dart';
import '../../../injectable.dart';
import '../../core/font.dart';
import '../../routes/app_router.dart';

@RoutePage()
class UploadPostScreen extends StatefulWidget {
  const UploadPostScreen({super.key, required this.file, required this.type});
  final File file;
  final String type;

  @override
  State<UploadPostScreen> createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  VideoPlayerController? _videoPlayerController;

  String videoThumbnail = "";

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostViewModel>.reactive(
      viewModelBuilder: () => getIt<PostViewModel>(),
      onViewModelReady: (h) async {
        videoThumbnail = (await h.getThumbnail(widget.file.path)) ?? "N/A";
      },
      builder: (context, model, child) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: widget.type == "video"
                    ? FileImage(File(videoThumbnail))
                    : FileImage(widget.file),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackButton(
                      color: Colors.white,
                    ),
                    Card(
                      elevation: 3.0,
                      color: Colors.transparent,
                      shadowColor: Colors.grey,
                      child: SizedBox(
                        height: 40.h,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0.w,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                  "assets/images/pngs/music_symbol.png"),
                              Text("Remember - Asake",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontFamily: Font.rubik)),
                              Image.asset(
                                "assets/images/pngs/cancel_camera_icon.png",
                                scale: 2.8,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        // Image.asset(
                        //   "assets/images/pngs/flip_icon.png",
                        //   scale: 1.5,
                        //   color: Colors.white,
                        // ),
                        // Text("Flip",
                        //     style: TextStyle(
                        //         fontSize: 14.sp,
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.w300,
                        //         fontFamily: Font.rubik)),
                        // SizedBox(height: 20.h),
                        // Image.asset("assets/images/pngs/speed_icon.png",
                        //     color: Colors.white, scale: 1.5),
                        // Text("Speed",
                        //     style: TextStyle(
                        //         fontSize: 14.sp,
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.w300,
                        //         fontFamily: Font.rubik)),
                        // SizedBox(height: 20.h),
                        // Image.asset(
                        //   "assets/images/pngs/Ikon.png",
                        //   scale: 1.5,
                        //   color: Colors.white,
                        // ),
                        // Text("Filter",
                        //     style: TextStyle(
                        //         fontSize: 14.sp,
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.w300,
                        //         fontFamily: Font.rubik)),
                        // SizedBox(height: 20.h),
                        // Image.asset("assets/images/pngs/timer_icon.png",
                        //     color: Colors.white, scale: 1.5),
                        // Text("Timer",
                        //     style: TextStyle(
                        //         fontSize: 14.sp,
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.w300,
                        //         fontFamily: Font.rubik)),
                        SizedBox(height: 20.h),
                        Image.asset("assets/images/pngs/text_icon.png",
                            color: Colors.white, scale: 1.5),
                        Text("Text",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontFamily: Font.rubik))
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.11,
          child: CustomButton(
            onPressed: () {
              getIt<AppRouter>().push(UploadPostAddText(
                  selectedPhoto: widget.file, type: widget.type));
            },
            height: 70.h,
            width: MediaQuery.of(context).size.width * 0.85,
            borderRadius: BorderRadius.circular(15.r),
            child: Text(
              "Next",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: Font.inter,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController?.pause();
    _videoPlayerController?.seekTo(Duration.zero);
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _videoPlayerController?.dispose();

    super.deactivate();
  }
}
