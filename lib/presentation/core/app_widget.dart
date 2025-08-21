import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ofwhich/injectable.dart';

import '../../injectable.dart';
import '../routes/app_router.dart';
// import '../test_pages/auth/pages/sign_up.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  final _appRouter = getIt<AppRouter>();
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      getIt<GlobalKey<ScaffoldMessengerState>>();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      child: MaterialApp.router(
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        // key: getIt<DialogService>().dialogNavigatorKey,
        title: 'OfWhich',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFFEC5873).withOpacity(0.5)),
            useMaterial3: true,
            primaryColor: const Color(0xFFEC5873)),
        debugShowCheckedModeBanner: false,

        routerConfig: _appRouter.config(),
      ),
    );
  }
}
