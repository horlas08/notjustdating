// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i93;

import 'package:auto_route/auto_route.dart' as _i90;
import 'package:firebase_messaging/firebase_messaging.dart' as _i97;
import 'package:flutter/cupertino.dart' as _i94;
import 'package:flutter/material.dart' as _i91;
import 'package:ofwhich_v2/application/home_view_model/home_view_model.dart'
    as _i100;
import 'package:ofwhich_v2/domain/group/models/group_model.dart' as _i96;
import 'package:ofwhich_v2/domain/user_service/model/date_model.dart' as _i98;
import 'package:ofwhich_v2/domain/user_service/model/date_payment_details.dart'
    as _i95;
import 'package:ofwhich_v2/domain/user_service/model/user_gift.dart' as _i101;
import 'package:ofwhich_v2/domain/user_service/model/user_object.dart' as _i92;
import 'package:ofwhich_v2/presentation/auth/create_password/account_creation_success.dart'
    as _i1;
import 'package:ofwhich_v2/presentation/auth/create_password/create_password.dart'
    as _i15;
import 'package:ofwhich_v2/presentation/auth/email_confirmation/email_confirmation.dart'
    as _i38;
import 'package:ofwhich_v2/presentation/auth/forget_password/forget_password.dart'
    as _i41;
import 'package:ofwhich_v2/presentation/auth/forget_password/forgot_password_otp.dart'
    as _i42;
import 'package:ofwhich_v2/presentation/auth/forget_password/passwowrd_reset_success.dart'
    as _i57;
import 'package:ofwhich_v2/presentation/auth/forget_password/reset_password.dart'
    as _i68;
import 'package:ofwhich_v2/presentation/auth/login/login_screen.dart' as _i48;
import 'package:ofwhich_v2/presentation/auth/register/register.dart' as _i66;
import 'package:ofwhich_v2/presentation/bottom_nav/bottom_nav_page.dart' as _i2;
import 'package:ofwhich_v2/presentation/bottom_nav/content_creator/content_creator_nav.dart'
    as _i6;
import 'package:ofwhich_v2/presentation/chat/chat_details.dart' as _i3;
import 'package:ofwhich_v2/presentation/chat/chat_home.dart' as _i4;
import 'package:ofwhich_v2/presentation/chat/file_upload.dart' as _i40;
import 'package:ofwhich_v2/presentation/chat/pay_for_date.dart' as _i59;
import 'package:ofwhich_v2/presentation/chat/payment_successful.dart' as _i60;
import 'package:ofwhich_v2/presentation/chat/plan_date.dart' as _i63;
import 'package:ofwhich_v2/presentation/chat/web_view_for_payment.dart' as _i18;
import 'package:ofwhich_v2/presentation/feed/content_creator/add_text.dart'
    as _i77;
import 'package:ofwhich_v2/presentation/feed/content_creator/content_creator_feed.dart'
    as _i8;
import 'package:ofwhich_v2/presentation/feed/content_creator/location/add_location.dart'
    as _i47;
import 'package:ofwhich_v2/presentation/feed/content_creator/tag_people/tag_users.dart'
    as _i76;
import 'package:ofwhich_v2/presentation/feed/content_creator/upload_post.dart'
    as _i78;
import 'package:ofwhich_v2/presentation/feed/content_creator/upload_success.dart'
    as _i79;
import 'package:ofwhich_v2/presentation/feed/content_creator/widgets/video_preview.dart'
    as _i86;
import 'package:ofwhich_v2/presentation/feed/feed.dart' as _i39;
import 'package:ofwhich_v2/presentation/group_chat/group_chat_home.dart'
    as _i45;
import 'package:ofwhich_v2/presentation/group_chat/group_chat_screen.dart'
    as _i44;
import 'package:ofwhich_v2/presentation/home/content_creator/content_creator_home.dart'
    as _i10;
import 'package:ofwhich_v2/presentation/home/user/constants/swipe_enum.dart'
    as _i99;
import 'package:ofwhich_v2/presentation/home/user/home_page.dart' as _i46;
import 'package:ofwhich_v2/presentation/home/user/matched_page.dart' as _i49;
import 'package:ofwhich_v2/presentation/home/user/news_screen.dart' as _i50;
import 'package:ofwhich_v2/presentation/home/user/selected_profile.dart'
    as _i70;
import 'package:ofwhich_v2/presentation/home/user/send_flower_page.dart'
    as _i72;
import 'package:ofwhich_v2/presentation/home/user/send_flower_success.dart'
    as _i71;
import 'package:ofwhich_v2/presentation/home/user/your_interests.dart' as _i89;
import 'package:ofwhich_v2/presentation/notification/content_creator/content_creator_notfication.dart'
    as _i11;
import 'package:ofwhich_v2/presentation/notification/notifications.dart'
    as _i51;
import 'package:ofwhich_v2/presentation/onboarding/onboarding.dart' as _i54;
import 'package:ofwhich_v2/presentation/onboarding/onboarding1.dart' as _i55;
import 'package:ofwhich_v2/presentation/onboarding/onboarding_index.dart'
    as _i53;
import 'package:ofwhich_v2/presentation/profile/content_creator/content_cr_dob.dart'
    as _i16;
import 'package:ofwhich_v2/presentation/profile/content_creator/gender.dart'
    as _i9;
import 'package:ofwhich_v2/presentation/profile/content_creator/profile_photo.dart'
    as _i7;
import 'package:ofwhich_v2/presentation/profile/content_creator/user_name.dart'
    as _i81;
import 'package:ofwhich_v2/presentation/profile/user/choose_your_circle.dart'
    as _i5;
import 'package:ofwhich_v2/presentation/profile/user/date_of_birth.dart'
    as _i17;
import 'package:ofwhich_v2/presentation/profile/user/dating_interest.dart'
    as _i19;
import 'package:ofwhich_v2/presentation/profile/user/dating_questions.dart'
    as _i20;
import 'package:ofwhich_v2/presentation/profile/user/edit_name.dart' as _i26;
import 'package:ofwhich_v2/presentation/profile/user/gender_screen.dart'
    as _i43;
import 'package:ofwhich_v2/presentation/profile/user/photo_selection.dart'
    as _i62;
import 'package:ofwhich_v2/presentation/profile/user/profile_photos.dart'
    as _i64;
import 'package:ofwhich_v2/presentation/profile/user/profile_update_success.dart'
    as _i65;
import 'package:ofwhich_v2/presentation/profile/user/relationship_status.dart'
    as _i67;
import 'package:ofwhich_v2/presentation/profile/user/user_address.dart' as _i80;
import 'package:ofwhich_v2/presentation/profile/user/user_name.dart' as _i82;
import 'package:ofwhich_v2/presentation/search/content_creator/search_cr.dart'
    as _i13;
import 'package:ofwhich_v2/presentation/settings/content_creator/content_creator_settings.dart'
    as _i14;
import 'package:ofwhich_v2/presentation/settings/content_creator/notification_settings.dart'
    as _i52;
import 'package:ofwhich_v2/presentation/settings/content_creator/password_manager/password_manager.dart'
    as _i56;
import 'package:ofwhich_v2/presentation/settings/content_creator/password_manager/password_update_success.dart'
    as _i58;
import 'package:ofwhich_v2/presentation/settings/content_creator/personal_settings.dart'
    as _i61;
import 'package:ofwhich_v2/presentation/settings/content_creator/security_settings.dart'
    as _i69;
import 'package:ofwhich_v2/presentation/settings/user/settings_screen.dart'
    as _i73;
import 'package:ofwhich_v2/presentation/splash_screen/splash_screenn.dart'
    as _i74;
import 'package:ofwhich_v2/presentation/subscription/subscriptionn_home.dart'
    as _i75;
import 'package:ofwhich_v2/presentation/user_profile/content_creator/content_creator_profile.dart'
    as _i12;
import 'package:ofwhich_v2/presentation/user_profile/edit_profile/user/edit_age.dart'
    as _i32;
import 'package:ofwhich_v2/presentation/user_profile/edit_profile/user/edit_drinking.dart'
    as _i21;
import 'package:ofwhich_v2/presentation/user_profile/edit_profile/user/edit_education.dart'
    as _i22;
import 'package:ofwhich_v2/presentation/user_profile/edit_profile/user/edit_exercise.dart'
    as _i23;
import 'package:ofwhich_v2/presentation/user_profile/edit_profile/user/edit_gender.dart'
    as _i33;
import 'package:ofwhich_v2/presentation/user_profile/edit_profile/user/edit_height.dart'
    as _i24;
import 'package:ofwhich_v2/presentation/user_profile/edit_profile/user/edit_interests.dart'
    as _i25;
import 'package:ofwhich_v2/presentation/user_profile/edit_profile/user/edit_name.dart'
    as _i34;
import 'package:ofwhich_v2/presentation/user_profile/edit_profile/user/edit_no_of_kids.dart'
    as _i27;
import 'package:ofwhich_v2/presentation/user_profile/edit_profile/user/edit_religion.dart'
    as _i29;
import 'package:ofwhich_v2/presentation/user_profile/edit_profile/user/edit_sexual_orientation.dart'
    as _i30;
import 'package:ofwhich_v2/presentation/user_profile/edit_profile/user/edit_smoking.dart'
    as _i31;
import 'package:ofwhich_v2/presentation/user_profile/edit_profile/user/edit_value.dart'
    as _i35;
import 'package:ofwhich_v2/presentation/user_profile/edit_profile/user/edit_weight.dart'
    as _i36;
import 'package:ofwhich_v2/presentation/user_profile/edit_profile/user/edit_work.dart'
    as _i37;
import 'package:ofwhich_v2/presentation/user_profile/edit_profile/user/eidt_pets.dart'
    as _i28;
import 'package:ofwhich_v2/presentation/user_profile/user/user_profile.dart'
    as _i84;
import 'package:ofwhich_v2/presentation/user_profile/user/user_profile_details.dart'
    as _i83;
import 'package:ofwhich_v2/presentation/usertype_selection/user_type_selection.dart'
    as _i85;
import 'package:ofwhich_v2/presentation/wallet/wallet_deposit.dart' as _i87;
import 'package:ofwhich_v2/presentation/wallet/wallet_home_page.dart' as _i88;

/// generated route for
/// [_i1.AccountCreationSuccess]
class AccountCreationSuccess
    extends _i90.PageRouteInfo<AccountCreationSuccessArgs> {
  AccountCreationSuccess({
    _i91.Key? key,
    required String userType,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          AccountCreationSuccess.name,
          args: AccountCreationSuccessArgs(
            key: key,
            userType: userType,
          ),
          initialChildren: children,
        );

  static const String name = 'AccountCreationSuccess';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AccountCreationSuccessArgs>();
      return _i1.AccountCreationSuccess(
        key: args.key,
        userType: args.userType,
      );
    },
  );
}

class AccountCreationSuccessArgs {
  const AccountCreationSuccessArgs({
    this.key,
    required this.userType,
  });

  final _i91.Key? key;

  final String userType;

  @override
  String toString() {
    return 'AccountCreationSuccessArgs{key: $key, userType: $userType}';
  }
}

/// generated route for
/// [_i2.BottomNavScreen]
class BottomNavRoute extends _i90.PageRouteInfo<void> {
  const BottomNavRoute({List<_i90.PageRouteInfo>? children})
      : super(
          BottomNavRoute.name,
          initialChildren: children,
        );

  static const String name = 'BottomNavRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i2.BottomNavScreen();
    },
  );
}

/// generated route for
/// [_i3.ChatDetails]
class ChatDetails extends _i90.PageRouteInfo<ChatDetailsArgs> {
  ChatDetails({
    _i91.Key? key,
    required _i92.UserModel matchedUser,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          ChatDetails.name,
          args: ChatDetailsArgs(
            key: key,
            matchedUser: matchedUser,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatDetails';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatDetailsArgs>();
      return _i3.ChatDetails(
        key: args.key,
        matchedUser: args.matchedUser,
      );
    },
  );
}

class ChatDetailsArgs {
  const ChatDetailsArgs({
    this.key,
    required this.matchedUser,
  });

  final _i91.Key? key;

  final _i92.UserModel matchedUser;

  @override
  String toString() {
    return 'ChatDetailsArgs{key: $key, matchedUser: $matchedUser}';
  }
}

/// generated route for
/// [_i4.ChatHomeScreen]
class ChatHomeRoute extends _i90.PageRouteInfo<void> {
  const ChatHomeRoute({List<_i90.PageRouteInfo>? children})
      : super(
          ChatHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatHomeRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i4.ChatHomeScreen();
    },
  );
}

/// generated route for
/// [_i5.ChhoseYourCircle]
class ChhoseYourCircle extends _i90.PageRouteInfo<ChhoseYourCircleArgs> {
  ChhoseYourCircle({
    _i91.Key? key,
    _i93.File? selectedPhoto,
    String? firstName,
    String? dob,
    String? userType,
    String? username,
    required String gender,
    String? preference,
    required String relationshipStatus,
    String? address,
    required num lat,
    required num long,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          ChhoseYourCircle.name,
          args: ChhoseYourCircleArgs(
            key: key,
            selectedPhoto: selectedPhoto,
            firstName: firstName,
            dob: dob,
            userType: userType,
            username: username,
            gender: gender,
            preference: preference,
            relationshipStatus: relationshipStatus,
            address: address,
            lat: lat,
            long: long,
          ),
          initialChildren: children,
        );

  static const String name = 'ChhoseYourCircle';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChhoseYourCircleArgs>();
      return _i5.ChhoseYourCircle(
        key: args.key,
        selectedPhoto: args.selectedPhoto,
        firstName: args.firstName,
        dob: args.dob,
        userType: args.userType,
        username: args.username,
        gender: args.gender,
        preference: args.preference,
        relationshipStatus: args.relationshipStatus,
        address: args.address,
        lat: args.lat,
        long: args.long,
      );
    },
  );
}

class ChhoseYourCircleArgs {
  const ChhoseYourCircleArgs({
    this.key,
    this.selectedPhoto,
    this.firstName,
    this.dob,
    this.userType,
    this.username,
    required this.gender,
    this.preference,
    required this.relationshipStatus,
    this.address,
    required this.lat,
    required this.long,
  });

  final _i91.Key? key;

  final _i93.File? selectedPhoto;

  final String? firstName;

  final String? dob;

  final String? userType;

  final String? username;

  final String gender;

  final String? preference;

  final String relationshipStatus;

  final String? address;

  final num lat;

  final num long;

  @override
  String toString() {
    return 'ChhoseYourCircleArgs{key: $key, selectedPhoto: $selectedPhoto, firstName: $firstName, dob: $dob, userType: $userType, username: $username, gender: $gender, preference: $preference, relationshipStatus: $relationshipStatus, address: $address, lat: $lat, long: $long}';
  }
}

/// generated route for
/// [_i6.ContentBottomNavScreen]
class ContentBottomNavRoute extends _i90.PageRouteInfo<void> {
  const ContentBottomNavRoute({List<_i90.PageRouteInfo>? children})
      : super(
          ContentBottomNavRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContentBottomNavRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i6.ContentBottomNavScreen();
    },
  );
}

/// generated route for
/// [_i7.ContentCrProfilePhoto]
class ContentCrProfilePhoto
    extends _i90.PageRouteInfo<ContentCrProfilePhotoArgs> {
  ContentCrProfilePhoto({
    _i91.Key? key,
    String? userType,
    String? firstName,
    String? username,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          ContentCrProfilePhoto.name,
          args: ContentCrProfilePhotoArgs(
            key: key,
            userType: userType,
            firstName: firstName,
            username: username,
          ),
          initialChildren: children,
        );

  static const String name = 'ContentCrProfilePhoto';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ContentCrProfilePhotoArgs>(
          orElse: () => const ContentCrProfilePhotoArgs());
      return _i7.ContentCrProfilePhoto(
        key: args.key,
        userType: args.userType,
        firstName: args.firstName,
        username: args.username,
      );
    },
  );
}

class ContentCrProfilePhotoArgs {
  const ContentCrProfilePhotoArgs({
    this.key,
    this.userType,
    this.firstName,
    this.username,
  });

  final _i91.Key? key;

  final String? userType;

  final String? firstName;

  final String? username;

  @override
  String toString() {
    return 'ContentCrProfilePhotoArgs{key: $key, userType: $userType, firstName: $firstName, username: $username}';
  }
}

/// generated route for
/// [_i8.ContentCreatorFeedPage]
class ContentCreatorFeedPage extends _i90.PageRouteInfo<void> {
  const ContentCreatorFeedPage({List<_i90.PageRouteInfo>? children})
      : super(
          ContentCreatorFeedPage.name,
          initialChildren: children,
        );

  static const String name = 'ContentCreatorFeedPage';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i8.ContentCreatorFeedPage();
    },
  );
}

/// generated route for
/// [_i9.ContentCreatorGender]
class ContentCreatorGender
    extends _i90.PageRouteInfo<ContentCreatorGenderArgs> {
  ContentCreatorGender({
    _i91.Key? key,
    String? userType,
    String? firstName,
    String? username,
    _i93.File? selectedPhoto,
    String? dob,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          ContentCreatorGender.name,
          args: ContentCreatorGenderArgs(
            key: key,
            userType: userType,
            firstName: firstName,
            username: username,
            selectedPhoto: selectedPhoto,
            dob: dob,
          ),
          initialChildren: children,
        );

  static const String name = 'ContentCreatorGender';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ContentCreatorGenderArgs>(
          orElse: () => const ContentCreatorGenderArgs());
      return _i9.ContentCreatorGender(
        key: args.key,
        userType: args.userType,
        firstName: args.firstName,
        username: args.username,
        selectedPhoto: args.selectedPhoto,
        dob: args.dob,
      );
    },
  );
}

class ContentCreatorGenderArgs {
  const ContentCreatorGenderArgs({
    this.key,
    this.userType,
    this.firstName,
    this.username,
    this.selectedPhoto,
    this.dob,
  });

  final _i91.Key? key;

  final String? userType;

  final String? firstName;

  final String? username;

  final _i93.File? selectedPhoto;

  final String? dob;

  @override
  String toString() {
    return 'ContentCreatorGenderArgs{key: $key, userType: $userType, firstName: $firstName, username: $username, selectedPhoto: $selectedPhoto, dob: $dob}';
  }
}

/// generated route for
/// [_i10.ContentCreatorHomePage]
class ContentCreatorHomePage extends _i90.PageRouteInfo<void> {
  const ContentCreatorHomePage({List<_i90.PageRouteInfo>? children})
      : super(
          ContentCreatorHomePage.name,
          initialChildren: children,
        );

  static const String name = 'ContentCreatorHomePage';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i10.ContentCreatorHomePage();
    },
  );
}

/// generated route for
/// [_i11.ContentCreatorNotification]
class ContentCreatorNotification extends _i90.PageRouteInfo<void> {
  const ContentCreatorNotification({List<_i90.PageRouteInfo>? children})
      : super(
          ContentCreatorNotification.name,
          initialChildren: children,
        );

  static const String name = 'ContentCreatorNotification';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i11.ContentCreatorNotification();
    },
  );
}

/// generated route for
/// [_i12.ContentCreatorProfile]
class ContentCreatorProfile extends _i90.PageRouteInfo<void> {
  const ContentCreatorProfile({List<_i90.PageRouteInfo>? children})
      : super(
          ContentCreatorProfile.name,
          initialChildren: children,
        );

  static const String name = 'ContentCreatorProfile';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i12.ContentCreatorProfile();
    },
  );
}

/// generated route for
/// [_i13.ContentCreatorSearch]
class ContentCreatorSearch extends _i90.PageRouteInfo<void> {
  const ContentCreatorSearch({List<_i90.PageRouteInfo>? children})
      : super(
          ContentCreatorSearch.name,
          initialChildren: children,
        );

  static const String name = 'ContentCreatorSearch';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i13.ContentCreatorSearch();
    },
  );
}

/// generated route for
/// [_i14.ContentCreatorSettings]
class ContentCreatorSettings extends _i90.PageRouteInfo<void> {
  const ContentCreatorSettings({List<_i90.PageRouteInfo>? children})
      : super(
          ContentCreatorSettings.name,
          initialChildren: children,
        );

  static const String name = 'ContentCreatorSettings';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i14.ContentCreatorSettings();
    },
  );
}

/// generated route for
/// [_i15.CreatePasswordScreen]
class CreatePasswordRoute extends _i90.PageRouteInfo<CreatePasswordRouteArgs> {
  CreatePasswordRoute({
    _i91.Key? key,
    String? userType,
    String? email,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          CreatePasswordRoute.name,
          args: CreatePasswordRouteArgs(
            key: key,
            userType: userType,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'CreatePasswordRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreatePasswordRouteArgs>(
          orElse: () => const CreatePasswordRouteArgs());
      return _i15.CreatePasswordScreen(
        key: args.key,
        userType: args.userType,
        email: args.email,
      );
    },
  );
}

class CreatePasswordRouteArgs {
  const CreatePasswordRouteArgs({
    this.key,
    this.userType,
    this.email,
  });

  final _i91.Key? key;

  final String? userType;

  final String? email;

  @override
  String toString() {
    return 'CreatePasswordRouteArgs{key: $key, userType: $userType, email: $email}';
  }
}

/// generated route for
/// [_i16.DateOfBirthContectCr]
class DateOfBirthContectCr
    extends _i90.PageRouteInfo<DateOfBirthContectCrArgs> {
  DateOfBirthContectCr({
    _i94.Key? key,
    String? userType,
    String? firstName,
    String? username,
    _i93.File? selectedPhoto,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          DateOfBirthContectCr.name,
          args: DateOfBirthContectCrArgs(
            key: key,
            userType: userType,
            firstName: firstName,
            username: username,
            selectedPhoto: selectedPhoto,
          ),
          initialChildren: children,
        );

  static const String name = 'DateOfBirthContectCr';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DateOfBirthContectCrArgs>(
          orElse: () => const DateOfBirthContectCrArgs());
      return _i16.DateOfBirthContectCr(
        key: args.key,
        userType: args.userType,
        firstName: args.firstName,
        username: args.username,
        selectedPhoto: args.selectedPhoto,
      );
    },
  );
}

class DateOfBirthContectCrArgs {
  const DateOfBirthContectCrArgs({
    this.key,
    this.userType,
    this.firstName,
    this.username,
    this.selectedPhoto,
  });

  final _i94.Key? key;

  final String? userType;

  final String? firstName;

  final String? username;

  final _i93.File? selectedPhoto;

  @override
  String toString() {
    return 'DateOfBirthContectCrArgs{key: $key, userType: $userType, firstName: $firstName, username: $username, selectedPhoto: $selectedPhoto}';
  }
}

/// generated route for
/// [_i17.DateOfBirthScreen]
class DateOfBirthRoute extends _i90.PageRouteInfo<DateOfBirthRouteArgs> {
  DateOfBirthRoute({
    _i94.Key? key,
    _i93.File? selectedPhoto,
    String? firstName,
    required String userType,
    String? usernname,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          DateOfBirthRoute.name,
          args: DateOfBirthRouteArgs(
            key: key,
            selectedPhoto: selectedPhoto,
            firstName: firstName,
            userType: userType,
            usernname: usernname,
          ),
          initialChildren: children,
        );

  static const String name = 'DateOfBirthRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DateOfBirthRouteArgs>();
      return _i17.DateOfBirthScreen(
        key: args.key,
        selectedPhoto: args.selectedPhoto,
        firstName: args.firstName,
        userType: args.userType,
        usernname: args.usernname,
      );
    },
  );
}

class DateOfBirthRouteArgs {
  const DateOfBirthRouteArgs({
    this.key,
    this.selectedPhoto,
    this.firstName,
    required this.userType,
    this.usernname,
  });

  final _i94.Key? key;

  final _i93.File? selectedPhoto;

  final String? firstName;

  final String userType;

  final String? usernname;

  @override
  String toString() {
    return 'DateOfBirthRouteArgs{key: $key, selectedPhoto: $selectedPhoto, firstName: $firstName, userType: $userType, usernname: $usernname}';
  }
}

/// generated route for
/// [_i18.DatePaymentWebViewPage]
class DatePaymentWebViewPage
    extends _i90.PageRouteInfo<DatePaymentWebViewPageArgs> {
  DatePaymentWebViewPage({
    _i91.Key? key,
    required _i95.DatePaymentData paymentData,
    required String paymentInitiatorType,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          DatePaymentWebViewPage.name,
          args: DatePaymentWebViewPageArgs(
            key: key,
            paymentData: paymentData,
            paymentInitiatorType: paymentInitiatorType,
          ),
          initialChildren: children,
        );

  static const String name = 'DatePaymentWebViewPage';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DatePaymentWebViewPageArgs>();
      return _i18.DatePaymentWebViewPage(
        key: args.key,
        paymentData: args.paymentData,
        paymentInitiatorType: args.paymentInitiatorType,
      );
    },
  );
}

class DatePaymentWebViewPageArgs {
  const DatePaymentWebViewPageArgs({
    this.key,
    required this.paymentData,
    required this.paymentInitiatorType,
  });

  final _i91.Key? key;

  final _i95.DatePaymentData paymentData;

  final String paymentInitiatorType;

  @override
  String toString() {
    return 'DatePaymentWebViewPageArgs{key: $key, paymentData: $paymentData, paymentInitiatorType: $paymentInitiatorType}';
  }
}

/// generated route for
/// [_i19.DatingInterestScreen]
class DatingInterestRoute extends _i90.PageRouteInfo<DatingInterestRouteArgs> {
  DatingInterestRoute({
    _i91.Key? key,
    _i93.File? selectedPhoto,
    String? firstName,
    String? dob,
    String? userType,
    String? username,
    required String gender,
    required String relationshipStatus,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          DatingInterestRoute.name,
          args: DatingInterestRouteArgs(
            key: key,
            selectedPhoto: selectedPhoto,
            firstName: firstName,
            dob: dob,
            userType: userType,
            username: username,
            gender: gender,
            relationshipStatus: relationshipStatus,
          ),
          initialChildren: children,
        );

  static const String name = 'DatingInterestRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DatingInterestRouteArgs>();
      return _i19.DatingInterestScreen(
        key: args.key,
        selectedPhoto: args.selectedPhoto,
        firstName: args.firstName,
        dob: args.dob,
        userType: args.userType,
        username: args.username,
        gender: args.gender,
        relationshipStatus: args.relationshipStatus,
      );
    },
  );
}

class DatingInterestRouteArgs {
  const DatingInterestRouteArgs({
    this.key,
    this.selectedPhoto,
    this.firstName,
    this.dob,
    this.userType,
    this.username,
    required this.gender,
    required this.relationshipStatus,
  });

  final _i91.Key? key;

  final _i93.File? selectedPhoto;

  final String? firstName;

  final String? dob;

  final String? userType;

  final String? username;

  final String gender;

  final String relationshipStatus;

  @override
  String toString() {
    return 'DatingInterestRouteArgs{key: $key, selectedPhoto: $selectedPhoto, firstName: $firstName, dob: $dob, userType: $userType, username: $username, gender: $gender, relationshipStatus: $relationshipStatus}';
  }
}

/// generated route for
/// [_i20.DatingPreferences]
class DatingPreferences extends _i90.PageRouteInfo<void> {
  const DatingPreferences({List<_i90.PageRouteInfo>? children})
      : super(
          DatingPreferences.name,
          initialChildren: children,
        );

  static const String name = 'DatingPreferences';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i20.DatingPreferences();
    },
  );
}

/// generated route for
/// [_i21.EditDrinking]
class EditDrinking extends _i90.PageRouteInfo<void> {
  const EditDrinking({List<_i90.PageRouteInfo>? children})
      : super(
          EditDrinking.name,
          initialChildren: children,
        );

  static const String name = 'EditDrinking';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i21.EditDrinking();
    },
  );
}

/// generated route for
/// [_i22.EditEducation]
class EditEducation extends _i90.PageRouteInfo<void> {
  const EditEducation({List<_i90.PageRouteInfo>? children})
      : super(
          EditEducation.name,
          initialChildren: children,
        );

  static const String name = 'EditEducation';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i22.EditEducation();
    },
  );
}

/// generated route for
/// [_i23.EditExercise]
class EditExercise extends _i90.PageRouteInfo<void> {
  const EditExercise({List<_i90.PageRouteInfo>? children})
      : super(
          EditExercise.name,
          initialChildren: children,
        );

  static const String name = 'EditExercise';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i23.EditExercise();
    },
  );
}

/// generated route for
/// [_i24.EditHeight]
class EditHeight extends _i90.PageRouteInfo<void> {
  const EditHeight({List<_i90.PageRouteInfo>? children})
      : super(
          EditHeight.name,
          initialChildren: children,
        );

  static const String name = 'EditHeight';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i24.EditHeight();
    },
  );
}

/// generated route for
/// [_i25.EditInterest]
class EditInterest extends _i90.PageRouteInfo<void> {
  const EditInterest({List<_i90.PageRouteInfo>? children})
      : super(
          EditInterest.name,
          initialChildren: children,
        );

  static const String name = 'EditInterest';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i25.EditInterest();
    },
  );
}

/// generated route for
/// [_i26.EditNameScreen]
class EditNameRoute extends _i90.PageRouteInfo<EditNameRouteArgs> {
  EditNameRoute({
    _i91.Key? key,
    String? userType,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          EditNameRoute.name,
          args: EditNameRouteArgs(
            key: key,
            userType: userType,
          ),
          initialChildren: children,
        );

  static const String name = 'EditNameRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditNameRouteArgs>(
          orElse: () => const EditNameRouteArgs());
      return _i26.EditNameScreen(
        key: args.key,
        userType: args.userType,
      );
    },
  );
}

class EditNameRouteArgs {
  const EditNameRouteArgs({
    this.key,
    this.userType,
  });

  final _i91.Key? key;

  final String? userType;

  @override
  String toString() {
    return 'EditNameRouteArgs{key: $key, userType: $userType}';
  }
}

/// generated route for
/// [_i27.EditNoOfKids]
class EditNoOfKids extends _i90.PageRouteInfo<void> {
  const EditNoOfKids({List<_i90.PageRouteInfo>? children})
      : super(
          EditNoOfKids.name,
          initialChildren: children,
        );

  static const String name = 'EditNoOfKids';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i27.EditNoOfKids();
    },
  );
}

/// generated route for
/// [_i28.EditPets]
class EditPets extends _i90.PageRouteInfo<void> {
  const EditPets({List<_i90.PageRouteInfo>? children})
      : super(
          EditPets.name,
          initialChildren: children,
        );

  static const String name = 'EditPets';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i28.EditPets();
    },
  );
}

/// generated route for
/// [_i29.EditReligion]
class EditReligion extends _i90.PageRouteInfo<void> {
  const EditReligion({List<_i90.PageRouteInfo>? children})
      : super(
          EditReligion.name,
          initialChildren: children,
        );

  static const String name = 'EditReligion';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i29.EditReligion();
    },
  );
}

/// generated route for
/// [_i30.EditSexualOrientation]
class EditSexualOrientation extends _i90.PageRouteInfo<void> {
  const EditSexualOrientation({List<_i90.PageRouteInfo>? children})
      : super(
          EditSexualOrientation.name,
          initialChildren: children,
        );

  static const String name = 'EditSexualOrientation';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i30.EditSexualOrientation();
    },
  );
}

/// generated route for
/// [_i31.EditSmoking]
class EditSmoking extends _i90.PageRouteInfo<void> {
  const EditSmoking({List<_i90.PageRouteInfo>? children})
      : super(
          EditSmoking.name,
          initialChildren: children,
        );

  static const String name = 'EditSmoking';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i31.EditSmoking();
    },
  );
}

/// generated route for
/// [_i32.EditUserAgeScreen]
class EditUserAgeRoute extends _i90.PageRouteInfo<void> {
  const EditUserAgeRoute({List<_i90.PageRouteInfo>? children})
      : super(
          EditUserAgeRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditUserAgeRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i32.EditUserAgeScreen();
    },
  );
}

/// generated route for
/// [_i33.EditUserGender]
class EditUserGender extends _i90.PageRouteInfo<EditUserGenderArgs> {
  EditUserGender({
    _i91.Key? key,
    _i93.File? selectedPhoto,
    String? firstName,
    String? dob,
    String? userType,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          EditUserGender.name,
          args: EditUserGenderArgs(
            key: key,
            selectedPhoto: selectedPhoto,
            firstName: firstName,
            dob: dob,
            userType: userType,
          ),
          initialChildren: children,
        );

  static const String name = 'EditUserGender';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditUserGenderArgs>(
          orElse: () => const EditUserGenderArgs());
      return _i33.EditUserGender(
        key: args.key,
        selectedPhoto: args.selectedPhoto,
        firstName: args.firstName,
        dob: args.dob,
        userType: args.userType,
      );
    },
  );
}

class EditUserGenderArgs {
  const EditUserGenderArgs({
    this.key,
    this.selectedPhoto,
    this.firstName,
    this.dob,
    this.userType,
  });

  final _i91.Key? key;

  final _i93.File? selectedPhoto;

  final String? firstName;

  final String? dob;

  final String? userType;

  @override
  String toString() {
    return 'EditUserGenderArgs{key: $key, selectedPhoto: $selectedPhoto, firstName: $firstName, dob: $dob, userType: $userType}';
  }
}

/// generated route for
/// [_i34.EditUserName]
class EditUserName extends _i90.PageRouteInfo<void> {
  const EditUserName({List<_i90.PageRouteInfo>? children})
      : super(
          EditUserName.name,
          initialChildren: children,
        );

  static const String name = 'EditUserName';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i34.EditUserName();
    },
  );
}

/// generated route for
/// [_i35.EditValue]
class EditValue extends _i90.PageRouteInfo<void> {
  const EditValue({List<_i90.PageRouteInfo>? children})
      : super(
          EditValue.name,
          initialChildren: children,
        );

  static const String name = 'EditValue';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i35.EditValue();
    },
  );
}

/// generated route for
/// [_i36.EditWeight]
class EditWeight extends _i90.PageRouteInfo<void> {
  const EditWeight({List<_i90.PageRouteInfo>? children})
      : super(
          EditWeight.name,
          initialChildren: children,
        );

  static const String name = 'EditWeight';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i36.EditWeight();
    },
  );
}

/// generated route for
/// [_i37.EditWork]
class EditWork extends _i90.PageRouteInfo<void> {
  const EditWork({List<_i90.PageRouteInfo>? children})
      : super(
          EditWork.name,
          initialChildren: children,
        );

  static const String name = 'EditWork';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i37.EditWork();
    },
  );
}

/// generated route for
/// [_i38.EmailConfirmationScreen]
class EmailConfirmationRoute
    extends _i90.PageRouteInfo<EmailConfirmationRouteArgs> {
  EmailConfirmationRoute({
    _i91.Key? key,
    String? email,
    String? userType,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          EmailConfirmationRoute.name,
          args: EmailConfirmationRouteArgs(
            key: key,
            email: email,
            userType: userType,
          ),
          initialChildren: children,
        );

  static const String name = 'EmailConfirmationRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmailConfirmationRouteArgs>(
          orElse: () => const EmailConfirmationRouteArgs());
      return _i38.EmailConfirmationScreen(
        key: args.key,
        email: args.email,
        userType: args.userType,
      );
    },
  );
}

class EmailConfirmationRouteArgs {
  const EmailConfirmationRouteArgs({
    this.key,
    this.email,
    this.userType,
  });

  final _i91.Key? key;

  final String? email;

  final String? userType;

  @override
  String toString() {
    return 'EmailConfirmationRouteArgs{key: $key, email: $email, userType: $userType}';
  }
}

/// generated route for
/// [_i39.FeedScreen]
class FeedRoute extends _i90.PageRouteInfo<void> {
  const FeedRoute({List<_i90.PageRouteInfo>? children})
      : super(
          FeedRoute.name,
          initialChildren: children,
        );

  static const String name = 'FeedRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i39.FeedScreen();
    },
  );
}

/// generated route for
/// [_i40.FileUploadScreen]
class FileUploadRoute extends _i90.PageRouteInfo<FileUploadRouteArgs> {
  FileUploadRoute({
    _i91.Key? key,
    required _i93.File selectedPhoto,
    String? userId,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          FileUploadRoute.name,
          args: FileUploadRouteArgs(
            key: key,
            selectedPhoto: selectedPhoto,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'FileUploadRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FileUploadRouteArgs>();
      return _i40.FileUploadScreen(
        key: args.key,
        selectedPhoto: args.selectedPhoto,
        userId: args.userId,
      );
    },
  );
}

class FileUploadRouteArgs {
  const FileUploadRouteArgs({
    this.key,
    required this.selectedPhoto,
    this.userId,
  });

  final _i91.Key? key;

  final _i93.File selectedPhoto;

  final String? userId;

  @override
  String toString() {
    return 'FileUploadRouteArgs{key: $key, selectedPhoto: $selectedPhoto, userId: $userId}';
  }
}

/// generated route for
/// [_i41.ForgetPassword]
class ForgetPassword extends _i90.PageRouteInfo<void> {
  const ForgetPassword({List<_i90.PageRouteInfo>? children})
      : super(
          ForgetPassword.name,
          initialChildren: children,
        );

  static const String name = 'ForgetPassword';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i41.ForgetPassword();
    },
  );
}

/// generated route for
/// [_i42.ForgotPasswordOtp]
class ForgotPasswordOtp extends _i90.PageRouteInfo<ForgotPasswordOtpArgs> {
  ForgotPasswordOtp({
    _i91.Key? key,
    String? email,
    String? userType,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          ForgotPasswordOtp.name,
          args: ForgotPasswordOtpArgs(
            key: key,
            email: email,
            userType: userType,
          ),
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordOtp';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotPasswordOtpArgs>(
          orElse: () => const ForgotPasswordOtpArgs());
      return _i42.ForgotPasswordOtp(
        key: args.key,
        email: args.email,
        userType: args.userType,
      );
    },
  );
}

class ForgotPasswordOtpArgs {
  const ForgotPasswordOtpArgs({
    this.key,
    this.email,
    this.userType,
  });

  final _i91.Key? key;

  final String? email;

  final String? userType;

  @override
  String toString() {
    return 'ForgotPasswordOtpArgs{key: $key, email: $email, userType: $userType}';
  }
}

/// generated route for
/// [_i43.GenderScreen]
class GenderRoute extends _i90.PageRouteInfo<GenderRouteArgs> {
  GenderRoute({
    _i91.Key? key,
    _i93.File? selectedPhoto,
    String? firstName,
    String? dob,
    String? userType,
    String? username,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          GenderRoute.name,
          args: GenderRouteArgs(
            key: key,
            selectedPhoto: selectedPhoto,
            firstName: firstName,
            dob: dob,
            userType: userType,
            username: username,
          ),
          initialChildren: children,
        );

  static const String name = 'GenderRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<GenderRouteArgs>(orElse: () => const GenderRouteArgs());
      return _i43.GenderScreen(
        key: args.key,
        selectedPhoto: args.selectedPhoto,
        firstName: args.firstName,
        dob: args.dob,
        userType: args.userType,
        username: args.username,
      );
    },
  );
}

class GenderRouteArgs {
  const GenderRouteArgs({
    this.key,
    this.selectedPhoto,
    this.firstName,
    this.dob,
    this.userType,
    this.username,
  });

  final _i91.Key? key;

  final _i93.File? selectedPhoto;

  final String? firstName;

  final String? dob;

  final String? userType;

  final String? username;

  @override
  String toString() {
    return 'GenderRouteArgs{key: $key, selectedPhoto: $selectedPhoto, firstName: $firstName, dob: $dob, userType: $userType, username: $username}';
  }
}

/// generated route for
/// [_i44.GroupChatScreen]
class GroupChatRoute extends _i90.PageRouteInfo<GroupChatRouteArgs> {
  GroupChatRoute({
    _i91.Key? key,
    required _i96.GroupModel groupModel,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          GroupChatRoute.name,
          args: GroupChatRouteArgs(
            key: key,
            groupModel: groupModel,
          ),
          initialChildren: children,
        );

  static const String name = 'GroupChatRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GroupChatRouteArgs>();
      return _i44.GroupChatScreen(
        key: args.key,
        groupModel: args.groupModel,
      );
    },
  );
}

class GroupChatRouteArgs {
  const GroupChatRouteArgs({
    this.key,
    required this.groupModel,
  });

  final _i91.Key? key;

  final _i96.GroupModel groupModel;

  @override
  String toString() {
    return 'GroupChatRouteArgs{key: $key, groupModel: $groupModel}';
  }
}

/// generated route for
/// [_i45.GroupScreen]
class GroupRoute extends _i90.PageRouteInfo<void> {
  const GroupRoute({List<_i90.PageRouteInfo>? children})
      : super(
          GroupRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i45.GroupScreen();
    },
  );
}

/// generated route for
/// [_i46.HomeScreen]
class HomeRoute extends _i90.PageRouteInfo<void> {
  const HomeRoute({List<_i90.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i46.HomeScreen();
    },
  );
}

/// generated route for
/// [_i47.LocationAdd]
class LocationAdd extends _i90.PageRouteInfo<void> {
  const LocationAdd({List<_i90.PageRouteInfo>? children})
      : super(
          LocationAdd.name,
          initialChildren: children,
        );

  static const String name = 'LocationAdd';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i47.LocationAdd();
    },
  );
}

/// generated route for
/// [_i48.LoginScreen]
class LoginRoute extends _i90.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i91.Key? key,
    String? userType,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            userType: userType,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<LoginRouteArgs>(orElse: () => const LoginRouteArgs());
      return _i48.LoginScreen(
        key: args.key,
        userType: args.userType,
      );
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    this.userType,
  });

  final _i91.Key? key;

  final String? userType;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, userType: $userType}';
  }
}

/// generated route for
/// [_i49.MatchedScreen]
class MatchedRoute extends _i90.PageRouteInfo<MatchedRouteArgs> {
  MatchedRoute({
    _i91.Key? key,
    required _i92.UserModel user1,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          MatchedRoute.name,
          args: MatchedRouteArgs(
            key: key,
            user1: user1,
          ),
          initialChildren: children,
        );

  static const String name = 'MatchedRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MatchedRouteArgs>();
      return _i49.MatchedScreen(
        key: args.key,
        user1: args.user1,
      );
    },
  );
}

class MatchedRouteArgs {
  const MatchedRouteArgs({
    this.key,
    required this.user1,
  });

  final _i91.Key? key;

  final _i92.UserModel user1;

  @override
  String toString() {
    return 'MatchedRouteArgs{key: $key, user1: $user1}';
  }
}

/// generated route for
/// [_i50.NewsScreen]
class NewsRoute extends _i90.PageRouteInfo<void> {
  const NewsRoute({List<_i90.PageRouteInfo>? children})
      : super(
          NewsRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewsRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i50.NewsScreen();
    },
  );
}

/// generated route for
/// [_i51.NotificationScreen]
class NotificationRoute extends _i90.PageRouteInfo<NotificationRouteArgs> {
  NotificationRoute({
    _i91.Key? key,
    required _i97.RemoteMessage message,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          NotificationRoute.name,
          args: NotificationRouteArgs(
            key: key,
            message: message,
          ),
          initialChildren: children,
        );

  static const String name = 'NotificationRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NotificationRouteArgs>();
      return _i51.NotificationScreen(
        key: args.key,
        message: args.message,
      );
    },
  );
}

class NotificationRouteArgs {
  const NotificationRouteArgs({
    this.key,
    required this.message,
  });

  final _i91.Key? key;

  final _i97.RemoteMessage message;

  @override
  String toString() {
    return 'NotificationRouteArgs{key: $key, message: $message}';
  }
}

/// generated route for
/// [_i52.NotificationSettingsScreen]
class NotificationSettingsRoute extends _i90.PageRouteInfo<void> {
  const NotificationSettingsRoute({List<_i90.PageRouteInfo>? children})
      : super(
          NotificationSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationSettingsRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i52.NotificationSettingsScreen();
    },
  );
}

/// generated route for
/// [_i53.OnboardingIndex]
class OnboardingIndex extends _i90.PageRouteInfo<void> {
  const OnboardingIndex({List<_i90.PageRouteInfo>? children})
      : super(
          OnboardingIndex.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingIndex';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i53.OnboardingIndex();
    },
  );
}

/// generated route for
/// [_i54.OnboardingScreen]
class OnboardingRoute extends _i90.PageRouteInfo<void> {
  const OnboardingRoute({List<_i90.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i54.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i55.OnboardingScreen1]
class OnboardingRoute1 extends _i90.PageRouteInfo<void> {
  const OnboardingRoute1({List<_i90.PageRouteInfo>? children})
      : super(
          OnboardingRoute1.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute1';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i55.OnboardingScreen1();
    },
  );
}

/// generated route for
/// [_i56.PasswordManager]
class PasswordManager extends _i90.PageRouteInfo<void> {
  const PasswordManager({List<_i90.PageRouteInfo>? children})
      : super(
          PasswordManager.name,
          initialChildren: children,
        );

  static const String name = 'PasswordManager';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i56.PasswordManager();
    },
  );
}

/// generated route for
/// [_i57.PasswordResetSuccess]
class PasswordResetSuccess
    extends _i90.PageRouteInfo<PasswordResetSuccessArgs> {
  PasswordResetSuccess({
    _i91.Key? key,
    required String userType,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          PasswordResetSuccess.name,
          args: PasswordResetSuccessArgs(
            key: key,
            userType: userType,
          ),
          initialChildren: children,
        );

  static const String name = 'PasswordResetSuccess';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PasswordResetSuccessArgs>();
      return _i57.PasswordResetSuccess(
        key: args.key,
        userType: args.userType,
      );
    },
  );
}

class PasswordResetSuccessArgs {
  const PasswordResetSuccessArgs({
    this.key,
    required this.userType,
  });

  final _i91.Key? key;

  final String userType;

  @override
  String toString() {
    return 'PasswordResetSuccessArgs{key: $key, userType: $userType}';
  }
}

/// generated route for
/// [_i58.PasswordUpdateSuccess]
class PasswordUpdateSuccess extends _i90.PageRouteInfo<void> {
  const PasswordUpdateSuccess({List<_i90.PageRouteInfo>? children})
      : super(
          PasswordUpdateSuccess.name,
          initialChildren: children,
        );

  static const String name = 'PasswordUpdateSuccess';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i58.PasswordUpdateSuccess();
    },
  );
}

/// generated route for
/// [_i59.PayForDateScreen]
class PayForDateRoute extends _i90.PageRouteInfo<PayForDateRouteArgs> {
  PayForDateRoute({
    _i91.Key? key,
    List<num>? locations,
    String? budget,
    List<_i98.DateModel>? dates,
    String? paymentMethod,
    num? dateId,
    String? type,
    num? dateUserId,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          PayForDateRoute.name,
          args: PayForDateRouteArgs(
            key: key,
            locations: locations,
            budget: budget,
            dates: dates,
            paymentMethod: paymentMethod,
            dateId: dateId,
            type: type,
            dateUserId: dateUserId,
          ),
          initialChildren: children,
        );

  static const String name = 'PayForDateRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PayForDateRouteArgs>(
          orElse: () => const PayForDateRouteArgs());
      return _i59.PayForDateScreen(
        key: args.key,
        locations: args.locations,
        budget: args.budget,
        dates: args.dates,
        paymentMethod: args.paymentMethod,
        dateId: args.dateId,
        type: args.type,
        dateUserId: args.dateUserId,
      );
    },
  );
}

class PayForDateRouteArgs {
  const PayForDateRouteArgs({
    this.key,
    this.locations,
    this.budget,
    this.dates,
    this.paymentMethod,
    this.dateId,
    this.type,
    this.dateUserId,
  });

  final _i91.Key? key;

  final List<num>? locations;

  final String? budget;

  final List<_i98.DateModel>? dates;

  final String? paymentMethod;

  final num? dateId;

  final String? type;

  final num? dateUserId;

  @override
  String toString() {
    return 'PayForDateRouteArgs{key: $key, locations: $locations, budget: $budget, dates: $dates, paymentMethod: $paymentMethod, dateId: $dateId, type: $type, dateUserId: $dateUserId}';
  }
}

/// generated route for
/// [_i60.PaymentSuccessPage]
class PaymentSuccessPage extends _i90.PageRouteInfo<PaymentSuccessPageArgs> {
  PaymentSuccessPage({
    _i91.Key? key,
    String? transactionReference,
    String? amount,
    String? recipientName,
    required String paymentInitiatorType,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          PaymentSuccessPage.name,
          args: PaymentSuccessPageArgs(
            key: key,
            transactionReference: transactionReference,
            amount: amount,
            recipientName: recipientName,
            paymentInitiatorType: paymentInitiatorType,
          ),
          initialChildren: children,
        );

  static const String name = 'PaymentSuccessPage';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PaymentSuccessPageArgs>();
      return _i60.PaymentSuccessPage(
        key: args.key,
        transactionReference: args.transactionReference,
        amount: args.amount,
        recipientName: args.recipientName,
        paymentInitiatorType: args.paymentInitiatorType,
      );
    },
  );
}

class PaymentSuccessPageArgs {
  const PaymentSuccessPageArgs({
    this.key,
    this.transactionReference,
    this.amount,
    this.recipientName,
    required this.paymentInitiatorType,
  });

  final _i91.Key? key;

  final String? transactionReference;

  final String? amount;

  final String? recipientName;

  final String paymentInitiatorType;

  @override
  String toString() {
    return 'PaymentSuccessPageArgs{key: $key, transactionReference: $transactionReference, amount: $amount, recipientName: $recipientName, paymentInitiatorType: $paymentInitiatorType}';
  }
}

/// generated route for
/// [_i61.PersonalSettings]
class PersonalSettings extends _i90.PageRouteInfo<void> {
  const PersonalSettings({List<_i90.PageRouteInfo>? children})
      : super(
          PersonalSettings.name,
          initialChildren: children,
        );

  static const String name = 'PersonalSettings';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i61.PersonalSettings();
    },
  );
}

/// generated route for
/// [_i62.PhotosSelectionScreen]
class PhotosSelectionRoute
    extends _i90.PageRouteInfo<PhotosSelectionRouteArgs> {
  PhotosSelectionRoute({
    _i91.Key? key,
    String? userName,
    String? userType,
    String? fullName,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          PhotosSelectionRoute.name,
          args: PhotosSelectionRouteArgs(
            key: key,
            userName: userName,
            userType: userType,
            fullName: fullName,
          ),
          initialChildren: children,
        );

  static const String name = 'PhotosSelectionRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PhotosSelectionRouteArgs>(
          orElse: () => const PhotosSelectionRouteArgs());
      return _i62.PhotosSelectionScreen(
        key: args.key,
        userName: args.userName,
        userType: args.userType,
        fullName: args.fullName,
      );
    },
  );
}

class PhotosSelectionRouteArgs {
  const PhotosSelectionRouteArgs({
    this.key,
    this.userName,
    this.userType,
    this.fullName,
  });

  final _i91.Key? key;

  final String? userName;

  final String? userType;

  final String? fullName;

  @override
  String toString() {
    return 'PhotosSelectionRouteArgs{key: $key, userName: $userName, userType: $userType, fullName: $fullName}';
  }
}

/// generated route for
/// [_i63.PlanADateScreen]
class PlanADateRoute extends _i90.PageRouteInfo<PlanADateRouteArgs> {
  PlanADateRoute({
    _i91.Key? key,
    num? dateUserId,
    num? dateId,
    String? type,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          PlanADateRoute.name,
          args: PlanADateRouteArgs(
            key: key,
            dateUserId: dateUserId,
            dateId: dateId,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'PlanADateRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PlanADateRouteArgs>(
          orElse: () => const PlanADateRouteArgs());
      return _i63.PlanADateScreen(
        key: args.key,
        dateUserId: args.dateUserId,
        dateId: args.dateId,
        type: args.type,
      );
    },
  );
}

class PlanADateRouteArgs {
  const PlanADateRouteArgs({
    this.key,
    this.dateUserId,
    this.dateId,
    this.type,
  });

  final _i91.Key? key;

  final num? dateUserId;

  final num? dateId;

  final String? type;

  @override
  String toString() {
    return 'PlanADateRouteArgs{key: $key, dateUserId: $dateUserId, dateId: $dateId, type: $type}';
  }
}

/// generated route for
/// [_i64.ProfilePhotosScreen]
class ProfilePhotosRoute extends _i90.PageRouteInfo<ProfilePhotosRouteArgs> {
  ProfilePhotosRoute({
    _i91.Key? key,
    _i93.File? selectedPhoto,
    String? userName,
    String? userType,
    String? fullname,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          ProfilePhotosRoute.name,
          args: ProfilePhotosRouteArgs(
            key: key,
            selectedPhoto: selectedPhoto,
            userName: userName,
            userType: userType,
            fullname: fullname,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfilePhotosRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfilePhotosRouteArgs>(
          orElse: () => const ProfilePhotosRouteArgs());
      return _i64.ProfilePhotosScreen(
        key: args.key,
        selectedPhoto: args.selectedPhoto,
        userName: args.userName,
        userType: args.userType,
        fullname: args.fullname,
      );
    },
  );
}

class ProfilePhotosRouteArgs {
  const ProfilePhotosRouteArgs({
    this.key,
    this.selectedPhoto,
    this.userName,
    this.userType,
    this.fullname,
  });

  final _i91.Key? key;

  final _i93.File? selectedPhoto;

  final String? userName;

  final String? userType;

  final String? fullname;

  @override
  String toString() {
    return 'ProfilePhotosRouteArgs{key: $key, selectedPhoto: $selectedPhoto, userName: $userName, userType: $userType, fullname: $fullname}';
  }
}

/// generated route for
/// [_i65.ProfileUpdateSuccessScreen]
class ProfileUpdateSuccessRoute
    extends _i90.PageRouteInfo<ProfileUpdateSuccessRouteArgs> {
  ProfileUpdateSuccessRoute({
    _i91.Key? key,
    String? userType,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          ProfileUpdateSuccessRoute.name,
          args: ProfileUpdateSuccessRouteArgs(
            key: key,
            userType: userType,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileUpdateSuccessRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileUpdateSuccessRouteArgs>(
          orElse: () => const ProfileUpdateSuccessRouteArgs());
      return _i65.ProfileUpdateSuccessScreen(
        key: args.key,
        userType: args.userType,
      );
    },
  );
}

class ProfileUpdateSuccessRouteArgs {
  const ProfileUpdateSuccessRouteArgs({
    this.key,
    this.userType,
  });

  final _i91.Key? key;

  final String? userType;

  @override
  String toString() {
    return 'ProfileUpdateSuccessRouteArgs{key: $key, userType: $userType}';
  }
}

/// generated route for
/// [_i66.RegisterScreen]
class RegisterRoute extends _i90.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    _i91.Key? key,
    required String userType,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          RegisterRoute.name,
          args: RegisterRouteArgs(
            key: key,
            userType: userType,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterRouteArgs>();
      return _i66.RegisterScreen(
        key: args.key,
        userType: args.userType,
      );
    },
  );
}

class RegisterRouteArgs {
  const RegisterRouteArgs({
    this.key,
    required this.userType,
  });

  final _i91.Key? key;

  final String userType;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key, userType: $userType}';
  }
}

/// generated route for
/// [_i67.RelationShipStatusScreen]
class RelationShipStatusRoute
    extends _i90.PageRouteInfo<RelationShipStatusRouteArgs> {
  RelationShipStatusRoute({
    _i91.Key? key,
    _i93.File? selectedPhoto,
    String? firstName,
    String? userType,
    String? usernname,
    String? dob,
    required String gender,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          RelationShipStatusRoute.name,
          args: RelationShipStatusRouteArgs(
            key: key,
            selectedPhoto: selectedPhoto,
            firstName: firstName,
            userType: userType,
            usernname: usernname,
            dob: dob,
            gender: gender,
          ),
          initialChildren: children,
        );

  static const String name = 'RelationShipStatusRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RelationShipStatusRouteArgs>();
      return _i67.RelationShipStatusScreen(
        key: args.key,
        selectedPhoto: args.selectedPhoto,
        firstName: args.firstName,
        userType: args.userType,
        usernname: args.usernname,
        dob: args.dob,
        gender: args.gender,
      );
    },
  );
}

class RelationShipStatusRouteArgs {
  const RelationShipStatusRouteArgs({
    this.key,
    this.selectedPhoto,
    this.firstName,
    this.userType,
    this.usernname,
    this.dob,
    required this.gender,
  });

  final _i91.Key? key;

  final _i93.File? selectedPhoto;

  final String? firstName;

  final String? userType;

  final String? usernname;

  final String? dob;

  final String gender;

  @override
  String toString() {
    return 'RelationShipStatusRouteArgs{key: $key, selectedPhoto: $selectedPhoto, firstName: $firstName, userType: $userType, usernname: $usernname, dob: $dob, gender: $gender}';
  }
}

/// generated route for
/// [_i68.ResetPassword]
class ResetPassword extends _i90.PageRouteInfo<ResetPasswordArgs> {
  ResetPassword({
    _i91.Key? key,
    String? userType,
    String? email,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          ResetPassword.name,
          args: ResetPasswordArgs(
            key: key,
            userType: userType,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'ResetPassword';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordArgs>(
          orElse: () => const ResetPasswordArgs());
      return _i68.ResetPassword(
        key: args.key,
        userType: args.userType,
        email: args.email,
      );
    },
  );
}

class ResetPasswordArgs {
  const ResetPasswordArgs({
    this.key,
    this.userType,
    this.email,
  });

  final _i91.Key? key;

  final String? userType;

  final String? email;

  @override
  String toString() {
    return 'ResetPasswordArgs{key: $key, userType: $userType, email: $email}';
  }
}

/// generated route for
/// [_i69.SecuritySettingsScreen]
class SecuritySettingsRoute extends _i90.PageRouteInfo<void> {
  const SecuritySettingsRoute({List<_i90.PageRouteInfo>? children})
      : super(
          SecuritySettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SecuritySettingsRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i69.SecuritySettingsScreen();
    },
  );
}

/// generated route for
/// [_i70.SelectedProfileScreen]
class SelectedProfileRoute
    extends _i90.PageRouteInfo<SelectedProfileRouteArgs> {
  SelectedProfileRoute({
    _i91.Key? key,
    _i92.UserModel? profile,
    required _i91.VoidCallback selectedProfileCallBack,
    required int? currentIndex,
    required _i91.ValueNotifier<_i99.Swipe> swipeNotifier,
    required _i100.HomeViewModel viewModel,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          SelectedProfileRoute.name,
          args: SelectedProfileRouteArgs(
            key: key,
            profile: profile,
            selectedProfileCallBack: selectedProfileCallBack,
            currentIndex: currentIndex,
            swipeNotifier: swipeNotifier,
            viewModel: viewModel,
          ),
          initialChildren: children,
        );

  static const String name = 'SelectedProfileRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SelectedProfileRouteArgs>();
      return _i70.SelectedProfileScreen(
        key: args.key,
        profile: args.profile,
        selectedProfileCallBack: args.selectedProfileCallBack,
        currentIndex: args.currentIndex,
        swipeNotifier: args.swipeNotifier,
        viewModel: args.viewModel,
      );
    },
  );
}

class SelectedProfileRouteArgs {
  const SelectedProfileRouteArgs({
    this.key,
    this.profile,
    required this.selectedProfileCallBack,
    required this.currentIndex,
    required this.swipeNotifier,
    required this.viewModel,
  });

  final _i91.Key? key;

  final _i92.UserModel? profile;

  final _i91.VoidCallback selectedProfileCallBack;

  final int? currentIndex;

  final _i91.ValueNotifier<_i99.Swipe> swipeNotifier;

  final _i100.HomeViewModel viewModel;

  @override
  String toString() {
    return 'SelectedProfileRouteArgs{key: $key, profile: $profile, selectedProfileCallBack: $selectedProfileCallBack, currentIndex: $currentIndex, swipeNotifier: $swipeNotifier, viewModel: $viewModel}';
  }
}

/// generated route for
/// [_i71.SendFloweSuccess]
class SendFloweSuccess extends _i90.PageRouteInfo<SendFloweSuccessArgs> {
  SendFloweSuccess({
    _i91.Key? key,
    required _i92.UserModel user,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          SendFloweSuccess.name,
          args: SendFloweSuccessArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'SendFloweSuccess';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SendFloweSuccessArgs>();
      return _i71.SendFloweSuccess(
        key: args.key,
        user: args.user,
      );
    },
  );
}

class SendFloweSuccessArgs {
  const SendFloweSuccessArgs({
    this.key,
    required this.user,
  });

  final _i91.Key? key;

  final _i92.UserModel user;

  @override
  String toString() {
    return 'SendFloweSuccessArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i72.SendFlowerToUser]
class SendFlowerToUser extends _i90.PageRouteInfo<SendFlowerToUserArgs> {
  SendFlowerToUser({
    _i91.Key? key,
    required _i92.UserModel user,
    required _i101.UserGift gift,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          SendFlowerToUser.name,
          args: SendFlowerToUserArgs(
            key: key,
            user: user,
            gift: gift,
          ),
          initialChildren: children,
        );

  static const String name = 'SendFlowerToUser';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SendFlowerToUserArgs>();
      return _i72.SendFlowerToUser(
        key: args.key,
        user: args.user,
        gift: args.gift,
      );
    },
  );
}

class SendFlowerToUserArgs {
  const SendFlowerToUserArgs({
    this.key,
    required this.user,
    required this.gift,
  });

  final _i91.Key? key;

  final _i92.UserModel user;

  final _i101.UserGift gift;

  @override
  String toString() {
    return 'SendFlowerToUserArgs{key: $key, user: $user, gift: $gift}';
  }
}

/// generated route for
/// [_i73.SettingsScreen]
class SettingsRoute extends _i90.PageRouteInfo<void> {
  const SettingsRoute({List<_i90.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i73.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i74.SplashScreen]
class SplashRoute extends _i90.PageRouteInfo<void> {
  const SplashRoute({List<_i90.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i74.SplashScreen();
    },
  );
}

/// generated route for
/// [_i75.SupscriptionHome]
class SupscriptionHome extends _i90.PageRouteInfo<void> {
  const SupscriptionHome({List<_i90.PageRouteInfo>? children})
      : super(
          SupscriptionHome.name,
          initialChildren: children,
        );

  static const String name = 'SupscriptionHome';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i75.SupscriptionHome();
    },
  );
}

/// generated route for
/// [_i76.TagUsers]
class TagUsers extends _i90.PageRouteInfo<void> {
  const TagUsers({List<_i90.PageRouteInfo>? children})
      : super(
          TagUsers.name,
          initialChildren: children,
        );

  static const String name = 'TagUsers';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i76.TagUsers();
    },
  );
}

/// generated route for
/// [_i77.UploadPostAddText]
class UploadPostAddText extends _i90.PageRouteInfo<UploadPostAddTextArgs> {
  UploadPostAddText({
    _i91.Key? key,
    required _i93.File selectedPhoto,
    required String type,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          UploadPostAddText.name,
          args: UploadPostAddTextArgs(
            key: key,
            selectedPhoto: selectedPhoto,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'UploadPostAddText';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UploadPostAddTextArgs>();
      return _i77.UploadPostAddText(
        key: args.key,
        selectedPhoto: args.selectedPhoto,
        type: args.type,
      );
    },
  );
}

class UploadPostAddTextArgs {
  const UploadPostAddTextArgs({
    this.key,
    required this.selectedPhoto,
    required this.type,
  });

  final _i91.Key? key;

  final _i93.File selectedPhoto;

  final String type;

  @override
  String toString() {
    return 'UploadPostAddTextArgs{key: $key, selectedPhoto: $selectedPhoto, type: $type}';
  }
}

/// generated route for
/// [_i78.UploadPostScreen]
class UploadPostRoute extends _i90.PageRouteInfo<UploadPostRouteArgs> {
  UploadPostRoute({
    _i91.Key? key,
    required _i93.File file,
    required String type,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          UploadPostRoute.name,
          args: UploadPostRouteArgs(
            key: key,
            file: file,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'UploadPostRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UploadPostRouteArgs>();
      return _i78.UploadPostScreen(
        key: args.key,
        file: args.file,
        type: args.type,
      );
    },
  );
}

class UploadPostRouteArgs {
  const UploadPostRouteArgs({
    this.key,
    required this.file,
    required this.type,
  });

  final _i91.Key? key;

  final _i93.File file;

  final String type;

  @override
  String toString() {
    return 'UploadPostRouteArgs{key: $key, file: $file, type: $type}';
  }
}

/// generated route for
/// [_i79.UploadSuccess]
class UploadSuccess extends _i90.PageRouteInfo<void> {
  const UploadSuccess({List<_i90.PageRouteInfo>? children})
      : super(
          UploadSuccess.name,
          initialChildren: children,
        );

  static const String name = 'UploadSuccess';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i79.UploadSuccess();
    },
  );
}

/// generated route for
/// [_i80.UserAddressInfo]
class UserAddressInfo extends _i90.PageRouteInfo<UserAddressInfoArgs> {
  UserAddressInfo({
    _i91.Key? key,
    _i93.File? selectedPhoto,
    String? firstName,
    String? dob,
    required String gender,
    required String relationshipStatus,
    String? preference,
    String? userType,
    String? username,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          UserAddressInfo.name,
          args: UserAddressInfoArgs(
            key: key,
            selectedPhoto: selectedPhoto,
            firstName: firstName,
            dob: dob,
            gender: gender,
            relationshipStatus: relationshipStatus,
            preference: preference,
            userType: userType,
            username: username,
          ),
          initialChildren: children,
        );

  static const String name = 'UserAddressInfo';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserAddressInfoArgs>();
      return _i80.UserAddressInfo(
        key: args.key,
        selectedPhoto: args.selectedPhoto,
        firstName: args.firstName,
        dob: args.dob,
        gender: args.gender,
        relationshipStatus: args.relationshipStatus,
        preference: args.preference,
        userType: args.userType,
        username: args.username,
      );
    },
  );
}

class UserAddressInfoArgs {
  const UserAddressInfoArgs({
    this.key,
    this.selectedPhoto,
    this.firstName,
    this.dob,
    required this.gender,
    required this.relationshipStatus,
    this.preference,
    this.userType,
    this.username,
  });

  final _i91.Key? key;

  final _i93.File? selectedPhoto;

  final String? firstName;

  final String? dob;

  final String gender;

  final String relationshipStatus;

  final String? preference;

  final String? userType;

  final String? username;

  @override
  String toString() {
    return 'UserAddressInfoArgs{key: $key, selectedPhoto: $selectedPhoto, firstName: $firstName, dob: $dob, gender: $gender, relationshipStatus: $relationshipStatus, preference: $preference, userType: $userType, username: $username}';
  }
}

/// generated route for
/// [_i81.UserNamePage]
class UserNamePage extends _i90.PageRouteInfo<UserNamePageArgs> {
  UserNamePage({
    _i91.Key? key,
    String? userType,
    String? firstName,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          UserNamePage.name,
          args: UserNamePageArgs(
            key: key,
            userType: userType,
            firstName: firstName,
          ),
          initialChildren: children,
        );

  static const String name = 'UserNamePage';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<UserNamePageArgs>(orElse: () => const UserNamePageArgs());
      return _i81.UserNamePage(
        key: args.key,
        userType: args.userType,
        firstName: args.firstName,
      );
    },
  );
}

class UserNamePageArgs {
  const UserNamePageArgs({
    this.key,
    this.userType,
    this.firstName,
  });

  final _i91.Key? key;

  final String? userType;

  final String? firstName;

  @override
  String toString() {
    return 'UserNamePageArgs{key: $key, userType: $userType, firstName: $firstName}';
  }
}

/// generated route for
/// [_i82.UserNameUserPage]
class UserNameUserPage extends _i90.PageRouteInfo<UserNameUserPageArgs> {
  UserNameUserPage({
    _i91.Key? key,
    String? userType,
    String? firstName,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          UserNameUserPage.name,
          args: UserNameUserPageArgs(
            key: key,
            userType: userType,
            firstName: firstName,
          ),
          initialChildren: children,
        );

  static const String name = 'UserNameUserPage';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserNameUserPageArgs>(
          orElse: () => const UserNameUserPageArgs());
      return _i82.UserNameUserPage(
        key: args.key,
        userType: args.userType,
        firstName: args.firstName,
      );
    },
  );
}

class UserNameUserPageArgs {
  const UserNameUserPageArgs({
    this.key,
    this.userType,
    this.firstName,
  });

  final _i91.Key? key;

  final String? userType;

  final String? firstName;

  @override
  String toString() {
    return 'UserNameUserPageArgs{key: $key, userType: $userType, firstName: $firstName}';
  }
}

/// generated route for
/// [_i83.UserProfileDetails]
class UserProfileDetails extends _i90.PageRouteInfo<void> {
  const UserProfileDetails({List<_i90.PageRouteInfo>? children})
      : super(
          UserProfileDetails.name,
          initialChildren: children,
        );

  static const String name = 'UserProfileDetails';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i83.UserProfileDetails();
    },
  );
}

/// generated route for
/// [_i84.UserProfileScreen]
class UserProfileRoute extends _i90.PageRouteInfo<void> {
  const UserProfileRoute({List<_i90.PageRouteInfo>? children})
      : super(
          UserProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i84.UserProfileScreen();
    },
  );
}

/// generated route for
/// [_i85.UserTypeSelectionScreen]
class UserTypeSelectionRoute extends _i90.PageRouteInfo<void> {
  const UserTypeSelectionRoute({List<_i90.PageRouteInfo>? children})
      : super(
          UserTypeSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserTypeSelectionRoute';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i85.UserTypeSelectionScreen();
    },
  );
}

/// generated route for
/// [_i86.VideoPreview]
class VideoPreview extends _i90.PageRouteInfo<VideoPreviewArgs> {
  VideoPreview({
    _i91.Key? key,
    required String filePath,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          VideoPreview.name,
          args: VideoPreviewArgs(
            key: key,
            filePath: filePath,
          ),
          initialChildren: children,
        );

  static const String name = 'VideoPreview';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VideoPreviewArgs>();
      return _i86.VideoPreview(
        key: args.key,
        filePath: args.filePath,
      );
    },
  );
}

class VideoPreviewArgs {
  const VideoPreviewArgs({
    this.key,
    required this.filePath,
  });

  final _i91.Key? key;

  final String filePath;

  @override
  String toString() {
    return 'VideoPreviewArgs{key: $key, filePath: $filePath}';
  }
}

/// generated route for
/// [_i87.WalletDeposit]
class WalletDeposit extends _i90.PageRouteInfo<void> {
  const WalletDeposit({List<_i90.PageRouteInfo>? children})
      : super(
          WalletDeposit.name,
          initialChildren: children,
        );

  static const String name = 'WalletDeposit';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i87.WalletDeposit();
    },
  );
}

/// generated route for
/// [_i88.WalletHomePage]
class WalletHomePage extends _i90.PageRouteInfo<WalletHomePageArgs> {
  WalletHomePage({
    _i91.Key? key,
    num walletBalance = 0,
    List<_i90.PageRouteInfo>? children,
  }) : super(
          WalletHomePage.name,
          args: WalletHomePageArgs(
            key: key,
            walletBalance: walletBalance,
          ),
          initialChildren: children,
        );

  static const String name = 'WalletHomePage';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WalletHomePageArgs>(
          orElse: () => const WalletHomePageArgs());
      return _i88.WalletHomePage(
        key: args.key,
        walletBalance: args.walletBalance,
      );
    },
  );
}

class WalletHomePageArgs {
  const WalletHomePageArgs({
    this.key,
    this.walletBalance = 0,
  });

  final _i91.Key? key;

  final num walletBalance;

  @override
  String toString() {
    return 'WalletHomePageArgs{key: $key, walletBalance: $walletBalance}';
  }
}

/// generated route for
/// [_i89.YourInterests]
class YourInterests extends _i90.PageRouteInfo<void> {
  const YourInterests({List<_i90.PageRouteInfo>? children})
      : super(
          YourInterests.name,
          initialChildren: children,
        );

  static const String name = 'YourInterests';

  static _i90.PageInfo page = _i90.PageInfo(
    name,
    builder: (data) {
      return const _i89.YourInterests();
    },
  );
}
