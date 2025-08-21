import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/injectable.dart';

import '../../general_widgets/custom_bottom_navbar_item.dart';
import '../../routes/app_router.dart';
import '../../routes/app_router.gr.dart';

// import '../general_widgets/custom_bottom_navbar_item.dart';
// import '../routes/app_router.gr.dart';

@RoutePage()
class ContentBottomNavScreen extends StatefulWidget {
  const ContentBottomNavScreen({super.key});

  @override
  State<ContentBottomNavScreen> createState() => _ContentBottomNavScreenState();
}

class _ContentBottomNavScreenState extends State<ContentBottomNavScreen> {
  List<PageRouteInfo<dynamic>> bottomNavTabs = [
    const ContentCreatorHomePage(),
    const ContentCreatorNotification(),
    // const ContentCreatorFeedPage(),
    const ContentCreatorSearch(),
    const ContentCreatorProfile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AutoTabsScaffold(
        routes: bottomNavTabs,
        bottomNavigationBuilder: (context, tabsRouter) => Padding(
          padding: EdgeInsets.only(
            left: 10.0.w,
            right: 10.w,
            bottom: 10.w,
          ),
          child: SizedBox(
              // color: Colors.green,
              height: 80.h,
              // width: size.width - 200.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomBottomNavItem(
                        icon: "assets/images/pngs/home_Icon.png",
                        iconActive: "assets/images/more_options.png",
                        isSelected: tabsRouter.activeIndex == 0,
                        onTap: () {
                          setState(() {
                            // model.returnSpecificRoute(index: 2);
                            // model.setCurrentIndex = 4;
                            // redrawObbject = Object();
                            tabsRouter.setActiveIndex(0);
                          });
                          // model.removeAndAddRoute(3);
                        }),
                  ),
                  Expanded(
                    child: CustomBottomNavItem(
                        icon: "assets/images/pngs/notification_Icon_cr.png",
                        iconActive: "assets/images/home_icon.png",
                        title: "Home",
                        isSelected: tabsRouter.activeIndex == 1,
                        onTap: () {
                          tabsRouter.setActiveIndex(1);
                        }),
                  ),
                  SizedBox(
                    // height: 40.h,
                    // width: MediaQuery.of(context).size.width * 0.14,
                    child: CustomBottomNavItem(
                        iconHeight: 50.h,
                        iconWidth: 80.w,
                        icon: "assets/images/pngs/content_feed_icon.png",
                        iconActive: "assets/images/cards.png",
                        // title: "Cards",
                        // isSelected: tabsRouter.activeIndex == 2,
                        isThird: true,
                        onTap: () {
                          getIt<AppRouter>()
                              .push(const ContentCreatorFeedPage());
                          // tabsRouter.setActiveIndex(2);
                          // model.removeAndAddRoute(0);
                        }),
                  ),
                  Expanded(
                    child: CustomBottomNavItem(
                        icon: "assets/images/pngs/search_icon.png",
                        iconActive: "assets/images/cards.png",
                        // title: "Cards",
                        isSelected: tabsRouter.activeIndex == 2,
                        // isThird: true,
                        onTap: () {
                          tabsRouter.setActiveIndex(2);
                          // model.removeAndAddRoute(0);
                        }),
                  ),
                  Expanded(
                    child: CustomBottomNavItem(
                        icon: "assets/images/pngs/small_profile_icon.png",
                        iconActive: "assets/images/more_options.png",
                        isSelected: tabsRouter.activeIndex == 3,
                        onTap: () {
                          setState(() {
                            // model.returnSpecificRoute(index: 2);
                            // model.setCurrentIndex = 4;
                            // redrawObbject = Object();
                            tabsRouter.setActiveIndex(3);
                          });
                          // model.removeAndAddRoute(3);
                        }),
                  )
                ],
              )
              // width: size.width * 0.2,
              ),
        ),
      ),
    );
  }
}
