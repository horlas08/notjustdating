// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:flutter/material.dart' as _i409;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:sign_in_with_apple/sign_in_with_apple.dart' as _i264;

import 'application/chat_view_model/chat_view_model.dart' as _i110;
import 'application/feed_view_model/feed_view_model.dart' as _i521;
import 'application/group_view_model/group_view_model.dart' as _i203;
import 'application/home_view_model/home_view_model.dart' as _i842;
import 'application/login_view_model/login_view_model.dart' as _i427;
import 'application/post_view_model/content_creator/post_view_model.dart'
    as _i422;
import 'application/profile/profile_view_model.dart' as _i695;
import 'application/sign_up/sign_up_view_model.dart' as _i224;
import 'application/splash_screen/splash_view_model.dart' as _i346;
import 'application/transaction/transaction_view_model.dart' as _i228;
import 'domain/auth/i_auth_facade.dart' as _i878;
import 'domain/chat/chat_service.dart' as _i909;
import 'domain/feed/feed_service.dart' as _i39;
import 'domain/group/group_service.dart' as _i801;
import 'domain/http_service/http_service.dart' as _i972;
import 'domain/location/location_service.dart' as _i886;
import 'domain/post/post_service.dart' as _i581;
import 'domain/transaction/transaction_service.dart' as _i1028;
import 'domain/user_service/user_service.dart' as _i812;
import 'infrastructure/auth/i_auth_repo.dart' as _i165;
import 'infrastructure/chat/i_chat_repo.dart' as _i702;
import 'infrastructure/core/auth_injectables.dart' as _i14;
import 'infrastructure/core/injectables.dart' as _i128;
import 'infrastructure/feed/i_feed_repo.dart' as _i372;
import 'infrastructure/group/i_group_repo.dart' as _i267;
import 'infrastructure/handler/snack_bar_handler.dart' as _i116;
import 'infrastructure/http_impl/http_impl.dart' as _i152;
import 'infrastructure/location/location_impl.dart' as _i1016;
import 'infrastructure/post/post_reop.dart' as _i800;
import 'infrastructure/transaction/i_transaction_repo.dart' as _i936;
import 'infrastructure/user/user_repo.dart' as _i881;
import 'presentation/routes/app_router.dart' as _i860;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appInjectables = _$AppInjectables();
    final injectablesModule = _$InjectablesModule();
    gh.lazySingleton<_i116.GoogleSignIn>(() => appInjectables.googleSignIn);
    gh.lazySingleton<_i59.FirebaseAuth>(() => appInjectables.firebaseAuth);
    gh.lazySingleton<_i264.SignInWithApple>(
        () => appInjectables.signInWithApple);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => appInjectables.firestore);
    gh.lazySingleton<_i457.FirebaseStorage>(
        () => appInjectables.firebaseStorage);
    gh.lazySingleton<_i409.GlobalKey<_i409.ScaffoldMessengerState>>(
        () => injectablesModule.globalKey);
    gh.lazySingleton<_i860.AppRouter>(() => _i860.AppRouter());
    gh.lazySingleton<_i886.ILocationService>(
        () => _i1016.LocationServiceImpl());
    gh.lazySingleton<_i116.SnackbarHandler>(() => _i116.SnackbarHandlerImpl(
        state: gh<_i409.GlobalKey<_i409.ScaffoldMessengerState>>()));
    gh.lazySingleton<_i972.IHttpService>(() => _i152.IHttpRepo());
    gh.lazySingleton<_i39.FeedService>(
        () => _i372.IFeedRepo(gh<_i972.IHttpService>()));
    gh.lazySingleton<_i1028.TransactionService>(
        () => _i936.ITransactionRepo(httpService: gh<_i972.IHttpService>()));
    gh.lazySingleton<_i878.IAuthFacade>(() => _i165.IAuthRepo(
          gh<_i59.FirebaseAuth>(),
          gh<_i116.GoogleSignIn>(),
          gh<_i264.SignInWithApple>(),
          gh<_i972.IHttpService>(),
          gh<_i974.FirebaseFirestore>(),
        ));
    gh.lazySingleton<_i801.GroupService>(
        () => _i267.IGroupRepo(httpService: gh<_i972.IHttpService>()));
    gh.lazySingleton<_i812.UserService>(() => _i881.IUserRepo(
          gh<_i972.IHttpService>(),
          gh<_i974.FirebaseFirestore>(),
        ));
    gh.lazySingleton<_i842.HomeViewModel>(() => _i842.HomeViewModel(
          gh<_i878.IAuthFacade>(),
          gh<_i812.UserService>(),
          gh<_i116.SnackbarHandler>(),
        ));
    gh.lazySingleton<_i909.ChatService>(() => _i702.ChatRepo(
          gh<_i59.FirebaseAuth>(),
          gh<_i974.FirebaseFirestore>(),
          gh<_i457.FirebaseStorage>(),
          gh<_i972.IHttpService>(),
        ));
    gh.factory<_i427.LoginViewModel>(() => _i427.LoginViewModel(
          gh<_i909.ChatService>(),
          authFacade: gh<_i878.IAuthFacade>(),
          snackbarHandlerImpl: gh<_i116.SnackbarHandler>(),
        ));
    gh.lazySingleton<_i110.ChatViewModel>(() => _i110.ChatViewModel(
          gh<_i909.ChatService>(),
          gh<_i878.IAuthFacade>(),
          gh<_i812.UserService>(),
          gh<_i116.SnackbarHandler>(),
        ));
    gh.factory<_i521.FeedViewModel>(() => _i521.FeedViewModel(
          gh<_i116.SnackbarHandler>(),
          feedService: gh<_i39.FeedService>(),
          chatService: gh<_i909.ChatService>(),
        ));
    gh.lazySingleton<_i581.PostService>(() => _i800.IPostRepo(
          gh<_i974.FirebaseFirestore>(),
          gh<_i457.FirebaseStorage>(),
          gh<_i59.FirebaseAuth>(),
          httpService: gh<_i972.IHttpService>(),
        ));
    gh.factory<_i224.SignUpViewModel>(() => _i224.SignUpViewModel(
          authFacade: gh<_i878.IAuthFacade>(),
          snackbarHandlerImpl: gh<_i116.SnackbarHandler>(),
          chatService: gh<_i909.ChatService>(),
        ));
    gh.lazySingleton<_i228.TransactionViewModel>(
        () => _i228.TransactionViewModel(
              gh<_i1028.TransactionService>(),
              gh<_i116.SnackbarHandler>(),
            ));
    gh.factory<_i346.SplashViewModel>(() => _i346.SplashViewModel(
          authFacade: gh<_i878.IAuthFacade>(),
          snackbarHandlerImpl: gh<_i116.SnackbarHandler>(),
          transactionService: gh<_i1028.TransactionService>(),
          chatService: gh<_i909.ChatService>(),
          locationService: gh<_i886.ILocationService>(),
          userService: gh<_i812.UserService>(),
        ));
    gh.lazySingleton<_i695.ProfileViewModel>(() => _i695.ProfileViewModel(
          authFacade: gh<_i878.IAuthFacade>(),
          snackbarHandlerImpl: gh<_i116.SnackbarHandler>(),
          userService: gh<_i812.UserService>(),
          chatService: gh<_i909.ChatService>(),
          transactionService: gh<_i1028.TransactionService>(),
          locationService: gh<_i886.ILocationService>(),
        ));
    gh.factory<_i422.PostViewModel>(() => _i422.PostViewModel(
          gh<_i581.PostService>(),
          authFacade: gh<_i878.IAuthFacade>(),
          transactionService: gh<_i1028.TransactionService>(),
          snackbarHandlerImpl: gh<_i116.SnackbarHandler>(),
          userService: gh<_i812.UserService>(),
          chatService: gh<_i909.ChatService>(),
          locationService: gh<_i886.ILocationService>(),
        ));
    gh.factory<_i203.GroupViewModel>(() => _i203.GroupViewModel(
          gh<_i116.SnackbarHandler>(),
          groupService: gh<_i801.GroupService>(),
          chatService: gh<_i909.ChatService>(),
        ));
    return this;
  }
}

class _$AppInjectables extends _i14.AppInjectables {}

class _$InjectablesModule extends _i128.InjectablesModule {}
