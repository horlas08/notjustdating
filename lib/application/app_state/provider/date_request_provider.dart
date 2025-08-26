import 'package:flutter/foundation.dart';

import '../../../domain/user_service/model/date_model.dart';
import '../../../domain/user_service/model/date_request_model.dart';

class DateRequestProvider extends ChangeNotifier {
  DateRequestModel _request = DateRequestModel(
    request_initiator_type: "",
    budget: "",
    payment_method: "",
    locations: [],
    availability_options: [],
  );

  DateRequestModel get request => _request;

  // --- Setters for each field ---
  void setInitiatorType(String value) {
    _request = _request.copyWith(request_initiator_type: value);
    notifyListeners();
  }

  void setBudget(String value) {
    _request = _request.copyWith(budget: value);
    notifyListeners();
  }

  void setPaymentMethod(String value) {
    _request = _request.copyWith(payment_method: value);
    notifyListeners();
  }

  void setLocations(List<num> value) {
    _request = _request.copyWith(locations: value);
    notifyListeners();
  }

  void setAvailabilityOptions(List<DateModel> value) {
    _request = _request.copyWith(availability_options: value);
    notifyListeners();
  }

  Future<void> submit() async {
    debugPrint("Submitting: ${_request.toJson()}");
    // send _request.toMap() or .toJson() to backend
  }
}
