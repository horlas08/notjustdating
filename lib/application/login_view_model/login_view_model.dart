import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:ofwhich_v2/domain/chat/chat_service.dart';
import 'package:ofwhich_v2/domain/core/constants/error_messages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../domain/auth/i_auth_facade.dart';
import '../../infrastructure/handler/snack_bar_handler.dart';
import '../../injectable.dart';
import '../../presentation/routes/app_router.dart';
import '../../presentation/routes/app_router.gr.dart';

@injectable
class LoginViewModel extends BaseViewModel {
  final IAuthFacade authFacade;
  final SnackbarHandler snackbarHandlerImpl;
  final ChatService chatService;

  SharedPreferences? prefs;

  LoginViewModel(this.chatService,
      {required this.authFacade, required this.snackbarHandlerImpl});
  bool isSignInButtonActive = false;

  bool obscureConfirmPassword = false;

  changeButtonState({required bool val}) {
    isSignInButtonActive = val;
    notifyListeners();
  }

  togglePasswordVisibilty() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> signIn(
      {required String? email, required String password}) async {
    setBusy(true);
    final failureOrSuccessOption =
        await authFacade.login(email: email, password: password);

    failureOrSuccessOption.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) async {
      // await getIt<GroupViewModel>().manageGroupCreation();

      // await getIt<GroupViewModel>().getCurrentUser();

      setBusy(false);
      r.user_type == "user"
          ? getIt<AppRouter>().push(const BottomNavRoute())
          : getIt<AppRouter>().push(const ContentBottomNavRoute());
    });
  }

  Future<void> signInWithGoogle() async {
    setBusy(true);
    final failureOrSuccessOption = await authFacade.signInWithGoogle();
    failureOrSuccessOption.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) {
      setBusy(false);
      getIt<AppRouter>().push(const BottomNavRoute());
    });
  }

  loginQBUser({required String login, required String password}) async {
    final result =
        await chatService.authennticateUser(login: login, password: password);
    await saveQBLoginDetails(email: login, password: password);
    return result.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().badRequestString);
    }, (r) async {
      // await getIt<GroupViewModel>().manageGroupCreation();
    });
  }

  saveQBLoginDetails({required String email, required String password}) async {
    await initPrefs();
    var payload = {"email": email, "password": password};
    prefs?.setString("qbUserLogin", json.encode(payload));
  }
}
