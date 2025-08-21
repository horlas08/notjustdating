import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InjectablesModule {
  @LazySingleton()
  GlobalKey<ScaffoldMessengerState> get globalKey =>
      GlobalKey<ScaffoldMessengerState>();
}
