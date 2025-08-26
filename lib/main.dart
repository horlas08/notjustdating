import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ofwhich_v2/application/app_state/provider/date_request_provider.dart';
import 'package:ofwhich_v2/application/chat_view_model/chat_view_model.dart';
import 'package:ofwhich_v2/application/home_view_model/home_view_model.dart';
import 'package:ofwhich_v2/application/profile/profile_view_model.dart';
import 'package:ofwhich_v2/presentation/core/firebase/firebase_api.dart';
// import 'package:ofwhich_v2/presentation/test_pages/task/data/task_model.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:ofwhich_v2/presentation/home/user/model/profile_model.dart';
// import 'package:path/path.dart';
import 'package:provider/provider.dart';

// import 'package:ofwhich_v2/lib/injectable.dart';

// import 'application/group_view_model/group_view_model.dart';
import 'application/transaction/transaction_view_model.dart';
import 'firebase_options.dart';
import 'injectable.dart';
import 'presentation/core/app_widget.dart';
// import 'presentation/home/user/constants/constants.dart';

void main() async {
  configureDependencies();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();

  await dotenv.load(fileName: ".env");

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => getIt<HomeViewModel>(),
      ),
      ChangeNotifierProvider(create: (context) => getIt<ProfileViewModel>()),
      ChangeNotifierProvider(create: (context) => getIt<ChatViewModel>()),
      ChangeNotifierProvider(
        create: (context) => getIt<TransactionViewModel>(),
      ),

      ///provider is a state management there i dont think it need a service locator
      ChangeNotifierProvider(
        create: (context) => DateRequestProvider(),
      )
    ],
    child: MyApp(),
  ));
}
