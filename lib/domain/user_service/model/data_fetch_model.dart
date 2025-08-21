class DateFetchModel {
  int? id;
  Requester? requester;
  Requested? requested;
  String? budget;
  List<String>? requesterLocations;
  List<String>? requestedLocations;
  // List<RequesterAvailabilityOptions>? requesterAvailabilityOptions;
  // List<RequestedAvailabilityOptions>? requestedAvailabilityOptions;
  String? status;
  String? requesterPaymentStatus;
  String? requestedPaymentStatus;
  String? requesterPaymentReference;
  String? requestedPaymentReference;
  String? createdAt;
  String? updatedAt;

  DateFetchModel(
      {this.id,
      this.requester,
      this.requested,
      this.budget,
      this.requesterLocations,
      this.requestedLocations,
      // this.requesterAvailabilityOptions,
      // this.requestedAvailabilityOptions,
      this.status,
      this.requesterPaymentStatus,
      this.requestedPaymentStatus,
      this.requesterPaymentReference,
      this.requestedPaymentReference,
      this.createdAt,
      this.updatedAt});

  DateFetchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requester = json['requester'] != null
        ? Requester.fromJson(json['requester'])
        : null;
    requested = json['requested'] != null
        ? Requested.fromJson(json['requested'])
        : null;
    budget = json['budget'];
    // requesterLocations = json['requester_locations'].cast<String>();
    // requestedLocations = json['requested_locations'].cast<String>();
    // if (json['requester_availability_options'] != null) {
    //   requesterAvailabilityOptions = <RequesterAvailabilityOptions>[];
    //   json['requester_availability_options'].forEach((v) {
    //     requesterAvailabilityOptions!
    //         .add(new RequesterAvailabilityOptions.fromJson(v));
    //   });
    // }
    // if (json['requested_availability_options'] != null) {
    //   requestedAvailabilityOptions = <RequestedAvailabilityOptions>[];
    //   json['requested_availability_options'].forEach((v) {
    //     requestedAvailabilityOptions!
    //         .add(new RequestedAvailabilityOptions.fromJson(v));
    //   });
    // }
    status = json['status'];
    requesterPaymentStatus = json['requester_payment_status'];
    requestedPaymentStatus = json['requested_payment_status'];
    requesterPaymentReference = json['requester_payment_reference'];
    requestedPaymentReference = json['requested_payment_reference'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    if (requester != null) {
      data['requester'] = requester!.toJson();
    }
    if (requested != null) {
      data['requested'] = requested!.toJson();
    }
    data['budget'] = budget;
    data['requester_locations'] = requesterLocations;
    data['requested_locations'] = requestedLocations;
    // if (this.requesterAvailabilityOptions != null) {
    //   data['requester_availability_options'] =
    //       this.requesterAvailabilityOptions!.map((v) => v.toJson()).toList();
    // }
    // if (this.requestedAvailabilityOptions != null) {
    //   data['requested_availability_options'] =
    //       this.requestedAvailabilityOptions!.map((v) => v.toJson()).toList();
    // }
    data['status'] = status;
    data['requester_payment_status'] = requesterPaymentStatus;
    data['requested_payment_status'] = requestedPaymentStatus;
    data['requester_payment_reference'] = requesterPaymentReference;
    data['requested_payment_reference'] = requestedPaymentReference;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Requester {
  int? id;
  String? userType;
  String? fullName;
  String? username;
  String? email;
  String? gender;
  String? dob;
  String? phone;
  String? photo;
  String? preference;
  String? relationshipStatus;
  int? mustChangePassword;
  String? emailVerifiedAt;
  String? bio;
  String? jobTitle;
  String? employer;
  num? height;
  num? weight;
  String? sexualOrientation;
  String? exercise;
  String? educationLevel;
  int? noOfKids;
  String? drinks;
  String? smokes;
  String? pets;
  String? religion;
  String? value;
  String? languages;
  // List<dynamic>? interests;
  String? pictures;
  int? walletBalance;
  Address? address;

  Requester(
      {this.id,
      this.userType,
      this.fullName,
      this.username,
      this.email,
      this.gender,
      this.dob,
      this.phone,
      this.photo,
      this.preference,
      this.relationshipStatus,
      this.mustChangePassword,
      this.emailVerifiedAt,
      this.bio,
      this.jobTitle,
      this.employer,
      this.height,
      this.weight,
      this.sexualOrientation,
      this.exercise,
      this.educationLevel,
      this.noOfKids,
      this.drinks,
      this.smokes,
      this.pets,
      this.religion,
      this.value,
      this.languages,
      // this.interests,
      this.pictures,
      this.walletBalance,
      this.address});

  Requester.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    fullName = json['full_name'];
    username = json['username'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    phone = json['phone'];
    photo = json['photo'];
    preference = json['preference'];
    relationshipStatus = json['relationship_status'];
    mustChangePassword = json['must_change_password'];
    emailVerifiedAt = json['email_verified_at'];
    bio = json['bio'];
    jobTitle = json['job_title'];
    employer = json['employer'];
    height = json['height'];
    weight = json['weight'];
    sexualOrientation = json['sexual_orientation'];
    exercise = json['exercise'];
    educationLevel = json['education_level'];
    noOfKids = json['no_of_kids'];
    drinks = json['drinks'];
    smokes = json['smokes'];
    pets = json['pets'];
    religion = json['religion'];
    value = json['value'];
    languages = json['languages'];
    // if (json['interests'] != null) {
    //   interests = <Null>[];
    //   json['interests'].forEach((v) {
    //     interests!.add(new Null.fromJson(v));
    //   });
    // }
    pictures = json['pictures'];
    walletBalance = json['wallet_balance'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_type'] = userType;
    data['full_name'] = fullName;
    data['username'] = username;
    data['email'] = email;
    data['gender'] = gender;
    data['dob'] = dob;
    data['phone'] = phone;
    data['photo'] = photo;
    data['preference'] = preference;
    data['relationship_status'] = relationshipStatus;
    data['must_change_password'] = mustChangePassword;
    data['email_verified_at'] = emailVerifiedAt;
    data['bio'] = bio;
    data['job_title'] = jobTitle;
    data['employer'] = employer;
    data['height'] = height;
    data['weight'] = weight;
    data['sexual_orientation'] = sexualOrientation;
    data['exercise'] = exercise;
    data['education_level'] = educationLevel;
    data['no_of_kids'] = noOfKids;
    data['drinks'] = drinks;
    data['smokes'] = smokes;
    data['pets'] = pets;
    data['religion'] = religion;
    data['value'] = value;
    data['languages'] = languages;
    // if (this.interests != null) {
    //   data['interests'] = this.interests!.map((v) => v.toJson()).toList();
    // }
    data['pictures'] = pictures;
    data['wallet_balance'] = walletBalance;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}

class Address {
  String? address;
  String? latitude;
  String? longitude;

  Address({this.address, this.latitude, this.longitude});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class Requested {
  int? id;
  String? userType;
  String? fullName;
  String? username;
  String? email;
  String? gender;
  String? dob;
  String? phone;
  String? photo;
  String? preference;
  String? relationshipStatus;
  int? mustChangePassword;
  String? emailVerifiedAt;
  String? bio;
  String? jobTitle;
  String? employer;
  num? height;
  num? weight;
  String? sexualOrientation;
  String? exercise;
  String? educationLevel;
  int? noOfKids;
  String? drinks;
  String? smokes;
  String? pets;
  String? religion;
  String? value;
  String? languages;
  List<String>? interests;
  String? pictures;
  int? walletBalance;
  Address? address;

  Requested(
      {this.id,
      this.userType,
      this.fullName,
      this.username,
      this.email,
      this.gender,
      this.dob,
      this.phone,
      this.photo,
      this.preference,
      this.relationshipStatus,
      this.mustChangePassword,
      this.emailVerifiedAt,
      this.bio,
      this.jobTitle,
      this.employer,
      this.height,
      this.weight,
      this.sexualOrientation,
      this.exercise,
      this.educationLevel,
      this.noOfKids,
      this.drinks,
      this.smokes,
      this.pets,
      this.religion,
      this.value,
      this.languages,
      this.interests,
      this.pictures,
      this.walletBalance,
      this.address});

  Requested.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    fullName = json['full_name'];
    username = json['username'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    phone = json['phone'];
    photo = json['photo'];
    preference = json['preference'];
    relationshipStatus = json['relationship_status'];
    mustChangePassword = json['must_change_password'];
    emailVerifiedAt = json['email_verified_at'];
    bio = json['bio'];
    jobTitle = json['job_title'];
    employer = json['employer'];
    height = json['height'];
    weight = json['weight'];
    sexualOrientation = json['sexual_orientation'];
    exercise = json['exercise'];
    educationLevel = json['education_level'];
    noOfKids = json['no_of_kids'];
    drinks = json['drinks'];
    smokes = json['smokes'];
    pets = json['pets'];
    religion = json['religion'];
    value = json['value'];
    languages = json['languages'];
    // interests = json['interests'];
    pictures = json['pictures'];
    walletBalance = json['wallet_balance'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_type'] = userType;
    data['full_name'] = fullName;
    data['username'] = username;
    data['email'] = email;
    data['gender'] = gender;
    data['dob'] = dob;
    data['phone'] = phone;
    data['photo'] = photo;
    data['preference'] = preference;
    data['relationship_status'] = relationshipStatus;
    data['must_change_password'] = mustChangePassword;
    data['email_verified_at'] = emailVerifiedAt;
    data['bio'] = bio;
    data['job_title'] = jobTitle;
    data['employer'] = employer;
    data['height'] = height;
    data['weight'] = weight;
    data['sexual_orientation'] = sexualOrientation;
    data['exercise'] = exercise;
    data['education_level'] = educationLevel;
    data['no_of_kids'] = noOfKids;
    data['drinks'] = drinks;
    data['smokes'] = smokes;
    data['pets'] = pets;
    data['religion'] = religion;
    data['value'] = value;
    data['languages'] = languages;
    data['interests'] = interests;
    data['pictures'] = pictures;
    data['wallet_balance'] = walletBalance;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}

// class Address {
//   Null? address;
//   Null? latitude;
//   Null? longitude;

//   Address({this.address, this.latitude, this.longitude});

//   Address.fromJson(Map<String, dynamic> json) {
//     address = json['address'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['address'] = this.address;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     return data;
//   }
// }

class RequesterAvailabilityOptions {
  String? date;
  String? time;

  RequesterAvailabilityOptions({this.date, this.time});

  RequesterAvailabilityOptions.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}
