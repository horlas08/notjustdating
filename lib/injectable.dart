import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:ofwhich_v2/injectable.config.dart';
// import 'package:ofwhich_v2/lib/injectable.config.dart';
// import 'package:ofwhich/injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => getIt.init();
