// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:ofwhich/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../domain/auth/i_auth_facade.dart';
import '../../domain/chat/chat_service.dart';
import '../../infrastructure/handler/snack_bar_handler.dart';
import '../../injectable.dart';
import '../../presentation/routes/app_router.dart';
import '../../presentation/routes/app_router.gr.dart';

@injectable
class SignUpViewModel extends BaseViewModel {
  final IAuthFacade authFacade;
  final SnackbarHandler snackbarHandlerImpl;
  final ChatService chatService;
  late String password_strength;
  late Color password_strength_color;
  late double password_strength_level;
  final StreamController<int> streamController = StreamController();

  SignUpViewModel(
      {required this.authFacade,
      required this.snackbarHandlerImpl,
      required this.chatService});

  bool isSignupButtonActive = false;
  bool isOtpButtonActive = false;
  bool isCreatePasswordButtonActive = false;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool obscureDefaultPassword = true;

  togglePasswordVisibilty() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  toggleDeafultPasswordVisibilty() {
    obscureDefaultPassword = !obscureDefaultPassword;
    notifyListeners();
  }

  toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  changeButtonState({required bool val}) {
    isSignupButtonActive = val;
    notifyListeners();
  }

  changeOtpButtonnState({required bool val}) {
    isOtpButtonActive = val;
    notifyListeners();
  }

  changeCreatePasswordButtonState({required bool val}) {
    isCreatePasswordButtonActive = val;
    notifyListeners();
  }

  void passwordStrengthShecker(String password) {
    int strength = passwordStrengthLevel(password);
    streamController.add(strength);
  }

  int passwordStrengthLevel(String s) {
    int strength = 0;
    RegExp uppercaseCheck = RegExp(r'^(?=.*?[A-Z])');
    RegExp numberCheck = RegExp(r'^(?=.*[0-9].*[0-9])');
    RegExp specialCharacterCheck = RegExp(r'^(?=.*[!@#$&*])');

    if (uppercaseCheck.hasMatch(s)) {
      strength++;
    }
    if (numberCheck.hasMatch(s)) {
      strength++;
    }
    if (specialCharacterCheck.hasMatch(s)) {
      strength++;
    }
    if (s.length > 7) {
      strength++;
    }

    return strength;
  }

  Future<void> signUp(
      {required String? email, required String userType}) async {
    setBusy(true);
    final failureOrSuccessOption =
        await authFacade.register(email: email, userType: userType);
    failureOrSuccessOption.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) {
      setBusy(false);
      getIt<AppRouter>()
          .push(EmailConfirmationRoute(email: email, userType: userType));
    });
  }

  Future<void> verifyEmail(
      {required String verificationCode,
      String? userType,
      String? email}) async {
    setBusy(true);
    final failureOrSuccessOption =
        await authFacade.verifyEmail(verificationCode: verificationCode);
    failureOrSuccessOption.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) {
      setBusy(false);
      getIt<AppRouter>()
          .push(CreatePasswordRoute(userType: userType, email: email));
    });
  }

  Future<bool> resendOtp(
      {required String email, required String userType}) async {
    // setBusy(true);
    final failureOrSuccessOption =
        await authFacade.resendOtp(email: email, userType: userType);
    return failureOrSuccessOption.fold((l) {
      // setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
      return false;
    }, (r) {
      // setBusy(false);
      return true;
      // getIt<AppRouter>().push(CreatePasswordRoute(userType: userType));
    });
  }

  Future<void> updateDefaultPassword(
      {required String? newPassword,
      required String userType,
      String? email}) async {
    setBusy(true);
    final failureOrSuccessOption = await authFacade.updateDefaultPassword(
        newPassword: newPassword, email: email);
    failureOrSuccessOption.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) async {
      setBusy(false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var details = {"email": email, "newPassword": newPassword};
      prefs.setString("signUpCredentials", json.encode(details));
      // createQBUser(
      // login: email ?? "John Doe", password: newPassword ?? "password12345");

      getIt<AppRouter>().push(AccountCreationSuccess(userType: userType));
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
}
