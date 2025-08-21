import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/profile/profile_view_model.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
import 'package:provider/provider.dart';

import '../../../injectable.dart';
import '../../routes/app_router.dart';

@RoutePage()
class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getIt<ProfileViewModel>().getUserSavedLocally();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      // onViewModelReady: (h) {

      // },
      builder: (context, model, child) => Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 50.h,
            ),
            Align(
                alignment: Alignment.centerLeft,
                // mainAxisAlignment: MainAxisAlignment.center,
                child: Text("My Profile",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: Font.inter,
                        fontWeight: FontWeight.w500))),
            SizedBox(
              height: 50.h,
            ),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          maxRadius: 70.r,
                          backgroundImage: CachedNetworkImageProvider(
                              model.user?.photo ?? ""),
                        ),
                        Positioned(
                            bottom: 1.w,
                            right: -1.h,
                            child: Image.asset(
                                "assets/images/pngs/edit_profile.png"))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(model.user?.full_name ?? "",
                    style: TextStyle(
                        fontFamily: Font.inter,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: const LinearProgressIndicator(
                        value: 0.6,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFFEC5873))),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text("60% compete your profile",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: Font.inter,
                        color: const Color(0xFFEC5873)))
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
            // InkResponse(
            //   onTap: () {
            //     getIt<AppRouter>().push(WalletHomePage(
            //         walletBalance: model.user!.wallet_balance ?? 0));
            //   },
            //   child: Container(
            //     height: 70.h,
            //     width: MediaQuery.of(context).size.width,
            //     decoration: BoxDecoration(
            //         color: const Color(0xFFEC5873),
            //         borderRadius: BorderRadius.circular(20.r)),
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Row(
            //             children: [
            //               Image.asset("assets/images/pngs/balance.png"),
            //               SizedBox(
            //                 width: 10.w,
            //               ),
            //               Text("Balance",
            //                   style: TextStyle(
            //                       fontFamily: Font.inter,
            //                       fontSize: 16.sp,
            //                       fontWeight: FontWeight.w400,
            //                       color: Colors.white))
            //             ],
            //           ),
            //           model.user != null && model.user!.wallet_balance != null
            //               ? Text("${model.user!.wallet_balance} Credits",
            //                   style: TextStyle(
            //                       color: Colors.white,
            //                       fontSize: 20.sp,
            //                       fontWeight: FontWeight.w400))
            //               : Text("0 Credits",
            //                   style: TextStyle(
            //                       color: Colors.white,
            //                       fontSize: 20.sp,
            //                       fontWeight: FontWeight.w400))
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 40.h),
            ProfileCard(
              onPressed: () {
                getIt<AppRouter>().push(const UserProfileDetails());
              },
              imgIcon: "assets/images/pngs/small_profile_Icon.png",
              titelText: "Your Profile",
            ),
            SizedBox(height: 10.h),
            const ProfileCard(
              imgIcon: "assets/images/pngs/wallet_icon.png",
              titelText: "Payment Methods",
            ),
            SizedBox(height: 10.h),
            const ProfileCard(
              imgIcon: "assets/images/pngs/group_invite_icon.png",
              titelText: "Invite Friends",
            ),
            SizedBox(height: 10.h),
            // const ProfileCard(
            //   imgIcon: "assets/images/pngs/help_icon.png",
            //   titelText: "Help Center",
            // ),
            // SizedBox(height: 10.h),

            SizedBox(height: 10.h),
            const ProfileCard(
              imgIcon: "assets/images/pngs/privacy_policy.png",
              titelText: "Privacy Policy",
            ),
            // SizedBox(height: 10.h),
            // ProfileCard(
            //   onPressed: () {
            //     // getIt<AppRouter>().pushAndPopUntil(
            //     //     LoginRoute(userType: model.user!.user_type),
            //     //     predicate: (val) => false);
            //     model.logOut();
            //   },
            //   imgIcon: "assets/images/pngs/small_profile_Icon.png",
            //   titelText: "Log Out",
            // ),
          ]),
        ),
      )),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    this.imgIcon,
    this.titelText,
    this.onPressed,
  });
  final String? imgIcon;
  final String? titelText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      imgIcon ?? "",
                      color: Colors.black,
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(titelText ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontFamily: Font.inter))
                  ],
                ),
                //  Image.asset("assets/images/pngs/arrow_right.png"),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 20.h,
              child: const Divider(
                color: Color(0xFFE2E2E2),
                thickness: 0.5,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SlantedEdgeContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const SlantedEdgeContainer({
    super.key,
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipPath(
        clipper: SlantedEdgeClipper(),
        child: Container(
          color: color,
        ),
      ),
    );
  }
}

class SlantedEdgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(
        size.width * 0.2, 0); // Adjust the slant here (0.2 for 20% slant)
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
