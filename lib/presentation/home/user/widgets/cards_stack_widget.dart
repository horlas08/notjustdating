import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/home_view_model/home_view_model.dart';
import 'package:ofwhich_v2/presentation/home/user/matched_profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/user_service/model/user_gift.dart';
import '../../../../domain/user_service/model/user_object.dart';
import '../../../../injectable.dart';
import '../../../core/font.dart';
import '../../../general_widgets/custom_button.dart';
import '../../../routes/app_router.dart';
import '../../../routes/app_router.gr.dart';
// import '../model/flower_model.dart';

import '../plan_date_screen.dart';
import 'flower_card.dart';

// class CardsStackWidget extends StatefulWidget {
//   const CardsStackWidget({Key? key}) : super(key: key);

//   @override
//   State<CardsStackWidget> createState() => _CardsStackWidgetState();
// }

// class _CardsStackWidgetState extends State<CardsStackWidget>
//     with SingleTickerProviderStateMixin {
//   ValueNotifier<Swipe> swipeNotifier = ValueNotifier(Swipe.none);
//   late final AnimationController _animationController;
//   int currentIndex = -1;
//   Offset position = Offset.zero; // Current drag position
//   double angle = 0.0; // Current drag angle

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//     final h = getIt<HomeViewModel>();

//     h.getFeed();
//     h.getGifts();
//     _animationController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         if (swipeNotifier.value == Swipe.left) {
//           // Call dislikeProfile on left swipe
//           // h.dislikeProfile(
//           //     userId: h.feeds!.users![currentIndex].id.toString());
//         } else if (swipeNotifier.value == Swipe.right) {
//           // Call likeProfile on right swipe
//           h.likeProfile(user: h.feeds!.users![currentIndex]);
//         }

//         if (h.feeds != null &&
//             h.feeds!.users != null &&
//             h.feeds!.users!.isNotEmpty) {
//           // Remove the current swiped card and reset animation
//           h.removeUserAtParticularIndex(currentIndex: currentIndex);
//           _animationController.reset();
//           swipeNotifier.value = Swipe.none; // Reset swipe state
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void onPanUpdate(DragUpdateDetails details) {
//     setState(() {
//       position += details.delta;
//       angle = position.dx / MediaQuery.of(context).size.width * 0.1;
//     });
//   }

//   void onPanEnd(HomeViewModel model) {
//     if (position.dx > 100) {
//       swipeNotifier.value = Swipe.right;
//       model.likeProfile(user: model.feeds!.users![currentIndex]);
//       _animationController.forward();
//     } else if (position.dx < -100) {
//       swipeNotifier.value = Swipe.left;
//       _animationController.forward();
//     } else {
//       resetPosition();
//     }

//     // Reset after animation
//     _animationController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         if (model.feeds != null &&
//             model.feeds!.users != null &&
//             model.feeds!.users!.isNotEmpty) {
//           // setState(() {
//           //   model.feeds!.users!.removeAt(currentIndex);
//           // });
//           resetPosition();
//         }
//       }
//     });
//   }

//   void resetPosition() {
//     setState(() {
//       position = Offset.zero;
//       angle = 0.0;
//       swipeNotifier.value = Swipe.none;
//       _animationController.reset();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<HomeViewModel>(
//       // viewModelBuilder: () => getIt<HomeViewModel>(),
//       // onViewModelReady: (h) {

//       // },
//       builder: (context, model, child) => SizedBox(
//         height: MediaQuery.of(context).size.height * 0.8,
//         child: model.isBusy
//             ? const Center(child: CircularProgressIndicator.adaptive())
//             : model.feeds == null
//                 ? const Text("An Error Occurred")
//                 : model.feeds!.users != null && model.feeds!.users!.isEmpty
//                     ? const Center(child: Text("Empty Feed"))
//                     : Stack(
//                         clipBehavior: Clip.none,
//                         children: [
//                           ValueListenableBuilder(
//                             valueListenable: swipeNotifier,
//                             builder: (context, swipe, _) => Stack(
//                               clipBehavior: Clip.none,
//                               alignment: Alignment.center,
//                               children: List.generate(
//                                   model.feeds!.users!.length, (index) {
//                                 currentIndex = index;

//                                 if (index == model.feeds!.users!.length - 1) {
//                                   return PositionedTransition(
//                                     rect: RelativeRectTween(
//                                       begin: RelativeRect.fromSize(
//                                           const Rect.fromLTWH(0, 0, 580, 340),
//                                           const Size(580, 340)),
//                                       end: RelativeRect.fromSize(
//                                           Rect.fromLTWH(
//                                               swipe == Swipe.left
//                                                   ? -300
//                                                   : swipe == Swipe.right
//                                                       ? 300
//                                                       : 0,
//                                               0,
//                                               580,
//                                               340),
//                                           const Size(580, 340)),
//                                     ).animate(CurvedAnimation(
//                                       parent: _animationController,
//                                       curve: Curves.easeInOut,
//                                     )),
//                                     child: RotationTransition(
//                                         turns: Tween<double>(
//                                                 begin: 0,
//                                                 end: swipe == Swipe.left
//                                                     ? -0.1
//                                                     : swipe == Swipe.right
//                                                         ? 0.1
//                                                         : 0.0)
//                                             .animate(
//                                           CurvedAnimation(
//                                             parent: _animationController,
//                                             curve: const Interval(0, 0.4,
//                                                 curve: Curves.easeInOut),
//                                           ),
//                                         ),
//                                         child: DragWidget(
//                                           currentIndex: currentIndex,
//                                           profile: model.feeds!.users![index],
//                                           isLastCard: index ==
//                                               model.feeds!.users!.length - 1,
//                                           position: position,
//                                           angle: angle,
//                                           swipeNotifier: swipeNotifier,
//                                           onPanUpdate: onPanUpdate,
//                                           onPanEnd: () => onPanEnd(model),
//                                           selectedProfileCallback: () {
//                                             _animationController
//                                                 .addStatusListener((status) {
//                                               if (status ==
//                                                   AnimationStatus.completed) {
//                                                 if (swipeNotifier.value ==
//                                                     Swipe.left) {
//                                                   // Call dislikeProfile on left swipe
//                                                   // h.dislikeProfile(
//                                                   //     userId: h.feeds!.users![currentIndex].id.toString());
//                                                 } else if (swipeNotifier
//                                                         .value ==
//                                                     Swipe.right) {
//                                                   // Call likeProfile on right swipe
//                                                   model.likeProfile(
//                                                       user: model.feeds!.users![
//                                                           currentIndex]);
//                                                 }

//                                                 if (model.feeds != null &&
//                                                     model.feeds!.users !=
//                                                         null &&
//                                                     model.feeds!.users!
//                                                         .isNotEmpty) {
//                                                   // Remove tmodele current swiped card and reset animation
//                                                   model
//                                                       .removeUserAtParticularIndex(
//                                                           currentIndex:
//                                                               currentIndex);
//                                                   _animationController.reset();
//                                                   swipeNotifier.value = Swipe
//                                                       .none; // Reset swipe state
//                                                 }
//                                               }
//                                             });
//                                           },
//                                         )),
//                                   );
//                                 } else {
//                                   return DragWidget(
//                                     selectedProfileCallback: () {
//                                       _animationController
//                                           .addStatusListener((status) {
//                                         if (status ==
//                                             AnimationStatus.completed) {
//                                           if (swipeNotifier.value ==
//                                               Swipe.left) {
//                                             // Call dislikeProfile on left swipe
//                                             // h.dislikeProfile(
//                                             //     userId: h.feeds!.users![currentIndex].id.toString());
//                                           } else if (swipeNotifier.value ==
//                                               Swipe.right) {
//                                             // Call likeProfile on right swipe
//                                             model.likeProfile(
//                                                 user: model.feeds!
//                                                     .users![currentIndex]);
//                                           }

//                                           if (model.feeds != null &&
//                                               model.feeds!.users != null &&
//                                               model.feeds!.users!.isNotEmpty) {
//                                             // Remove tmodele current swiped card and reset animation
//                                             model.removeUserAtParticularIndex(
//                                                 currentIndex: currentIndex);
//                                             _animationController.reset();
//                                             swipeNotifier.value =
//                                                 Swipe.none; // Reset swipe state
//                                           }
//                                         }
//                                       });
//                                     },
//                                     currentIndex: currentIndex,
//                                     profile: model.feeds!.users![index],
//                                     isLastCard:
//                                         index == model.feeds!.users!.length - 1,
//                                     position: position,
//                                     angle: angle,
//                                     swipeNotifier: swipeNotifier,
//                                     onPanUpdate: onPanUpdate,
//                                     onPanEnd: () => onPanEnd(model),
//                                   );
//                                 }
//                               }),
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 10.h,
//                             left: 0,
//                             right: 0,
//                             child: Padding(
//                               padding: EdgeInsets.only(bottom: 46.0.w),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   ActionButtonWidget(
//                                       onPressed: () {
//                                         swipeNotifier.value = Swipe.left;
//                                         _animationController
//                                             .forward(); // Start animation on left swipe
//                                       },
//                                       icon: Image.asset(
//                                           "assets/images/pngs/dislike.png")),
//                                   const SizedBox(width: 20),
//                                   ActionButtonWidget(
//                                     containerHeight: 100.h,
//                                     backgroundColor: const Color(0xFFEC5873),
//                                     onPressed: () {
//                                       swipeNotifier.value = Swipe.right;
//                                       _animationController
//                                           .forward(); // Start animation on right swipe
//                                     },
//                                     icon: Transform.scale(
//                                         scale: 1.1,
//                                         child: Image.asset(
//                                             "assets/images/pngs/heart.png")),
//                                   ),
//                                   const SizedBox(width: 20),
//                                   ActionButtonWidget(
//                                       onPressed: () {
//                                         showModalBottomSheet(
//                                             context: context,
//                                             isScrollControlled: true,
//                                             builder: (context) {
//                                               return FlowerBottomSheet(
//                                                   viewModel: model,
//                                                   currentIndex: currentIndex);
//                                             });
//                                       },
//                                       icon: Image.asset(
//                                           "assets/images/pngs/sparkle.png")),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//       ),
//     );
//   }
// }

class CardsListWidget extends StatefulWidget {
  const CardsListWidget({Key? key}) : super(key: key);

  @override
  State<CardsListWidget> createState() => _CardsListWidgetState();
}

class _CardsListWidgetState extends State<CardsListWidget> {
  PageController _pageController = PageController(viewportFraction: 0.85);
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    final h = getIt<HomeViewModel>();
    h.getFeed();
    h.getGifts();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController(
      viewportFraction: 1.0, // makes each page take full width
    );
    return Consumer<HomeViewModel>(
      builder: (context, model, child) => SizedBox(
        height: 640.h,
        child: model.isBusy
            ? const Center(child: CircularProgressIndicator.adaptive())
            : model.feeds == null
                ? const Text("An Error Occurred")
                : model.feeds!.users != null && model.feeds!.users!.isEmpty
                    ? const Center(child: Text("Empty Feed"))
                    : Column(
                        children: [
                          // Main Cards List

                          Expanded(
                            child: PageView.builder(
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              padEnds: false, // removes extra start/end padding
                              physics: const BouncingScrollPhysics(),
                              itemCount: model.feeds!.users!.length,
                              itemBuilder: (context, index) {
                                return SizedBox.expand(
                                  // makes sure it takes the whole screen space
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MatchedProfile(
                                            profile: model.feeds!.users![index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: MatchCardWidget(
                                        profile: model.feeds!.users![index],
                                        onNotInterested: () {
                                          _handleNotInterested(model, index);
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )

                          // Action Buttons
                          // Padding(
                          //   padding: EdgeInsets.only(bottom: 46.0, top: 20.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       ActionButtonWidget(
                          //           onPressed: () {
                          //             // Dislike current profile
                          //             if (model.feeds!.users!.isNotEmpty) {
                          //               // model.dislikeProfile(
                          //               //   userId: model.feeds!.users![currentIndex].id.toString()
                          //               // );
                          //               _removeCurrentCard(model);
                          //             }
                          //           },
                          //           icon: Image.asset(
                          //               "assets/images/pngs/dislike.png")),
                          //       const SizedBox(width: 20),
                          //       ActionButtonWidget(
                          //         containerHeight: 100,
                          //         backgroundColor: const Color(0xFFEC5873),
                          //         onPressed: () {
                          //           // Like current profile
                          //           if (model.feeds!.users!.isNotEmpty) {
                          //             model.likeProfile(
                          //                 user: model
                          //                     .feeds!.users![currentIndex]);
                          //             _removeCurrentCard(model);
                          //           }
                          //         },
                          //         icon: Transform.scale(
                          //             scale: 1.1,
                          //             child: Image.asset(
                          //                 "assets/images/pngs/heart.png")),
                          //       ),
                          //       const SizedBox(width: 20),
                          //       ActionButtonWidget(
                          //           onPressed: () {
                          //             showModalBottomSheet(
                          //                 context: context,
                          //                 isScrollControlled: true,
                          //                 builder: (context) {
                          //                   return FlowerBottomSheet(
                          //                       viewModel: model,
                          //                       currentIndex: currentIndex);
                          //                 });
                          //           },
                          //           icon: Image.asset(
                          //               "assets/images/pngs/sparkle.png")),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
      ),
    );
  }

  void _handleNotInterested(HomeViewModel model, int index) {
    if (index < model.feeds!.users!.length - 1) {
      // ✅ Skip to next card
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // ✅ Last card → remove it
      _removeCurrentCard(model);
    }
  }

  void _removeCurrentCard(HomeViewModel model) {
    if (model.feeds!.users!.isNotEmpty) {
      model.removeUserAtParticularIndex(currentIndex: currentIndex);

      // Adjust currentIndex if needed
      if (currentIndex >= model.feeds!.users!.length &&
          model.feeds!.users!.isNotEmpty) {
        setState(() {
          currentIndex = model.feeds!.users!.length - 1;
        });
      }

      // Animate to the new current card if there are still cards
      if (model.feeds!.users!.isNotEmpty) {
        _pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }
}

// Profile Card Widget
class ProfileCard extends StatelessWidget {
  final UserModel profile; // Replace with your actual User model
  final bool isCurrentCard;
  final VoidCallback onTap;

  const ProfileCard({
    Key? key,
    required this.profile,
    required this.isCurrentCard,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background Image
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      profile.photo ?? ''), // Adjust based on your model
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),

            // Profile Info
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.full_name ??
                        'Unknown', // Adjust based on your model
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isCurrentCard ? 28 : 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    profile.dob?.toString() ?? '', // Adjust based on your model
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: isCurrentCard ? 18 : 16,
                    ),
                  ),
                  if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      profile.bio!,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: isCurrentCard ? 16 : 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            // Current card indicator
            if (isCurrentCard)
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEC5873),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Current',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class FlowerBottomSheet extends StatefulWidget {
  const FlowerBottomSheet({
    super.key,
    required this.viewModel,
    // required this.draggableItems,
    required this.currentIndex,
  });

  // final List<UserModel> draggableItems;
  final int currentIndex;
  final HomeViewModel viewModel;

  @override
  State<FlowerBottomSheet> createState() => _FlowerBottomSheetState();
}

class _FlowerBottomSheetState extends State<FlowerBottomSheet> {
  int flowercurrentIndex = -1;
  UserGift? gift;
  @override
  void initState() {
    // widget.viewModel.getGifts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      width: MediaQuery.of(context).size.width,
      child: widget.viewModel.gifts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        maxRadius: 70.r,
                        backgroundImage: CachedNetworkImageProvider(widget
                                .viewModel
                                .feeds!
                                .users![widget.currentIndex]
                                .photo ??
                            ""),
                      ),
                      Positioned(
                          right: -25.h,
                          bottom: -45.h,
                          child: Image.asset("assets/images/pngs/sparks.png"))
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text("Show them you really like them",
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontFamily: Font.inter,
                          fontWeight: FontWeight.w600)),
                  Text(
                      "Send ${widget.viewModel.feeds!.users![widget.currentIndex].full_name} a flower to stand out from the crowd and boast your chance of a match",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: Font.inter,
                          color: const Color(0xFF575757))),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 10.w,
                          );
                        },
                        itemCount: widget.viewModel.gifts.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          gift = widget.viewModel.gifts[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                flowercurrentIndex = index;
                              });
                            },
                            child: FlowerCard(
                                isSelected: flowercurrentIndex == index,
                                // flowercurrentIndex: flowercurrentIndex,
                                gift: gift),
                          );
                        }),
                  ),
                  CustomButton(
                      borderRadius: BorderRadius.circular(10.r),
                      height: 65.h,
                      child: Text("Send Flower",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontFamily: Font.inter)),
                      onPressed: () {
                        UserModel user =
                            widget.viewModel.feeds!.users![widget.currentIndex];
                        getIt<AppRouter>()
                            .push(SendFlowerToUser(user: user, gift: gift!));
                        // model.sendGiftToUser(amount: gift!.unit_price);
                      }),
                  CustomButton(
                      borderRadius: BorderRadius.circular(10.r),
                      height: 65.h,
                      bgColor: Colors.transparent,
                      child: Text("Maybe Later",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontFamily: Font.inter)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              ),
            ),
    );
  }
}

class MatchCardWidget extends StatefulWidget {
  final UserModel profile;
  MatchCardWidget(
      {super.key, required this.profile, required this.onNotInterested});

  final VoidCallback onNotInterested; // 👈 callback

  @override
  State<MatchCardWidget> createState() => _MatchCardWidgetState();
}

class _MatchCardWidgetState extends State<MatchCardWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: 640.h,
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                    widget.profile.photo ?? ''), // Adjust based on your model
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            top: 20,
            right: 20,
            child: Row(
              children: [
                const Icon(Icons.flag, color: Colors.white, size: 18),
                const SizedBox(width: 4),
                Text(
                  'Manchester',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: Font.inter,
                    fontSize: 16.sp,
                    shadows: const [
                      Shadow(
                        blurRadius: 2,
                        color: Colors.black45,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom: Info Panel
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black54,
                    Colors.black87,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Online Indicator
                  Row(
                    children: [
                      Text(
                        widget.profile.full_name ?? 'Unknown',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: Font.inter,
                          fontSize: 33.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 9.w,
                        height: 9.h,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),

                  // Tags
                  Row(
                    children: [
                      _buildTag("Open-minded"),
                      const SizedBox(width: 8),
                      _buildTag("Sustainability"),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 60.h,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              foregroundColor: Colors.white,
                              side: const BorderSide(
                                color: Color.fromRGBO(255, 255, 255, 0.3),
                              ),
                            ),
                            onPressed: () {
                              widget.onNotInterested.call();
                            },
                            child: Text(
                              "Not Interested",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: Font.inter,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 60.h,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(236, 88, 115, 1),
                              side: const BorderSide(
                                  width: 0,
                                  color: Color.fromRGBO(236, 88, 115, 1)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            onPressed: () async {
                              final authUser = await getUserSavedLocally();
                              if (!context.mounted) return;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlanDateScreen(
                                      profile: widget.profile,
                                      authUser: authUser!,
                                    ),
                                  ));
                            },
                            child: Text("I'll go for a drink",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: Font.inter,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}

Future<UserModel?> getUserSavedLocally() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userString = prefs.getString("user") ?? "";
  if (userString != "") {
    return UserModel.fromMap(json.decode(userString));
  } else {
    return null;
  }
}
