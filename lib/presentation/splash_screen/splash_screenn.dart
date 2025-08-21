import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/splash_screen/splash_view_model.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:stacked/stacked.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../general_widgets/app_back_button.dart';
// import 'package:ofwhich/presentation/general_widgets/app_back_button.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      onViewModelReady: (v) {
        Timer(const Duration(seconds: 3), () {
          v.navigate();
        });
      },
      viewModelBuilder: () => getIt<SplashViewModel>(),
      builder: (context, model, child) =>Container(
  width: double.infinity,
  height: double.infinity,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Theme.of(context).primaryColor, 
        const Color(0xFF4D5BD5), 
      ],
    ),
  ),
  child: Stack(
    children: [
    
      Positioned.fill(
        child: Opacity(
          opacity: 1, 
            child: Image.asset(
            'assets/images/pngs/background_watermark.png',
            fit: BoxFit.contain, 
            alignment: Alignment.center, 
          ),
        ),
      ),

      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/pngs/logo_white.png',
              width: 239.w,
              height: 39.h,
            ),
          ],
        ),
      ),
    ],
  ),
)

    );
  }
}
