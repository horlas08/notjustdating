import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:ofwhich_v2/presentation/chat/plan_date.dart';
import 'package:ofwhich_v2/presentation/home/user/matched_page.dart';
import 'package:ofwhich_v2/presentation/settings/user/settings_screen.dart';

import 'app_router.gr.dart';

@LazySingleton()
@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
            durationInMilliseconds: 500,
            page: SplashRoute.page,
            initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: OnboardingRoute.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: OnboardingRoute1.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: OnboardingIndex.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: UserTypeSelectionRoute.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: RegisterRoute.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: EmailConfirmationRoute.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: CreatePasswordRoute.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: AccountCreationSuccess.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: EditNameRoute.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: DatingInterestRoute.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: PhotosSelectionRoute.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: ProfilePhotosRoute.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: DateOfBirthRoute.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: DatingInterestRoute.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: GenderRoute.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: RelationShipStatusRoute.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: SelectedProfileRoute.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: ProfileUpdateSuccessRoute.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: ChhoseYourCircle.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: LoginRoute.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: UserProfileDetails.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: ChatDetails.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: FileUploadRoute.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: UserNamePage.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: ContentCrProfilePhoto.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: ContentCreatorGender.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: DateOfBirthContectCr.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: EditInterest.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: GroupChatRoute.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: EditUserAgeRoute.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: EditUserGender.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: EditWork.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: EditHeight.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: EditWeight.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: EditSexualOrientation.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: EditExercise.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: EditEducation.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: EditNoOfKids.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: EditDrinking.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: EditSmoking.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: EditPets.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: EditReligion.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: EditValue.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: YourInterests.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: SupscriptionHome.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: UserNameUserPage.page,
            initial: false,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: BottomNavRoute.page,
            children: [
              CustomRoute(
                  durationInMilliseconds: 500,
                  page: HomeRoute.page,
                  // initial: true,
                  transitionsBuilder: TransitionsBuilders.fadeIn),
              CustomRoute(
                  durationInMilliseconds: 500,
                  page: FeedRoute.page,
                  // initial: true,
                  transitionsBuilder: TransitionsBuilders.fadeIn),
              CustomRoute(
                  durationInMilliseconds: 500,
                  page: GroupRoute.page,
                  // initial: true,
                  transitionsBuilder: TransitionsBuilders.fadeIn),
              CustomRoute(
                  durationInMilliseconds: 500,
                  page: ChatHomeRoute.page,
                  // initial: true,
                  transitionsBuilder: TransitionsBuilders.fadeIn),
              CustomRoute(
                  durationInMilliseconds: 500,
                  page: UserProfileRoute.page,
                  // initial: true,
                  transitionsBuilder: TransitionsBuilders.fadeIn),
              CustomRoute(
                  durationInMilliseconds: 500,
                  page: SettingsRoute.page,
                  // initial: true,
                  transitionsBuilder: TransitionsBuilders.fadeIn),
              CustomRoute(
                  durationInMilliseconds: 500,
                  page: NewsRoute.page,
                  // initial: true,
                  transitionsBuilder: TransitionsBuilders.fadeIn),
            ],
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: UserAddressInfo.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: WalletHomePage.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: ContentCreatorSettings.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: SecuritySettingsRoute.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: PlanADateRoute.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: MatchedRoute.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: NotificationSettingsRoute.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: PasswordUpdateSuccess.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: PayForDateRoute.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: PaymentSuccessPage.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: DatePaymentWebViewPage.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: PasswordManager.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: ForgetPassword.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: ForgotPasswordOtp.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: ResetPassword.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: PasswordResetSuccess.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: PersonalSettings.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: ContentBottomNavRoute.page,
            children: [
              CustomRoute(
                  durationInMilliseconds: 500,
                  page: ContentCreatorHomePage.page,
                  // initial: true,
                  transitionsBuilder: TransitionsBuilders.fadeIn),
              CustomRoute(
                  durationInMilliseconds: 500,
                  page: ContentCreatorNotification.page,
                  // initial: true,
                  transitionsBuilder: TransitionsBuilders.fadeIn),
              CustomRoute(
                  durationInMilliseconds: 500,
                  page: ContentCreatorSearch.page,
                  // initial: true,
                  transitionsBuilder: TransitionsBuilders.fadeIn),
              CustomRoute(
                  durationInMilliseconds: 500,
                  page: ContentCreatorProfile.page,
                  // initial: true,
                  transitionsBuilder: TransitionsBuilders.fadeIn),
            ],
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: ContentCreatorFeedPage.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: UploadPostRoute.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: VideoPreview.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: TagUsers.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: UploadPostAddText.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: LocationAdd.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: UploadSuccess.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: EditUserName.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: SendFlowerToUser.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: SendFloweSuccess.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            durationInMilliseconds: 500,
            page: WalletDeposit.page,
            // initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
      ];
}
