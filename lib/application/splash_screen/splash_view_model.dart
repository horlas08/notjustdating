// import 'dart:developer';

import 'package:injectable/injectable.dart';
// import 'package:ofwhich_v2/application/group_view_model/group_view_model.dart';
import 'package:ofwhich_v2/injectable.dart';
// import 'package:stacked/stacked.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/routes/app_router.dart';
import '../../presentation/routes/app_router.gr.dart';
import '../profile/profile_view_model.dart';

@injectable
class SplashViewModel extends ProfileViewModel {
  bool agreedToTerms = false;

  SplashViewModel(
      {required super.authFacade,
      required super.snackbarHandlerImpl,
      required super.transactionService,
      required super.chatService,
      required super.locationService,
      required super.userService});

  toggleAgreement({required bool val}) {
    agreedToTerms = val;
    notifyListeners();
  }

  Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isFirstTime = prefs.getBool('first_time');
    if (isFirstTime != null && !isFirstTime) {
      prefs.setBool('first_time', false);

      return false;
    } else {
      prefs.setBool('first_time', false);
      return true;
    }
  }

  navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token") ?? "";

    bool firstTime = await isFirstTime();
    if (firstTime) {
      getIt<AppRouter>().push(const OnboardingIndex());
    } else {
      if (token == "") {
        getIt<AppRouter>().replace(LoginRoute());
      } else {
        await super.getUserSavedLocally();
        // await getIt<GroupViewModel>().manageGroupCreation();
        // await getIt<GroupViewModel>().getCurrentUser();
        if (super.user != null && super.user!.user_type != null) {
          if (super.user!.user_type == "user") {
            getIt<AppRouter>().replace(const BottomNavRoute());
          } else {
            getIt<AppRouter>().replace(const ContentBottomNavRoute());
          }
        } else {
          getIt<AppRouter>().replace(LoginRoute());
        }
      }
    }
  }
}
