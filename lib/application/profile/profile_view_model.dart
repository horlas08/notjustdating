// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
// import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:ofwhich_v2/application/login_view_model/login_view_model.dart';
import 'package:ofwhich_v2/domain/location/location_service.dart';
import 'package:ofwhich_v2/domain/user_service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:ofwhich/presentation/routes/app_router.gr.dart';
// import 'package:stacked/stacked.dart';

import '../../domain/auth/i_auth_facade.dart';
import '../../domain/chat/chat_service.dart';
import '../../domain/transaction/transaction_service.dart';
import '../../domain/user_service/model/user_object.dart';
import '../../infrastructure/handler/snack_bar_handler.dart';
import '../../injectable.dart';
import '../../presentation/profile/model/circle_model.dart';
import '../../presentation/routes/app_router.dart';
import '../../presentation/routes/app_router.gr.dart';

@LazySingleton()
class ProfileViewModel extends ChangeNotifier {
  final IAuthFacade authFacade;
  final UserService userService;
  final ChatService chatService;
  final SnackbarHandler snackbarHandlerImpl;
  final TransactionService transactionService;

  final ILocationService locationService;

  ProfileViewModel(
      {required this.authFacade,
      required this.snackbarHandlerImpl,
      required this.userService,
      required this.chatService,
      required this.transactionService,
      required this.locationService});

  bool isEditNameButtonActive = false;
  UserModel? user;
  File? firstImage;
  File? secondImage;
  File? thirdImage;
  File? fourthImage;
  File? fifthImage;
  File? sixthImage;

  bool isBusy = false;
  setBusy(val) {
    isBusy = val;
    notifyListeners();
  }

  changeButtonState({required bool val}) {
    isEditNameButtonActive = val;
    notifyListeners();
  }

  Future<File> selextImage({required String type}) async {
    final pickedImage = type == "camera"
        ? await ImagePicker()
            .pickImage(source: ImageSource.camera, imageQuality: 75)
        : await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: 75);
    return File(pickedImage!.path);
  }

  Future<void> updateProfile(
      {String? preference,
      String? relationship,
      required String? dob,
      // required String? preference,
      required String? fullName,
      required File profilePhoto,
      String? userType,
      required String gender,
      String? usernname,
      String? address,
      num? lat,
      num? long,
      List<String>? interests}) async {
    setBusy(true);
    // log(" user type from viewmodel ...... $userType??'emptyyyy'");
    final failureOrSuccessOption = await authFacade.updateProfile(
        preference: preference,
        relationship: relationship,
        dob: dob,
        username: usernname,
        userType: userType ?? "user",
        fullName: fullName,
        profilePhoto: profilePhoto,
        // interests: interests ?? [],
        address: address,
        long: long ?? 0,
        lat: lat ?? 0,
        gender: gender);
    failureOrSuccessOption.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) async {
      // await updateQBUserDetails(
      //   fullName: usernname,
      // );
      setBusy(false);

      // snackbarHandlerImpl.showErrorSnackbar(r);
      getIt<AppRouter>().push(ProfileUpdateSuccessRoute(userType: userType));
    });
  }

  Future<void> updateInterestList({required List<String> interests}) async {
    setBusy(true);
    final result = await authFacade.updateUserInterests(interests: interests);
    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) {
      setBusy(false);
      snackbarHandlerImpl.showSnackbar(r);
    });
  }

  createQBUser({required String login, required String password}) async {
    final result =
        await chatService.createQBUser(login: login, password: password);
    return result.fold((l) {
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) async {
      await chatService.authennticateUser(login: login, password: password);
    });
  }

  getUserSavedLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userString = prefs.getString("user") ?? "";
    if (userString != "") {
      user = UserModel.fromMap(json.decode(userString));
      // log(user!.toMap().toString());
      notifyListeners();
    }
  }

  bool isMainImageSelected = false;
  bool isSecondImageSelected = false;
  bool isThirdImageSelected = false;
  bool isFourthImageSelected = false;
  bool isFifthImageSelected = false;
  bool isSixthImageSelected = false;

  bool isMainImageLoading = false;
  bool isSecondImageLoading = false;
  bool isThirdImageLoading = false;
  bool isFourthImageLoading = false;
  bool isFifthImageLoading = false;
  bool isSixthImageLoading = false;

  bool isMainImageUploadDone = false;
  bool isSecondImagUploadDone = false;
  bool isThirdImageUploadDone = false;
  bool isFourthImageUploadDone = false;
  bool isFifthImageUploadDone = false;
  bool isSixthImageUploadDone = false;

  getUserProfile() async {
    setBusy(true);
    final failureOrSuccessOption = await userService.getUserProfile();
    failureOrSuccessOption.fold((l) {
      setBusy(false);
      // ErrorWidget();
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) {
      setBusy(false);
      user = r;
      // log(user!.toMap().toString());
      notifyListeners();
    });
  }

  int calculateUserAge({required String? date}) {
    List<String> parts = date!.split('-');
    int birthYear = int.parse(parts[0]);
    int birthMonth = int.parse(parts[1]);
    int birthDay = int.parse(parts[2]);

    DateTime birthDate = DateTime(birthYear, birthMonth, birthDay);
    DateTime currentDate = DateTime.now();

    int age = currentDate.year - birthDate.year;

    // Check if the birthday hasn't occurred yet this year
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    // if (kDebugMode) {
    //   print('Age: $age');
    // }
    return age;
    // }
  }

  int updateProfileCount = 0;
  updateQBUserDetails({
    String? email,
    String? fullName,
    String? phone,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String login = prefs.getString("email") ?? "johndoe@gmail.com";
    final result = await chatService.updateUseDetails(
        login: login, email: login, fullName: fullName, phone: phone);
    return result.fold((l) {
      if (updateProfileCount < 3) {
        updateQBUserDetails(email: email, fullName: fullName, phone: phone);
        updateProfileCount++;
      }
      snackbarHandlerImpl.showErrorSnackbar(l.message ?? "");
    }, (r) {
      return r;
    });
  }

  Future<String> uploadUserPhoto(
      {required File image,
      VoidCallback? loadingStarted,
      VoidCallback? loadingFinished,
      VoidCallback? setDone}) async {
    loadingStarted?.call();
    final failureOrSuccessOption =
        await userService.uploadUserPhoto(file: image);
    return failureOrSuccessOption.fold((l) {
      loadingFinished?.call();
      snackbarHandlerImpl.showErrorSnackbar(l.message ?? "");
      return "";
    }, (r) {
      loadingFinished?.call();
      setDone?.call();
      return r;
    });
  }

  Future<void> editProfile({
    String? preference,
    String? relationship,
    String? dob,
    // required String? preference,
    String? fullName,
    // File profilePhoto,
    String? userType,
    String? gender,
    List<String>? interests,
    String? sexual_orientation,
    String? exercise,
    String? bio,
    String? job_title,
    String? employer,
    String? height,
    String? weight,
    String? education_level,
    String? no_of_kids,
    String? drinks,
    String? smokes,
    String? pets,
    String? religion,
    String? value,
    String? languages,
    String? address,
    num? lat,
    num? long,
    Function? navigate,
  }) async {
    setBusy(true);
    await getUserSavedLocally();
    // log(" user type from viewmodel ...... $userType??'emptyyyy'");
    final failureOrSuccessOption = await authFacade.updateProfile(
        preference: preference ?? user?.preference ?? "",
        relationship: relationship ?? user?.relationship_status ?? "single",
        dob: dob ?? user?.dob ?? "n/a",
        userType: userType ?? user?.user_type ?? "user",
        fullName: fullName ?? user?.full_name ?? "John Doe",
        // profilePhoto: profilePhoto,
        interests: interests ?? user?.interests ?? [],
        gender: gender ?? user?.gender ?? "male",
        sexual_orientation:
            sexual_orientation ?? user?.sexual_orientation ?? "heterosexual",
        exercise: exercise ?? user?.exercise ?? "everyday",
        bio: bio ?? user?.bio ?? "",
        job_title: job_title ?? user?.job_title ?? "project manager",
        employer: employer ?? user?.employer ?? "self employed",
        height: height ?? user?.height.toString() ?? "90",
        weight: weight ?? user?.weight.toString() ?? "90",
        education_level:
            education_level ?? user?.education_level ?? "graduate_school",
        no_of_kids: no_of_kids ?? user?.no_of_kids.toString() ?? "0",
        smokes: smokes ?? user?.smokes ?? "never",
        drinks: drinks ?? user?.drinks ?? "never",
        pets: pets ?? user?.pets ?? "dogs",
        address: address,
        long: long,
        lat: lat,
        religion: religion ?? user?.religion ?? "christianity",
        // languages: languages ?? user?.languages ??[] "English",:todo
        value: value ?? user?.value ?? "Beauty & Art");

    failureOrSuccessOption.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) {
      setBusy(false);
      navigate?.call();
      // snackbarHandlerImpl.showErrorSnackbar(r);
      // getIt<AppRouter>().push(ProfileUpdateSuccessRoute(userType: userType));
    });
  }

  // Future<void> updateProfile({
  //   String? preference,
  //   String? relationship,
  //   String? dob,
  //   // required String? preference,
  //   String? fullName,
  //   // File profilePhoto,
  //   String? userType,
  //   String? gender,
  //   List<String>? interests,
  //   String? sexual_orientation,
  //   String? exercise,
  //   String? bio,
  //   String? job_title,
  //   String? employer,
  //   String? height,
  // }) async {}

  Set<String> interestList = {};
  List<CircleModel> interestCircleList = [];
  void addToList({required String value}) {
    interestList.add(value);
    notifyListeners();
  }

  void appenndList({required List<CircleModel> data}) {
    interestCircleList.addAll(data);
    notifyListeners();
  }

  logOut() async {
    // await chatService.logOutQBUser();
    await authFacade.logOutCurrentUser();

    getIt<AppRouter>().pushAndPopUntil(LoginRoute(userType: "user"),
        predicate: (val) => false);
  }

  Future<void> subscribe(
      {required String paymentType, required String plan}) async {
    setBusy(true);
    final result = await transactionService.subscribe(
        plan: plan, paymentMethod: paymentType);

    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) async {
      final successResilt =
          await transactionService.successStatus(referenceId: r.referenceId);
      return successResilt.fold((l) {
        setBusy(false);
        snackbarHandlerImpl.showErrorSnackbar(l.message!);
      }, (r) {
        setBusy(false);
        snackbarHandlerImpl.showSnackbar(r);
      });
    });
  }

  exploreOfwhich() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getString(
      "signUpCredentials",
    );
    if (result != null) {
      Map<String, dynamic> details = json.decode(result);
      getIt<LoginViewModel>()
          .signIn(email: details["email"], password: details["newPassword"]);
    }
  }

  Location? location;
  getCoordinatesFromAddress({required String address}) async {
    setBusy(true);
    final failureOrSuccessOption = await locationService
        .getCoordinatesFromAddress(address: address.trim());
    failureOrSuccessOption.fold((l) {
      setBusy(false);
      // ErrorWidget();
      log("messageeeeeeee:::::${l.message!}");
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) {
      setBusy(false);
      location = r;

      // log(user!.toMap().toString());
      notifyListeners();
    });
  }
}
