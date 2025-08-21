// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ofwhich_v2/domain/user_service/model/address.dart';
// import 'package:flutter/widgets.dart';

import 'picture_model.dart';

class UserModel {
  int? id;
  String? full_name;
  String? username;
  String? email;
  String? gender;
  String? dob;
  int? must_change_password;
  String? phone;
  String? photo;
  String? preference;
  String? email_verified_at;
  List<String>? interests;
  String? relationship_status;
  List<PictureModel>? pictures;
  String? user_type;
  String? sexual_orientation;
  String? exercise;
  String? bio;
  String? job_title;
  String? employer;
  dynamic height;
  dynamic weight;
  String? education_level;
  dynamic no_of_kids;
  String? drinks;
  String? smokes;
  String? pets;
  String? religion;
  String? value;
  List<String>? languages;
  dynamic wallet_balance;
  final int is_subscribed;
  bool isMatched;
  Address? address;
  UserModel(
      {this.id,
      this.full_name,
      this.username,
      this.email,
      this.gender,
      this.dob,
      this.must_change_password,
      this.phone,
      this.photo,
      this.preference,
      this.email_verified_at,
      this.interests,
      this.relationship_status,
      this.pictures,
      this.user_type,
      this.sexual_orientation,
      this.exercise,
      this.bio,
      this.job_title,
      this.employer,
      this.height,
      this.weight,
      this.education_level,
      this.no_of_kids,
      this.drinks,
      this.smokes,
      this.pets,
      this.religion,
      this.value,
      this.languages,
      this.wallet_balance,
      this.isMatched = true,
      this.address,
      this.is_subscribed = 0});

  UserModel copyWith(
      {ValueGetter<int?>? id,
      ValueGetter<String?>? full_name,
      ValueGetter<String?>? username,
      ValueGetter<String?>? email,
      ValueGetter<String?>? gender,
      ValueGetter<String?>? dob,
      ValueGetter<int?>? must_change_password,
      ValueGetter<String?>? phone,
      ValueGetter<String?>? photo,
      ValueGetter<String?>? preference,
      ValueGetter<String?>? email_verified_at,
      ValueGetter<List<String>?>? interests,
      ValueGetter<String?>? relationship_status,
      ValueGetter<List<PictureModel>?>? pictures,
      ValueGetter<String?>? user_type,
      ValueGetter<String?>? sexual_orientation,
      ValueGetter<String?>? exercise,
      ValueGetter<String?>? bio,
      ValueGetter<String?>? job_title,
      ValueGetter<String?>? employer,
      ValueGetter<dynamic>? height,
      ValueGetter<dynamic>? weight,
      ValueGetter<String?>? education_level,
      ValueGetter<dynamic>? no_of_kids,
      ValueGetter<String?>? drinks,
      ValueGetter<String?>? smokes,
      ValueGetter<String?>? pets,
      ValueGetter<String?>? religion,
      ValueGetter<String?>? value,
      ValueGetter<Address>? address,
      // ValueGetter<String?>? languages,
      ValueGetter<dynamic>? wallet_balance,
      ValueGetter<int>? is_subscribed,
      ValueGetter<List<String>>? languages}) {
    return UserModel(
        id: id != null ? id() : this.id,
        full_name: full_name != null ? full_name() : this.full_name,
        username: username != null ? username() : this.username,
        email: email != null ? email() : this.email,
        gender: gender != null ? gender() : this.gender,
        dob: dob != null ? dob() : this.dob,
        must_change_password: must_change_password != null
            ? must_change_password()
            : this.must_change_password,
        phone: phone != null ? phone() : this.phone,
        photo: photo != null ? photo() : this.photo,
        preference: preference != null ? preference() : this.preference,
        email_verified_at: email_verified_at != null
            ? email_verified_at()
            : this.email_verified_at,
        interests: interests != null ? interests() : this.interests,
        relationship_status: relationship_status != null
            ? relationship_status()
            : this.relationship_status,
        pictures: pictures != null ? pictures() : this.pictures,
        user_type: user_type != null ? user_type() : this.user_type,
        sexual_orientation: sexual_orientation != null
            ? sexual_orientation()
            : this.sexual_orientation,
        exercise: exercise != null ? exercise() : this.exercise,
        bio: bio != null ? bio() : this.bio,
        job_title: job_title != null ? job_title() : this.job_title,
        employer: employer != null ? employer() : this.employer,
        height: height != null ? height() : this.height,
        weight: weight != null ? weight() : this.weight,
        education_level:
            education_level != null ? education_level() : this.education_level,
        no_of_kids: no_of_kids != null ? no_of_kids() : this.no_of_kids,
        drinks: drinks != null ? drinks() : this.drinks,
        smokes: smokes != null ? smokes() : this.smokes,
        pets: pets != null ? pets() : this.pets,
        religion: religion != null ? religion() : this.religion,
        value: value != null ? value() : this.value,
        languages: languages != null ? languages() : this.languages,
        wallet_balance:
            wallet_balance != null ? wallet_balance() : this.wallet_balance,
        is_subscribed:
            is_subscribed != null ? is_subscribed() : this.is_subscribed,
        address: address != null ? address() : this.address);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': full_name,
      'username': username,
      'email': email,
      'gender': gender,
      'dob': dob,
      'must_change_password': must_change_password,
      'phone': phone,
      'photo': photo,
      'preference': preference,
      'email_verified_at': email_verified_at,
      'interests': interests,
      'relationship_status': relationship_status,
      'pictures': pictures?.map((x) => x.toMap()).toList(),
      "address": address?.toMap(),
      'user_type': user_type,
      'sexual_orientation': sexual_orientation,
      'exercise': exercise,
      'bio': bio,
      'job_title': job_title,
      'employer': employer,
      'height': height,
      'weight': weight,
      'education_level': education_level,
      'no_of_kids': no_of_kids,
      'drinks': drinks,
      'smokes': smokes,
      'pets': pets,
      'religion': religion,
      'value': value,
      'languages': languages,
      'wallet_balance': wallet_balance,
      'is_subscribed': is_subscribed
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id']?.toInt(),
        full_name: map['full_name'],
        username: map['username'],
        email: map['email'],
        gender: map['gender'],
        dob: map['dob'],
        must_change_password: map['must_change_password']?.toInt(),
        phone: map['phone'],
        photo: map['photo'],
        preference: map['preference'],
        email_verified_at: map['email_verified_at'],
        interests:
            map["interests"] != null ? List<String>.from(map['interests']) : [],
        relationship_status: map['relationship_status'],
        pictures: map['pictures'] != null
            ? List<PictureModel>.from(
                map['pictures']?.map((x) => PictureModel.fromMap(x)))
            : null,
        user_type: map['user_type'],
        sexual_orientation: map['sexual_orientation'],
        exercise: map['exercise'],
        bio: map['bio'],
        job_title: map['job_title'],
        employer: map['employer'],
        height: map['height'],
        weight: map['weight'],
        education_level: map['education_level'],
        no_of_kids: map['no_of_kids']?.toInt(),
        drinks: map['drinks'],
        smokes: map['smokes'],
        pets: map['pets'],
        address:
            map['address'] != null ? Address.fromMap(map['address']) : null,
        religion: map['religion'],
        value: map['value'],
        languages:
            map['languages'] != null ? List<String>.from(map['languages']) : [],
        wallet_balance: map['wallet_balance'],
        is_subscribed: map['is_subscribed'] ?? 0);
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, full_name: $full_name, username: $username, email: $email, gender: $gender, dob: $dob, must_change_password: $must_change_password, phone: $phone, photo: $photo, preference: $preference, email_verified_at: $email_verified_at, interests: $interests, relationship_status: $relationship_status, pictures: $pictures, user_type: $user_type, sexual_orientation: $sexual_orientation, exercise: $exercise, bio: $bio, job_title: $job_title, employer: $employer, height: $height, weight: $weight, education_level: $education_level, no_of_kids: $no_of_kids, drinks: $drinks, smokes: $smokes, pets: $pets, religion: $religion, value: $value, languages: $languages, wallet_balance: $wallet_balance, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.full_name == full_name &&
        other.username == username &&
        other.email == email &&
        other.gender == gender &&
        other.dob == dob &&
        other.must_change_password == must_change_password &&
        other.phone == phone &&
        other.photo == photo &&
        other.preference == preference &&
        other.email_verified_at == email_verified_at &&
        listEquals(other.interests, interests) &&
        other.relationship_status == relationship_status &&
        listEquals(other.pictures, pictures) &&
        other.user_type == user_type &&
        other.sexual_orientation == sexual_orientation &&
        other.exercise == exercise &&
        other.bio == bio &&
        other.job_title == job_title &&
        other.employer == employer &&
        other.height == height &&
        other.weight == weight &&
        other.education_level == education_level &&
        other.no_of_kids == no_of_kids &&
        other.drinks == drinks &&
        other.smokes == smokes &&
        other.pets == pets &&
        other.religion == religion &&
        other.value == value &&
        other.languages == languages &&
        other.wallet_balance == wallet_balance &&
        other.is_subscribed == is_subscribed;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        full_name.hashCode ^
        username.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        dob.hashCode ^
        must_change_password.hashCode ^
        phone.hashCode ^
        photo.hashCode ^
        preference.hashCode ^
        email_verified_at.hashCode ^
        interests.hashCode ^
        relationship_status.hashCode ^
        pictures.hashCode ^
        user_type.hashCode ^
        sexual_orientation.hashCode ^
        exercise.hashCode ^
        bio.hashCode ^
        job_title.hashCode ^
        employer.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        education_level.hashCode ^
        no_of_kids.hashCode ^
        drinks.hashCode ^
        smokes.hashCode ^
        pets.hashCode ^
        religion.hashCode ^
        value.hashCode ^
        languages.hashCode ^
        wallet_balance.hashCode ^
        is_subscribed.hashCode;
  }
}
