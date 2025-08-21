// // import 'package:flutter/material.dart';
// // import 'package:ofwhich_v2/presentation/home/user/widgets/profile_card.dart';
// // import 'package:ofwhich_v2/presentation/home/user/widgets/tag_widget.dart';

// // import '../../../../domain/user_service/model/user_object.dart';
// // import '../constants/swipe_enum.dart';
// // // import '../model/profile_model.dart';
// // // import 'package:ofwhich/presentation/home/constants/swipe_enum.dart';
// // // import 'package:ofwhich/presentation/home/model/profile_model.dart';
// // // import 'package:ofwhich/presentation/home/widgets/profile_card.dart';
// // // import 'package:ofwhich/presentation/home/widgets/tag_widget.dart';

// // class DragWidget extends StatefulWidget {
// //   const DragWidget({
// //     Key? key,
// //     required this.profile,
// //     required this.index,
// //     required this.swipeNotifier,
// //     this.isLastCard = false,
// //   }) : super(key: key);
// //   final UserModel profile;
// //   final int index;
// //   final ValueNotifier<Swipe> swipeNotifier;
// //   final bool isLastCard;

// //   @override
// //   State<DragWidget> createState() => _DragWidgetState();
// // }

// // class _DragWidgetState extends State<DragWidget> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: Draggable<int>(
// //         // Data is the value this Draggable stores.
// //         data: widget.index,
// //         feedback: Material(
// //           color: Colors.transparent,
// //           child: ValueListenableBuilder(
// //             valueListenable: widget.swipeNotifier,
// //             builder: (context, swipe, _) {
// //               return RotationTransition(
// //                 turns: widget.swipeNotifier.value != Swipe.none
// //                     ? widget.swipeNotifier.value == Swipe.left
// //                         ? const AlwaysStoppedAnimation(-15 / 360)
// //                         : const AlwaysStoppedAnimation(15 / 360)
// //                     : const AlwaysStoppedAnimation(0),
// //                 child: Stack(
// //                   children: [
// //                     ProfileCard(profile: widget.profile),
// //                     widget.swipeNotifier.value != Swipe.none
// //                         ? widget.swipeNotifier.value == Swipe.right
// //                             ? Positioned(
// //                                 top: 40,
// //                                 left: 20,
// //                                 child: Transform.rotate(
// //                                   angle: 12,
// //                                   child: TagWidget(
// //                                     text: 'LIKE',
// //                                     color: Colors.green[400]!,
// //                                   ),
// //                                 ),
// //                               )
// //                             : Positioned(
// //                                 top: 50,
// //                                 right: 24,
// //                                 child: Transform.rotate(
// //                                   angle: -12,
// //                                   child: TagWidget(
// //                                     text: 'DISLIKE',
// //                                     color: Colors.red[400]!,
// //                                   ),
// //                                 ),
// //                               )
// //                         : const SizedBox.shrink(),
// //                   ],
// //                 ),
// //               );
// //             },
// //           ),
// //         ),
// //         onDragUpdate: (DragUpdateDetails dragUpdateDetails) {
// //           if (dragUpdateDetails.delta.dx > 0 &&
// //               dragUpdateDetails.globalPosition.dx >
// //                   MediaQuery.of(context).size.width / 2) {
// //             widget.swipeNotifier.value = Swipe.right;
// //           }
// //           if (dragUpdateDetails.delta.dx < 0 &&
// //               dragUpdateDetails.globalPosition.dx <
// //                   MediaQuery.of(context).size.width / 2) {
// //             widget.swipeNotifier.value = Swipe.left;
// //           }
// //         },
// //         onDragEnd: (drag) {
// //           widget.swipeNotifier.value = Swipe.none;
// //         },

// //         childWhenDragging: Container(
// //           color: Colors.transparent,
// //         ),

// //         child: ValueListenableBuilder(
// //             valueListenable: widget.swipeNotifier,
// //             builder: (BuildContext context, Swipe swipe, Widget? child) {
// //               return Stack(
// //                 children: [
// //                   ProfileCard(profile: widget.profile),
// //                   // heck if this is the last card and Swipe is not equal to Swipe.none
// //                   swipe != Swipe.none && widget.isLastCard
// //                       ? swipe == Swipe.right
// //                           ? Positioned(
// //                               top: 40,
// //                               left: 20,
// //                               child: Transform.rotate(
// //                                 angle: 12,
// //                                 child: TagWidget(
// //                                   text: 'LIKE',
// //                                   color: Colors.green[400]!,
// //                                 ),
// //                               ),
// //                             )
// //                           : Positioned(
// //                               top: 50,
// //                               right: 24,
// //                               child: Transform.rotate(
// //                                 angle: -12,
// //                                 child: TagWidget(
// //                                   text: 'DISLIKE',
// //                                   color: Colors.red[400]!,
// //                                 ),
// //                               ),
// //                             )
// //                       : const SizedBox.shrink(),
// //                 ],
// //               );
// //             }),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:ofwhich_v2/presentation/home/user/widgets/profile_card.dart';
// import 'package:ofwhich_v2/presentation/home/user/widgets/tag_widget.dart';
// import '../../../../domain/user_service/model/user_object.dart';
// import '../constants/swipe_enum.dart';

// class DragWidget extends StatefulWidget {
//   const DragWidget({
//     Key? key,
//     required this.profile,
//     required this.index,
//     required this.swipeNotifier,
//     this.isLastCard = false,
//   }) : super(key: key);

//   final UserModel profile;
//   final int index;
//   final ValueNotifier<Swipe> swipeNotifier;
//   final bool isLastCard;

//   @override
//   State<DragWidget> createState() => _DragWidgetState();
// }

// class _DragWidgetState extends State<DragWidget> {
//   Offset position = Offset.zero; // Track position of the draggable
//   double angle = 0.0; // Rotation angle for visual feedback

//   void _onPanUpdate(DragUpdateDetails details) {
//     setState(() {
//       // Update position based on drag movement
//       position += details.delta;
//       // Calculate angle for visual feedback based on horizontal movement
//       angle = position.dx / MediaQuery.of(context).size.width * 0.1;
//     });
//   }

//   void _onPanEnd(DragEndDetails details) {
//     // Determine if the swipe is strong enough to trigger an action
//     if (position.dx > 100) {
//       widget.swipeNotifier.value = Swipe.right;
//     } else if (position.dx < -100) {
//       widget.swipeNotifier.value = Swipe.left;
//     } else {
//       // Reset position and angle if swipe is not strong enough
//       setState(() {
//         position = Offset.zero;
//         angle = 0.0;
//       });
//     }

//     // Reset swipe state for the next interaction
//     widget.swipeNotifier.value = Swipe.none;
//     setState(() {
//       position = Offset.zero;
//       angle = 0.0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onPanUpdate: _onPanUpdate,
//       onPanEnd: _onPanEnd,
//       child: Transform.translate(
//         offset: position,
//         child: Transform.rotate(
//           angle: angle,
//           child: Stack(
//             children: [
//               ProfileCard(profile: widget.profile),
//               ValueListenableBuilder(
//                 valueListenable: widget.swipeNotifier,
//                 builder: (context, swipe, _) {
//                   if (swipe != Swipe.none) {
//                     return swipe == Swipe.right
//                         ? Positioned(
//                             top: 40,
//                             left: 20,
//                             child: Transform.rotate(
//                               angle: 12,
//                               child: TagWidget(
//                                 text: 'LIKE',
//                                 color: Colors.green[400]!,
//                               ),
//                             ),
//                           )
//                         : Positioned(
//                             top: 50,
//                             right: 24,
//                             child: Transform.rotate(
//                               angle: -12,
//                               child: TagWidget(
//                                 text: 'DISLIKE',
//                                 color: Colors.red[400]!,
//                               ),
//                             ),
//                           );
//                   }
//                   return const SizedBox.shrink();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:ofwhich_v2/domain/user_service/model/user_object.dart';

// import '../../../../application/home_view_model/home_view_model.dart';
// import '../constants/swipe_enum.dart';
// import 'profile_card.dart';
// import 'tag_widget.dart';

// class DragWidget extends StatefulWidget {
//   const DragWidget({
//     Key? key,
//     required this.profile,
//     required this.index,
//     required this.swipeNotifier,
//     required this.homeViewModel,
//     this.isLastCard = false,
//   }) : super(key: key);

//   final UserModel profile;
//   final int index;
//   final ValueNotifier<Swipe> swipeNotifier;
//   final bool isLastCard;
//   final HomeViewModel homeViewModel;

//   @override
//   State<DragWidget> createState() => _DragWidgetState();
// }

// class _DragWidgetState extends State<DragWidget>
//     with SingleTickerProviderStateMixin {
//   Offset position = Offset.zero; // Track position of the draggable
//   double angle = 0.0; // Rotation angle for visual feedback
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _onPanUpdate(DragUpdateDetails details) {
//     setState(() {
//       position += details.delta;
//       angle = position.dx / MediaQuery.of(context).size.width * 0.1;
//     });
//   }

//   void _onPanEnd(DragEndDetails details) {
//     if (position.dx > 100) {
//       widget.swipeNotifier.value = Swipe.right;
//       widget.homeViewModel.likeProfile(userId: widget.profile.id!.toString());
//       _controller.forward(); // Start ani
//     } else if (position.dx < -100) {
//       widget.swipeNotifier.value = Swipe.left;
//       _controller.forward();
//     } else {
//       resetPosition();
//     }

//     // Add a delay before resetting swipe state
//     Future.delayed(const Duration(milliseconds: 300), resetPosition);
//   }

//   void resetPosition() {
//     setState(() {
//       position = Offset.zero;
//       angle = 0.0;
//       widget.swipeNotifier.value = Swipe.none;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onPanUpdate: _onPanUpdate,
//       onPanEnd: _onPanEnd,
//       child: Transform.translate(
//         offset: position,
//         child: Transform.rotate(
//           angle: angle,
//           child: Stack(
//             children: [
//               ProfileCard(profile: widget.profile),
//               ValueListenableBuilder(
//                 valueListenable: widget.swipeNotifier,
//                 builder: (context, swipe, _) {
//                   if (swipe != Swipe.none && widget.isLastCard) {
//                     return swipe == Swipe.right
//                         ? Positioned(
//                             top: 40,
//                             left: 20,
//                             child: Transform.rotate(
//                               angle: 12,
//                               child: TagWidget(
//                                 text: 'LIKE',
//                                 color: Colors.green[400]!,
//                               ),
//                             ),
//                           )
//                         : Positioned(
//                             top: 50,
//                             right: 24,
//                             child: Transform.rotate(
//                               angle: -12,
//                               child: TagWidget(
//                                 text: 'DISLIKE',
//                                 color: Colors.red[400]!,
//                               ),
//                             ),
//                           );
//                   }
//                   return const SizedBox.shrink();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../../application/home_view_model/home_view_model.dart';
import '../../../../domain/user_service/model/user_object.dart';
import '../../../../injectable.dart';
import '../../../routes/app_router.dart';
import '../../../routes/app_router.gr.dart';
import '../constants/swipe_enum.dart';
import 'profile_card.dart';
import 'tag_widget.dart';

class DragWidget extends StatelessWidget {
  const DragWidget({
    Key? key,
    required this.profile,
    required this.isLastCard,
    required this.position,
    required this.angle,
    required this.swipeNotifier,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.currentIndex,
    required this.selectedProfileCallback,
  }) : super(key: key);

  final UserModel profile;
  final bool isLastCard;
  final Offset position;
  final double angle;
  final ValueNotifier<Swipe> swipeNotifier;
  final Function(DragUpdateDetails) onPanUpdate;
  final VoidCallback onPanEnd;
  final int currentIndex;
  final VoidCallback selectedProfileCallback;
  // final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: onPanUpdate,
      onPanEnd: (_) => onPanEnd(),
      child: Transform.translate(
        offset: position,
        child: Transform.rotate(
          angle: angle,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  getIt<AppRouter>().push(SelectedProfileRoute(
                      profile: profile,
                      currentIndex: currentIndex,
                      swipeNotifier: swipeNotifier,
                      viewModel: getIt<HomeViewModel>(),
                      selectedProfileCallBack: selectedProfileCallback));
                },
                child: ProfileCard(
                  profile: profile,
                  currentIndex: currentIndex,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: swipeNotifier,
                builder: (context, swipe, _) {
                  if (swipe != Swipe.none && isLastCard) {
                    return swipe == Swipe.right
                        ? Positioned(
                            top: 40,
                            left: 20,
                            child: Transform.rotate(
                              angle: 12,
                              child: TagWidget(
                                text: 'LIKE',
                                color: Colors.green[400]!,
                              ),
                            ),
                          )
                        : Positioned(
                            top: 50,
                            right: 24,
                            child: Transform.rotate(
                              angle: -12,
                              child: TagWidget(
                                text: 'DISLIKE',
                                color: Colors.red[400]!,
                              ),
                            ),
                          );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
