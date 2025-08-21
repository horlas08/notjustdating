import 'package:geocoding/geocoding.dart';

import 'package:dartz/dartz.dart';

import '../core/failure/app_failure.dart';

abstract class ILocationService {
  Future<Either<AppFailure, Location>> getCoordinatesFromAddress(
      {required String address});
}
