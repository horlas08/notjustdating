import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/injectable.dart';

import '../../application/group_view_model/group_view_model.dart';
import '../general_widgets/custom_bottom_navbar_item.dart';
import '../routes/app_router.gr.dart';

@RoutePage()
class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  List<PageRouteInfo<dynamic>> bottomNavTabs = [
    const HomeRoute(),
    // const FeedRoute(),
    // const GroupRoute(),
    const ChatHomeRoute(),
   const NewsRoute(),
    const UserProfileRoute(),
    const SettingsRoute()
  ];

  @override
  void initState() {
    // getIt<GroupViewModel>().manageGroupCreation();
    super.initState();
  }

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
                        icon: "assets/images/pngs/new_home_icon.png",
                        iconActive: "assets/images/pngs/new_home_icon.png",
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
                  // Expanded(
                  //   child: CustomBottomNavItem(
                  //       icon: "assets/images/pngs/play_Icon.png",
                  //       iconActive: "assets/images/home_icon.png",
                  //       title: "Home",
                  //       isSelected: tabsRouter.activeIndex == 1,
                  //       onTap: () {
                  //         tabsRouter.setActiveIndex(1);
                  //       }),
                  // ),
                  // Expanded(
                  //   child: CustomBottomNavItem(
                  //       icon: "assets/images/pngs/notification_icon.png",
                  //       iconActive: "assets/images/cards.png",
                  //       // title: "Cards",
                  //       isSelected: tabsRouter.activeIndex == 2,
                  //       onTap: () {
                  //         // model.returnSpecificRoute(index: 0);
                  //         // setState(() {
                  //         //   model.setCurrentIndex = 2;
                  //         //   // redrawObbject = Object();
                  //         // });
                  //         tabsRouter.setActiveIndex(2);
                  //         // model.removeAndAddRoute(0);
                  //       }),
                  // ),
                  Expanded(
                    child: CustomBottomNavItem(
                        icon: "assets/images/pngs/dates_icon.png",
                        iconActive: "assets/images/pngs/dates_icon.png",
                        // title: "Cards",
                        isSelected: tabsRouter.activeIndex == 1,
                        onTap: () {
                          // model.returnSpecificRoute(index: 0);
                          // setState(() {
                          //   model.setCurrentIndex = 2;
                          //   // redrawObbject = Object();
                          // });
                          tabsRouter.setActiveIndex(1);
                          // model.removeAndAddRoute(0);
                        }),
                  ),
                   Expanded(
                    child: CustomBottomNavItem(
                        icon: "assets/images/pngs/news_icon.png",
                        iconActive: "assets/images/pngs/news_icon.png",
                        // title: "Cards",
                        isSelected: tabsRouter.activeIndex ==2,
                        onTap: () {
                          // model.returnSpecificRoute(index: 0);
                          // setState(() {
                          //   model.setCurrentIndex = 2;
                          //   // redrawObbject = Object();
                          // });
                          tabsRouter.setActiveIndex(2);
                          // model.removeAndAddRoute(0);
                        }),
                  ),
                  Expanded(
                    child: CustomBottomNavItem(
                        icon: "assets/images/pngs/profile_icon.png",
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
                  ),
                   Expanded(
                    child: CustomBottomNavItem(
                        icon: "assets/images/pngs/settings_icon.png",
                        iconActive: "assets/images/settings_icon.png",
                        isSelected: tabsRouter.activeIndex == 4,
                        onTap: () {
                          setState(() {
                            // model.returnSpecificRoute(index: 2);
                            // model.setCurrentIndex = 4;
                            // redrawObbject = Object();
                            tabsRouter.setActiveIndex(4);
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
