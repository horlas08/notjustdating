import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
import 'package:video_player/video_player.dart';

@RoutePage()
class VideoPreview extends StatefulWidget {
  const VideoPreview({super.key, required this.filePath});
  final String filePath;

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _videoPlayerController;

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Preview'),
          elevation: 0,
          backgroundColor: Colors.black26,
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                getIt<AppRouter>().push(UploadPostRoute(
                    file: File(
                      widget.filePath,
                    ),
                    type: "video"));
              },
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: FutureBuilder(
          future: _initVideoPlayer(),
          builder: (context, state) {
            if (state.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return VideoPlayer(_videoPlayerController);
            }
          },
        ));
  }

  @override
  void dispose() {
    _videoPlayerController.pause();
    _videoPlayerController.seekTo(Duration.zero);
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _videoPlayerController.dispose();

    super.deactivate();
  }
}
