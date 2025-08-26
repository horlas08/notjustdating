// import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_tinder_swipe/flutter_tinder_swipe.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/home/user/widgets/cards_stack_widget.dart';
// import 'package:ofwhich_v2/presentation/home/user/matched_profile.dart';
import 'package:ofwhich_v2/presentation/home/user/widgets/filter_edit_screen.dart';
import 'package:ofwhich_v2/presentation/home/user/widgets/top_action_buttons.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
// import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
import 'package:provider/provider.dart';

// import 'package:stacked/stacked.dart';

import '../../../application/home_view_model/home_view_model.dart';
import '../../general_widgets/refresh_widget.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // CardController controller = CardController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<HomeViewModel>().getFeed();
    });
    // c.getFeed();
    // log("from homepage:::" + getIt<HomeViewModel>().hashCode.toString());
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Consumer<HomeViewModel>(
      builder: (context, model, child) => Scaffold(
          body: RefreshWidget(
        onRefresh: () async {
          // getIt<HomeViewModel>().getFeed();
        },
        child: Stack(
          children: [
            Column(
              children: [
                // Gradient 60%
                Container(
                  height: screenHeight * 0.6,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(236, 88, 115, 1),
                        Color.fromRGBO(129, 60, 191, 1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Watermark
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight * 0.6,
              child: Opacity(
                opacity: 1,
                child: Image.asset(
                  'assets/images/pngs/background_watermark.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),

            Column(
              children: [
                SizedBox(
                  height: 66.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TopActionButtons(
                            icon: "assets/images/pngs/home_wallet_icon.png",
                            onTap: () {
                              context.router.push(WalletHomePage());
                            },
                            isSelected: true,
                          ),
                        ),
                      ),
                      TopActionButtons(
                        icon: "assets/images/pngs/filter_icon.png",
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r)),
                            builder: (BuildContext context) {
                              return FilterEditScreen();
                              // return FilterWidget(homeViewModel: model);
                            },
                          );
                        },
                        isSelected: false,
                      ),
                      TopActionButtons(
                        icon: "assets/images/pngs/refresh_icon.png",
                        onTap: () async {
                          await getIt<HomeViewModel>().getFeed();
                        },
                        isSelected: false,
                      ),
                      TopActionButtons(
                        icon: "assets/images/pngs/home_help_icon.png",
                        onTap: () {
                          context.router.push(
                            YourInterests(),
                          );
                        },
                        isSelected: false,
                      ),

                      // InkResponse(

                      //     onTap: () {
                      //       getIt<AppRouter>().push(const YourInterests());
                      //     },
                      //     child: Image.asset("assets/images/pngs/star.png")),

                      // const AppLogo(),
                      // InkResponse(
                      //     onTap: () {
                      //       showModalBottomSheet(
                      //         isScrollControlled: true,
                      //         context: context,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(10.r)),
                      //         builder: (BuildContext context) {
                      //           return FilterWidget(homeViewModel: model);
                      //         },
                      //       );
                      //     },
                      //     child: Image.asset("assets/images/pngs/filter.png"))
                    ],
                  ),
                ),
                SizedBox(
                  height: 13.h,
                ),
                const CardsListWidget(),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
