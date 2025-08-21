import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/post_view_model/content_creator/post_view_model.dart';
import 'package:ofwhich_v2/infrastructure/handler/snack_bar_handler.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

import '../../core/font.dart';

@RoutePage()
class ContentCreatorFeedPage extends StatefulWidget {
  const ContentCreatorFeedPage({super.key});

  @override
  State<ContentCreatorFeedPage> createState() => _ContentCreatorFeedPageState();
}

class _ContentCreatorFeedPageState extends State<ContentCreatorFeedPage> {
  CameraController? controller;
  int cameraIndex = 0;
  XFile? videoFile;
  VideoPlayerController? videoPlayerController;
  VoidCallback? videoPlayerListener;

  @override
  void initState() {
    _initializeCamera();
    // getIt<PostViewModel>().initializeCamera();
    super.initState();
  }

  void _initializeCamera() async {
    CameraDescription description =
        await availableCameras().then((cameras) => cameras[0]);
    controller = CameraController(description, ResolutionPreset.medium,
        enableAudio: true);
    await controller!.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  switchCamera({required int index}) async {
    CameraDescription description =
        await availableCameras().then((cameras) => cameras[index]);
    controller = CameraController(description, ResolutionPreset.medium,
        enableAudio: true);
    await controller!.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      cameraIndex = index;
    });
  }

  takePicture() async {
    // final path =
    //     join((await getTemporaryDirectory()).path, '${DateTime.now()}');
    var file = await controller!.takePicture();
    log(file.path);
    File newFile = File(file.path);
    getIt<AppRouter>().push(UploadPostRoute(file: newFile, type: "image"));
  }

  Future<void> startVideoRecording() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      getIt<SnackbarHandler>().showErrorSnackbar("Select a camera first");
    }
    if (cameraController!.value.isRecordingVideo) {
      return;
    }
    try {
      await cameraController.startVideoRecording();
      log("recording startedddd :::::: ${cameraController.value.isRecordingVideo}");
    } on CameraException catch (e) {
      getIt<SnackbarHandler>().showErrorSnackbar(e.description ?? "");
      return;
    }
  }

  void stopVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      final file = await cameraController.stopVideoRecording();
      File newFile = File(file.path);
      getIt<AppRouter>().push(VideoPreview(filePath: newFile.path));
    } on CameraException catch (_) {
      // _showCameraException(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostViewModel>.reactive(
      onViewModelReady: (h) {
        // h.initializeCamera();
      },
      viewModelBuilder: () => getIt<PostViewModel>(),
      builder: (context, model, child) => Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            if (controller == null) ...[
              Container()
            ] else ...[
              SizedBox(
                height: MediaQuery.of(context).size.height,
                // aspectRatio: _controller.value.aspectRatio,
                child: CameraPreview(controller!),
              ),
            ],
            Positioned(
                top: 50.h,
                left: 10.0.w,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    // getIt<AppRouter>().pop();
                  },
                  child: Image.asset(
                      "assets/images/pngs/cancel_camera_icon.png",
                      scale: 1.5),
                )),
            Positioned(
              top: 50.h,
              right: 10.0.w,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      model.switchCamera(index: cameraIndex == 1 ? 0 : 1);
                    },
                    child: Column(
                      children: [
                        Image.asset("assets/images/pngs/flip_icon.png",
                            scale: 1.5),
                        Text("Flip",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300,
                                fontFamily: Font.rubik)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Image.asset("assets/images/pngs/speed_icon.png", scale: 1.5),
                  Text("Speed",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                          fontFamily: Font.rubik)),
                  SizedBox(height: 10.h),
                  Image.asset("assets/images/pngs/Ikon.png", scale: 1.5),
                  Text("Filter",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                          fontFamily: Font.rubik)),
                  SizedBox(height: 10.h),
                  Image.asset("assets/images/pngs/timer_icon.png", scale: 1.5),
                  Text("Timer",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                          fontFamily: Font.rubik))
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      controller != null && controller!.value.isRecordingVideo
                          ? GestureDetector(
                              onTap: () {
                                stopVideoRecording();
                              },
                              child: Container(
                                height: 100.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 1.5)),
                                child: Icon(
                                  Icons.stop_circle,
                                  size: 70.h,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                takePicture();
                              },
                              onLongPress: () {
                                startVideoRecording();
                                setState(() {});
                              },
                              child: Container(
                                height: 100.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 1.5)),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  minRadius: 90.r,
                                  child: SizedBox(
                                    height: 70.h,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      minRadius: 50.r,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(
                        width: 20.w,
                      ),
                      GestureDetector(
                        onTap: () async {
                          // getIt<ProfileViewModel>()
                          //     .selextImage(type: "gallery");
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.any, // Allow all file types
                            allowMultiple:
                                true, // Allow multiple file selection
                          );

                          if (result != null) {
                            List<PlatformFile> files = result.files;
                            for (var file in files) {
                              print('File Name: ${file.name}');
                              print('File Path: ${file.path}');
                            }
                          } else {
                            print('No file selected');
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.14,
                          child: Image.asset(
                              "assets/images/pngs/image_placeholder.png"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   child:
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    videoPlayerController?.dispose();
    super.dispose();
  }
}
