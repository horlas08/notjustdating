import 'dart:convert';
// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ofwhich_v2/application/home_view_model/model/filter_data_model.dart';
import 'package:ofwhich_v2/domain/core/constants/error_messages.dart';
import 'package:ofwhich_v2/domain/user_service/user_service.dart';
import 'package:ofwhich_v2/presentation/home/user/matched_page.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:stacked/stacked.dart';

import '../../domain/auth/i_auth_facade.dart';
import '../../domain/auth/models/location_model.dart';
import '../../domain/user_service/model/user_gift.dart';
import '../../domain/user_service/model/user_object.dart';
import '../../infrastructure/handler/snack_bar_handler.dart';
import '../../infrastructure/user/model/feed.dart';
import '../../injectable.dart';
import '../../presentation/routes/app_router.dart';

@LazySingleton()
class HomeViewModel extends ChangeNotifier {
  final IAuthFacade authFacade;
  final UserService userService;
  final SnackbarHandler snackbarHandlerImpl;

  HomeViewModel(this.authFacade, this.userService, this.snackbarHandlerImpl);
  FeedsModel? feeds;
  List<UserModel> profileLikes = [];
  LocationModel? selectedLocation;
  FilterDataModel? filterDataModel;

  // HomeViewModel.withDefaultValues() {
  //   getSavedFilterValues();
  // }
  bool isBusy = false;
  setBusy(val) {
    isBusy = val;
    // notifyListeners();
  }

  getFeed() async {
    setBusy(true);
    final failureOrSuccessOption = await userService.getFeeds();
    return failureOrSuccessOption.fold((l) {
      setBusy(false);
      notifyListeners();
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) {
      setBusy(false);
      feeds = r;
      notifyListeners();
    });
  }

  getFilterdFeed(
      {int? pagainationCount,
      int? radiusStart,
      int? locationId,
      int? radiusEnd,
      int? ageRangeStart,
      int? ageRangeEnd}) async {
    setBusy(true);
    final failureOrSuccessOption = await userService.getFilteredFeeds(
        pagainationCount: pagainationCount,
        locationId: locationId,
        ageRangeStart: ageRangeStart,
        ageRangeEnd: ageRangeEnd,
        radiusStart: radiusStart,
        radiusEnd: radiusEnd);
    saveFilterValues(
        filterValues: FilterDataModel(
            locationId: locationId ?? 1,
            ageRangeStart: ageRangeStart!,
            ageRangeEnd: ageRangeEnd!,
            radiusStart: radiusStart!,
            radiusEnd: radiusEnd!));
    return failureOrSuccessOption.fold((l) {
      setBusy(false);
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().badRequestString);
    }, (r) {
      setBusy(false);

      // log("from filtered feed:::::" + feeds!.toJson());
      feeds = r;
      notifyListeners();
    });
  }

  saveFilterValues({FilterDataModel? filterValues}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("filterValues", filterValues!.toJson());
  }

  getSavedFilterValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValues = prefs.getString("filterValues") ?? "";
    if (stringValues.isNotEmpty) {
      filterDataModel = FilterDataModel.fromMap(json.decode(stringValues));
      notifyListeners();
    }
  }

  likeProfile({required UserModel? user}) async {
    // setBusy(true);
    final failureOrSuccessOption =
        await userService.likeProfile(userId: user?.id.toString());
    return failureOrSuccessOption.fold((l) {
      // setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) {
      getIt<AppRouter>().push(MatchedRoute(user1: user!));
      getProfileLikes();
      getFeed();
      // setBusy(false);
      // snackbarHandlerImpl.showSnackbar(r);
      notifyListeners();
    });
  }

  getProfileLikes() async {
    setBusy(true);
    final failureOrSuccessOption = await userService.getProfileLikes();
    return failureOrSuccessOption.fold((l) {
      setBusy(false);
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().badRequestString);
    }, (r) {
      setBusy(false);
      profileLikes = r.where((e) => e.isMatched == true).toList();
      notifyListeners();
    });
  }

  setSelectedLocation(val) {
    selectedLocation = val;
    notifyListeners();
  }

  List<UserGift> gifts = [];
  Future<void> getGifts() async {
    setBusy(true);
    final result = await userService.getGifts();
    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().badRequestString);
    }, (r) {
      setBusy(false);
      gifts = r;
      notifyListeners();
    });
  }

  Future<void> sendGiftToUser(
      {required num amount,
      required int beneficiaryId,
      required int giftId,
      String? paymentMethod,
      UserModel? user,
      int? pin}) async {
    setBusy(true);
    final result = await userService.sendGift(
        amount: amount,
        beneficiaryId: beneficiaryId,
        giftId: giftId,
        paymentMethod: paymentMethod);
    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().badRequestString);
    }, (r) {
      setBusy(false);
      getIt<AppRouter>().push(SendFloweSuccess(user: user!));
      // snackbarHandlerImpl.showErrorSnackbar(r);
    });
  }

  removeUserAtParticularIndex({required int currentIndex}) {
    feeds!.users!.removeAt(currentIndex);
    notifyListeners();
  }
}
