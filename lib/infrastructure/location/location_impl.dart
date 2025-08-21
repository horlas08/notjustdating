import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:injectable/injectable.dart';
// import 'package:geocoding_platform_interface/src/models/location.dart';
import 'package:ofwhich_v2/domain/core/failure/app_failure.dart';
import 'package:ofwhich_v2/domain/location/location_service.dart';

@LazySingleton(as: ILocationService)
class LocationServiceImpl implements ILocationService {
  @override
  Future<Either<AppFailure, Location>> getCoordinatesFromAddress(
      {required String address}) async {
    try {
      if (address.isEmpty) {
        return left(const AppFailure.badRequest("Address is enmpty"));
      } else {
        List<Location> locations = await locationFromAddress(address);
        final location = locations.first;
        return right(location);
      }
    } catch (e) {
      return left(AppFailure.badRequest(e.toString()));
    }
  }
}
