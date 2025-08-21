import 'index.dart';
// import 'package:altbank/domain/transaction/model/total_transaction_limit_model.dart';

class OfWhichValidator extends Validators {
  String? name(value) {
    return isEmpty(value) ?? limit(value, min: 4);
  }

  String? fullName(value) {
    return isEmptyFullName(value) ?? limit(value, min: 3);
  }

  String? middleName(value) {
    return isEmptymiddleName(value) ?? limit(value, min: 3);
  }

  String? gender(value) {
    return isEmptygender(value) ?? limit(value, min: 3);
  }

  String? lastName(value) {
    return isEmptyLastName(value) ?? limit(value, min: 3);
  }

  String? mobileNumber(value) {
    return numberValidator(value) ??
        limit(value, min: 11, max: 11) ??
        isEmptyMobileNumber(value);
  }

  String? optValidator(value) {
    return isEmpty(value) ?? numberValidator(value);
  }

  String? regNumber(value) {
    return numberValidator(value) ??
        limit(value, min: 2) ??
        isEmptyRegNumber(value);
  }

  String? userName(value) {
    return isEmptyUserName(value) ?? limit(value, min: 3);
  }

  String? occupation(value) {
    return isEmptyoccupation(value) ?? limit(value, min: 3);
  }

  String? streetname(value) {
    return isEmpty(value) ?? limit(value, min: 3);
  }

  String? email(value) {
    return isEmptyEmail(value) ?? isEmail(value);
  }

  String? otp(value) {
    return isEmpty(value) ?? isNumeric(value) ?? limit(value, min: 2);
  }

  String? amount(value) {
    return isEmpty(value) ?? isNumeric(value);
  }

  String? tenure(value) {
    return isEmpty(value) ?? isNumeric(value) ?? limit(value, min: 1, max: 31);
  }

  String? formattedAmount(val) {
    if (val.toString().isEmpty) {
      return 'Empty field';
    }
    if (RegExp("^[0-9,]*\$").hasMatch(val)) {
      return null;
    }
    if (RegExp(r"^([0-9]{1,3}(,[0-9]{3})*(\.[0-9]+)?|\.[0-9]+)$")
        .hasMatch(val)) {
      return null;
    }

    return "Invalid Amount";
  }

  String? checkAmountBalance(value, bool validAmount) {
    if (value.toString().isEmpty) {
      return 'Empty field';
    } else if (validAmount == false) {
      return "insufficient account balance";
    } else if (RegExp("^[0-9,]*\$").hasMatch(value)) {
      return null;
    } else if (RegExp(r"^([0-9]{1,3}(,[0-9]{3})*(\.[0-9]+)?|\.[0-9]+)$")
        .hasMatch(value)) {
      return null;
    } else {
      return "Invalid Amount";
    }
  }

  String? accountNNumber(value) {
    return isEmpty(value) ?? isNumeric(value) ?? limit(value, min: 10, max: 10);
  }

  String? password(value) {
    return isEmptyPassword(value) ?? isPasswordValid(value);
  }

  String? confirmPassword(
    value,
    confirmValue,
  ) {
    return isEmptyPassword(value) ??
        confirm(
          value,
          confirmValue,
        );
  }

  String? transactionPin(value) {
    return isEmpty(value) ?? isNumeric(value) ?? limit(value, min: 4, max: 4);
  }

  String? otpfield(value) {
    return isEmpty(value) ?? isNumeric(value) ?? limit(value, min: 6, max: 6);
  }

  String? confirmTransactionPin(
    value,
    confirmValue,
  ) {
    return isEmpty(value) ??
        confirmPin(
          value,
          confirmValue,
        );
  }

  String? claimReferralField(value) {
    return isEmpty(value) ?? isNumeric(value);
  }

  String? dobValidator(value) {
    return isEmpty(value);
  }
}
