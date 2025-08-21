// import 'package:flutter/foundation.dart';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/home_view_model/home_view_model.dart';
import 'package:ofwhich_v2/application/profile/profile_view_model.dart';

import 'package:ofwhich_v2/domain/user_service/model/user_object.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
import 'package:provider/provider.dart';

import '../../routes/app_router.dart';

@RoutePage()
class MatchedScreen extends StatefulWidget {
  const MatchedScreen({
    Key? key,
    required this.user1,
  }) : super(key: key);
  final UserModel user1;

  @override
  State<MatchedScreen> createState() => _MatchedScreenState();
}

class _MatchedScreenState extends State<MatchedScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _heartController;
  late AnimationController _textController;

  late Animation<Offset> _leftCardAnimation;
  late Animation<Offset> _rightCardAnimation;
  late Animation<double> _heartScaleAnimation;
  late Animation<double> _textOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _heartController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Card slide animations
    _leftCardAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: const Offset(-0.25, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _rightCardAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: const Offset(0.25, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    // Heart animation
    _heartScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _heartController,
      curve: Curves.elasticOut,
    ));

    // Text animation
    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    ));

    _startAnimation();
  }

  @override
  void didChangeDependencies() {
    getIt<ProfileViewModel>().getUserSavedLocally();
    super.didChangeDependencies();
  }

  void _startAnimation() async {
    // Start cards sliding in
    _animationController.forward();

    // Wait a bit, then show heart
    await Future.delayed(const Duration(milliseconds: 800));
    _heartController.forward();

    // Show text
    await Future.delayed(const Duration(milliseconds: 200));
    _textController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _heartController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2(
      builder: (BuildContext context, HomeViewModel h, ProfileViewModel p,
              Widget? child) =>
          Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFF6B6B),
                Color(0xFFFF8E8E),
                Color(0xFFFFB3B3),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _textOpacityAnimation,
                        child: const Text(
                          "IT'S A MATCH!",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                        builder: (context, child) {
                          return Opacity(
                            opacity: _textOpacityAnimation.value,
                            child: child,
                          );
                        },
                      ),
                      const SizedBox(width: 48), // Balance for close button
                    ],
                  ),
                ),

                // Main content - Cards and Heart
                Expanded(
                  child: Stack(
                    children: [
                      // Floating hearts background
                      ...List.generate(
                          15, (index) => _buildFloatingHeart(index)),

                      // Main cards area
                      Center(
                        child: SizedBox(
                          height: 500,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Left user card
                              // AnimatedBuilder(
                              //   animation: _leftCardAnimation,
                              //   builder: (context, child) {
                              //     return SlideTransition(
                              //       position: _leftCardAnimation,
                              //       child: _buildUserCard(
                              //           p.user?.username ?? "N/A",
                              //           int.tryParse(p.user?.dob ?? "30") ?? 0,
                              //           p.user?.photo ?? "N/A"),
                              //     );
                              //   },
                              // ),
                              AnimatedBuilder(
                                animation: _leftCardAnimation,
                                builder: (context, child) {
                                  return SlideTransition(
                                    position: _leftCardAnimation,
                                    child: Transform.rotate(
                                      angle: -0.12, // Slight left slant
                                      child: Transform.translate(
                                        offset: const Offset(-20,
                                            20), // Push it slightly down and to the left
                                        child: _buildUserCard(
                                          p.user?.username ?? "N/A",
                                          int.tryParse(p.user?.dob ?? "30") ??
                                              0,
                                          p.user?.photo ?? "N/A",
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              AnimatedBuilder(
                                animation: _rightCardAnimation,
                                builder: (context, child) {
                                  return SlideTransition(
                                    position: _rightCardAnimation,
                                    child: Transform.rotate(
                                      angle: 0.12, // Slight right slant
                                      child: Transform.translate(
                                        offset: const Offset(20,
                                            20), // Push it slightly down and to the right
                                        child: _buildUserCard(
                                          widget.user1.full_name ?? "N/A",
                                          int.tryParse(
                                                  widget.user1.dob ?? "30") ??
                                              20,
                                          widget.user1.photo ?? "N/A",
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              // Right user card
                              // AnimatedBuilder(
                              //   animation: _rightCardAnimation,
                              //   builder: (context, child) {
                              //     return SlideTransition(
                              //       position: _rightCardAnimation,
                              //       child: _buildUserCard(
                              //         widget.user1.full_name ?? "N/A",
                              //         int.tryParse(widget.user1.dob ?? "30") ??
                              //             20,
                              //         widget.user1.photo ?? "N/A",
                              //       ),
                              //     );
                              //   },
                              // ),

                              // Heart in center
                              // AnimatedBuilder(
                              //   animation: _heartScaleAnimation,
                              //   builder: (context, child) {
                              //     return Transform.scale(
                              //       scale: _heartScaleAnimation.value,
                              //       child: Container(
                              //         width: 80,
                              //         height: 80,
                              //         decoration: BoxDecoration(
                              //           color: Colors.white,
                              //           shape: BoxShape.circle,
                              //           boxShadow: [
                              //             BoxShadow(
                              //               color:
                              //                   Colors.black.withOpacity(0.2),
                              //               blurRadius: 20,
                              //               spreadRadius: 5,
                              //             ),
                              //           ],
                              //         ),
                              //         child: const Icon(
                              //           Icons.favorite,
                              //           color: Color(0xFFFF6B6B),
                              //           size: 40,
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // ),

                              AnimatedBuilder(
                                animation: _heartScaleAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _heartScaleAnimation.value,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            blurRadius: 20,
                                            spreadRadius: 5,
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.favorite,
                                        color: Color(0xFFFF6B6B),
                                        size: 50,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom message
                // AnimatedBuilder(
                //   animation: _textOpacityAnimation,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 40),
                //     child: Text(
                //       "You and ${widget.user2Name} have liked each other",
                //       textAlign: TextAlign.center,
                //       style: const TextStyle(
                //         fontSize: 18,
                //         color: Colors.white,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ),
                //   builder: (context, child) {
                //     return Opacity(
                //       opacity: _textOpacityAnimation.value,
                //       child: child,
                //     );
                //   },
                // ),

                const SizedBox(height: 40),

                // Action buttons
                AnimatedBuilder(
                  animation: _textOpacityAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        // Send Message button
                        // SizedBox(
                        //   width: double.infinity,
                        //   height: 55,
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       // Handle send message
                        //       // Navigator.pu(context);
                        //       getIt<AppRouter>()
                        //           .replace( PlanADateRoute());
                        //     },
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: Colors.white,
                        //       foregroundColor: const Color(0xFFFF6B6B),
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(28),
                        //       ),
                        //       elevation: 3,
                        //     ),
                        //     child: const Text(
                        //       "PLAN A DATE",
                        //       style: TextStyle(
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.bold,
                        //         letterSpacing: 1,
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        const SizedBox(height: 15),

                        // Keep Swiping button
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: OutlinedButton(
                            onPressed: () => getIt<AppRouter>().pushAndPopUntil(
                                const BottomNavRoute(),
                                predicate: (val) => false),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(
                                  color: Colors.white, width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            child: const Text(
                              "KEEP SWIPING",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  builder: (context, child) {
                    return Opacity(
                      opacity: _textOpacityAnimation.value,
                      child: child,
                    );
                  },
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard(String name, int age, String imageUrl) {
    return Container(
      width: 300.w,
      height: 400.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // User image
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.shade300,
                        Colors.grey.shade400,
                      ],
                    ),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey.shade600,
                  ),
                );
              },
            ),

            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),

            // Name and age
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "$age years old",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingHeart(int index) {
    final random = (index * 456) % 100;
    final left = (random / 100) * MediaQuery.of(context).size.width;
    final size = 15.0 + (random % 10);
    final duration = 3000 + (random * 20);

    return Positioned(
      left: left,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: duration),
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(
              sin(value * 2 * 3.14159) * 30,
              -value * (MediaQuery.of(context).size.height + 100),
            ),
            child: Opacity(
              opacity: (1 - value) * 0.6,
              child: Icon(
                Icons.favorite,
                color: Colors.white.withOpacity(0.7),
                size: size,
              ),
            ),
          );
        },
        onEnd: () {
          // Restart animation
          if (mounted) {
            setState(() {});
          }
        },
      ),
    );
  }
}
