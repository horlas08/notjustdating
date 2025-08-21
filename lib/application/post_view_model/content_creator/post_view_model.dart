import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:ofwhich_v2/application/profile/profile_view_model.dart';
import 'package:ofwhich_v2/domain/auth/models/location_model.dart';
import 'package:ofwhich_v2/domain/user_service/model/user_object.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart' as r;

import '../../../domain/post/post_service.dart';
import '../../../infrastructure/handler/snack_bar_handler.dart';
import '../../../injectable.dart';
import '../../../presentation/routes/app_router.gr.dart';

@injectable
class PostViewModel extends ProfileViewModel {
  final PostService postService;

  PostViewModel(this.postService,
      {required super.authFacade,
      required super.transactionService,
      required super.snackbarHandlerImpl,
      required super.userService,
      required super.chatService,
      required super.locationService});

  String? userPhotoUrl;
  CameraController? _controller;
  int cameraIndex = 0;
  XFile? videoFile;
  VideoPlayerController? videoPlayerController;
  VoidCallback? videoPlayerListener;
  bool isSearching = false;

  Future<String?> getUserProfilePhoto() async {
    await super.getUserSavedLocally();
    userPhotoUrl = super.user?.photo ?? "N/A";
    notifyListeners();
    return userPhotoUrl;
  }

  void initializeCamera() async {
    CameraDescription description =
        await availableCameras().then((cameras) => cameras[0]);
    _controller = CameraController(description, ResolutionPreset.medium,
        enableAudio: true);
    await _controller!.initialize();
    notifyListeners();
  }

  switchCamera({required int index}) async {
    CameraDescription description =
        await availableCameras().then((cameras) => cameras[index]);
    _controller = CameraController(description, ResolutionPreset.medium,
        enableAudio: true);
    await _controller!.initialize();

    cameraIndex = index;
    notifyListeners();
  }

  takePicture() async {
    // final path =
    //     join((await getTemporaryDirectory()).path, '${DateTime.now()}');
    var file = await _controller!.takePicture();
    log(file.path);
    File newFile = File(file.path);
    getIt<AppRouter>().push(UploadPostRoute(file: newFile, type: "image"));
  }

  Future<void> startVideoRecording() async {
    final CameraController? cameraController = _controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      getIt<SnackbarHandler>().showErrorSnackbar("Select a camera first");
    }
    if (cameraController!.value.isRecordingVideo) {
      return;
    }
    try {
      await cameraController.startVideoRecording();
      log("recording startedddd");
    } on CameraException catch (e) {
      snackbarHandlerImpl.showErrorSnackbar(e.description ?? "");
      return;
    }
  }

  void stopVideoRecording() async {
    final CameraController? cameraController = _controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      final file = await cameraController.stopVideoRecording();
      File newFile = File(file.path);
      getIt<AppRouter>().push(UploadPostRoute(file: newFile, type: "video"));
    } on CameraException catch (e) {
      // _showCameraException(e);
      snackbarHandlerImpl.showErrorSnackbar(e.toString());
      return null;
    }
  }

  createPost(
      {required File file,
      required String locationId,
      required String fileUrl,
      required String comment,
      required List<String> taggedPeople,
      required String isPublic}) async {
    setBusy(true);
    final result = await postService.createPost(
        file: file,
        fileUrl: fileUrl,
        locationnId: locationId,
        comment: comment,
        taggedPeople: taggedPeople,
        isPublic: isPublic);
    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message ?? "");
    }, (r) {
      setBusy(false);
      getIt<AppRouter>().push(const UploadSuccess());
    });
  }

  createDraft(
      {required File file,
      required String locationId,
      required String fileUrl,
      required String comment,
      required List<String> taggedPeople,
      required String isPublic}) async {
    setBusy(true);
    final result = await postService.createDraft(
        file: file,
        fileUrl: fileUrl,
        locationnId: locationId,
        comment: comment,
        taggedPeople: taggedPeople,
        isPublic: isPublic);
    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message ?? "");
    }, (r) {
      setBusy(false);
      getIt<AppRouter>().push(const UploadSuccess());
    });
  }

  uploadFile(
      {required File file,
      required String locationId,
      required String comment,
      required List<String> taggedPeople,
      String? destination,
      String? type,
      required String isPublic}) async {
    setBusy(true);
    final result = await postService.uploadFile(
        file: file,
        locationnId: locationId,
        comment: comment,
        taggedPeople: taggedPeople,
        isPublic: isPublic);
    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message ?? "");
    }, (r) {
      setBusy(false);
      type == "draft"
          ? createDraft(
              file: file,
              locationId: locationId,
              fileUrl: r,
              comment: comment,
              taggedPeople: taggedPeople,
              isPublic: isPublic)
          : createPost(
              file: file,
              fileUrl: r,
              locationId: locationId,
              comment: comment,
              taggedPeople: taggedPeople,
              isPublic: isPublic);
    });
  }

  List<LocationModel> locations = [];
  void getLocations() async {
    setBusy(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userString = prefs.getString("user") ?? "";
    UserModel user = UserModel.fromMap(json.decode(userString));

    final result = await authFacade.getLocations(
        email: user.email ?? "", userType: "user");
    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message ?? "");
    }, (r) {
      setBusy(false);
      locations = r;
      notifyListeners();
    });
  }

  setIsSearching(val) {
    isSearching = val;
    notifyListeners();
  }

  List<LocationModel> filteredLocation = [];
  search({required String val}) {
    filteredLocation = locations
        .where(
            (element) => element.name.toLowerCase().contains(val.toLowerCase()))
        .toList();
    notifyListeners();
  }

  List<UserModel> users = [];
  getUsers() async {
    setBusy(true);
    final result = await userService.getUserList(pageCount: 10);
    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message ?? "");
    }, (r) {
      setBusy(false);
      users = r;
      notifyListeners();
    });
  }

  List<UserModel> filteredUsers = [];
  searchUsers({required String val}) {
    filteredUsers = users.where((element) {
      return element.full_name!.toLowerCase().contains(val.toLowerCase());
    }).toList();
    notifyListeners();
  }

  Future<String?> getThumbnail(String videoPath) async {
    final thumbnail = await r.VideoThumbnail.thumbnailFile(
      video: videoPath,
      imageFormat: r.ImageFormat.JPEG,
      maxHeight: 64, // specify the height of the thumbnail
      quality: 75,
    );
    return thumbnail;
  }
}
