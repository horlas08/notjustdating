// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppFailure {
  String? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) badRequest,
    required TResult Function(String? message) connectionTimeOut,
    required TResult Function(String? message) unAuthorized,
    required TResult Function(String? message) socketException,
    required TResult Function(String? message) notFound,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? badRequest,
    TResult? Function(String? message)? connectionTimeOut,
    TResult? Function(String? message)? unAuthorized,
    TResult? Function(String? message)? socketException,
    TResult? Function(String? message)? notFound,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? badRequest,
    TResult Function(String? message)? connectionTimeOut,
    TResult Function(String? message)? unAuthorized,
    TResult Function(String? message)? socketException,
    TResult Function(String? message)? notFound,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) serverError,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(ConnectionTimeOut value) connectionTimeOut,
    required TResult Function(Unauthorized value) unAuthorized,
    required TResult Function(AppSocketException value) socketException,
    required TResult Function(NotFound value) notFound,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? serverError,
    TResult? Function(BadRequest value)? badRequest,
    TResult? Function(ConnectionTimeOut value)? connectionTimeOut,
    TResult? Function(Unauthorized value)? unAuthorized,
    TResult? Function(AppSocketException value)? socketException,
    TResult? Function(NotFound value)? notFound,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? serverError,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(ConnectionTimeOut value)? connectionTimeOut,
    TResult Function(Unauthorized value)? unAuthorized,
    TResult Function(AppSocketException value)? socketException,
    TResult Function(NotFound value)? notFound,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppFailureCopyWith<AppFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppFailureCopyWith<$Res> {
  factory $AppFailureCopyWith(
          AppFailure value, $Res Function(AppFailure) then) =
      _$AppFailureCopyWithImpl<$Res, AppFailure>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$AppFailureCopyWithImpl<$Res, $Val extends AppFailure>
    implements $AppFailureCopyWith<$Res> {
  _$AppFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServerErrorImplCopyWith<$Res>
    implements $AppFailureCopyWith<$Res> {
  factory _$$ServerErrorImplCopyWith(
          _$ServerErrorImpl value, $Res Function(_$ServerErrorImpl) then) =
      __$$ServerErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$ServerErrorImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$ServerErrorImpl>
    implements _$$ServerErrorImplCopyWith<$Res> {
  __$$ServerErrorImplCopyWithImpl(
      _$ServerErrorImpl _value, $Res Function(_$ServerErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$ServerErrorImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ServerErrorImpl implements ServerError {
  const _$ServerErrorImpl(this.message);

  @override
  final String? message;

  @override
  String toString() {
    return 'AppFailure.serverError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerErrorImplCopyWith<_$ServerErrorImpl> get copyWith =>
      __$$ServerErrorImplCopyWithImpl<_$ServerErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) badRequest,
    required TResult Function(String? message) connectionTimeOut,
    required TResult Function(String? message) unAuthorized,
    required TResult Function(String? message) socketException,
    required TResult Function(String? message) notFound,
  }) {
    return serverError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? badRequest,
    TResult? Function(String? message)? connectionTimeOut,
    TResult? Function(String? message)? unAuthorized,
    TResult? Function(String? message)? socketException,
    TResult? Function(String? message)? notFound,
  }) {
    return serverError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? badRequest,
    TResult Function(String? message)? connectionTimeOut,
    TResult Function(String? message)? unAuthorized,
    TResult Function(String? message)? socketException,
    TResult Function(String? message)? notFound,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) serverError,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(ConnectionTimeOut value) connectionTimeOut,
    required TResult Function(Unauthorized value) unAuthorized,
    required TResult Function(AppSocketException value) socketException,
    required TResult Function(NotFound value) notFound,
  }) {
    return serverError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? serverError,
    TResult? Function(BadRequest value)? badRequest,
    TResult? Function(ConnectionTimeOut value)? connectionTimeOut,
    TResult? Function(Unauthorized value)? unAuthorized,
    TResult? Function(AppSocketException value)? socketException,
    TResult? Function(NotFound value)? notFound,
  }) {
    return serverError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? serverError,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(ConnectionTimeOut value)? connectionTimeOut,
    TResult Function(Unauthorized value)? unAuthorized,
    TResult Function(AppSocketException value)? socketException,
    TResult Function(NotFound value)? notFound,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(this);
    }
    return orElse();
  }
}

abstract class ServerError implements AppFailure {
  const factory ServerError(final String? message) = _$ServerErrorImpl;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$ServerErrorImplCopyWith<_$ServerErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BadRequestImplCopyWith<$Res>
    implements $AppFailureCopyWith<$Res> {
  factory _$$BadRequestImplCopyWith(
          _$BadRequestImpl value, $Res Function(_$BadRequestImpl) then) =
      __$$BadRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$BadRequestImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$BadRequestImpl>
    implements _$$BadRequestImplCopyWith<$Res> {
  __$$BadRequestImplCopyWithImpl(
      _$BadRequestImpl _value, $Res Function(_$BadRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$BadRequestImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$BadRequestImpl implements BadRequest {
  const _$BadRequestImpl(this.message);

  @override
  final String? message;

  @override
  String toString() {
    return 'AppFailure.badRequest(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadRequestImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BadRequestImplCopyWith<_$BadRequestImpl> get copyWith =>
      __$$BadRequestImplCopyWithImpl<_$BadRequestImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) badRequest,
    required TResult Function(String? message) connectionTimeOut,
    required TResult Function(String? message) unAuthorized,
    required TResult Function(String? message) socketException,
    required TResult Function(String? message) notFound,
  }) {
    return badRequest(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? badRequest,
    TResult? Function(String? message)? connectionTimeOut,
    TResult? Function(String? message)? unAuthorized,
    TResult? Function(String? message)? socketException,
    TResult? Function(String? message)? notFound,
  }) {
    return badRequest?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? badRequest,
    TResult Function(String? message)? connectionTimeOut,
    TResult Function(String? message)? unAuthorized,
    TResult Function(String? message)? socketException,
    TResult Function(String? message)? notFound,
    required TResult orElse(),
  }) {
    if (badRequest != null) {
      return badRequest(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) serverError,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(ConnectionTimeOut value) connectionTimeOut,
    required TResult Function(Unauthorized value) unAuthorized,
    required TResult Function(AppSocketException value) socketException,
    required TResult Function(NotFound value) notFound,
  }) {
    return badRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? serverError,
    TResult? Function(BadRequest value)? badRequest,
    TResult? Function(ConnectionTimeOut value)? connectionTimeOut,
    TResult? Function(Unauthorized value)? unAuthorized,
    TResult? Function(AppSocketException value)? socketException,
    TResult? Function(NotFound value)? notFound,
  }) {
    return badRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? serverError,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(ConnectionTimeOut value)? connectionTimeOut,
    TResult Function(Unauthorized value)? unAuthorized,
    TResult Function(AppSocketException value)? socketException,
    TResult Function(NotFound value)? notFound,
    required TResult orElse(),
  }) {
    if (badRequest != null) {
      return badRequest(this);
    }
    return orElse();
  }
}

abstract class BadRequest implements AppFailure {
  const factory BadRequest(final String? message) = _$BadRequestImpl;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$BadRequestImplCopyWith<_$BadRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionTimeOutImplCopyWith<$Res>
    implements $AppFailureCopyWith<$Res> {
  factory _$$ConnectionTimeOutImplCopyWith(_$ConnectionTimeOutImpl value,
          $Res Function(_$ConnectionTimeOutImpl) then) =
      __$$ConnectionTimeOutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$ConnectionTimeOutImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$ConnectionTimeOutImpl>
    implements _$$ConnectionTimeOutImplCopyWith<$Res> {
  __$$ConnectionTimeOutImplCopyWithImpl(_$ConnectionTimeOutImpl _value,
      $Res Function(_$ConnectionTimeOutImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$ConnectionTimeOutImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ConnectionTimeOutImpl implements ConnectionTimeOut {
  const _$ConnectionTimeOutImpl(this.message);

  @override
  final String? message;

  @override
  String toString() {
    return 'AppFailure.connectionTimeOut(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionTimeOutImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionTimeOutImplCopyWith<_$ConnectionTimeOutImpl> get copyWith =>
      __$$ConnectionTimeOutImplCopyWithImpl<_$ConnectionTimeOutImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) badRequest,
    required TResult Function(String? message) connectionTimeOut,
    required TResult Function(String? message) unAuthorized,
    required TResult Function(String? message) socketException,
    required TResult Function(String? message) notFound,
  }) {
    return connectionTimeOut(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? badRequest,
    TResult? Function(String? message)? connectionTimeOut,
    TResult? Function(String? message)? unAuthorized,
    TResult? Function(String? message)? socketException,
    TResult? Function(String? message)? notFound,
  }) {
    return connectionTimeOut?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? badRequest,
    TResult Function(String? message)? connectionTimeOut,
    TResult Function(String? message)? unAuthorized,
    TResult Function(String? message)? socketException,
    TResult Function(String? message)? notFound,
    required TResult orElse(),
  }) {
    if (connectionTimeOut != null) {
      return connectionTimeOut(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) serverError,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(ConnectionTimeOut value) connectionTimeOut,
    required TResult Function(Unauthorized value) unAuthorized,
    required TResult Function(AppSocketException value) socketException,
    required TResult Function(NotFound value) notFound,
  }) {
    return connectionTimeOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? serverError,
    TResult? Function(BadRequest value)? badRequest,
    TResult? Function(ConnectionTimeOut value)? connectionTimeOut,
    TResult? Function(Unauthorized value)? unAuthorized,
    TResult? Function(AppSocketException value)? socketException,
    TResult? Function(NotFound value)? notFound,
  }) {
    return connectionTimeOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? serverError,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(ConnectionTimeOut value)? connectionTimeOut,
    TResult Function(Unauthorized value)? unAuthorized,
    TResult Function(AppSocketException value)? socketException,
    TResult Function(NotFound value)? notFound,
    required TResult orElse(),
  }) {
    if (connectionTimeOut != null) {
      return connectionTimeOut(this);
    }
    return orElse();
  }
}

abstract class ConnectionTimeOut implements AppFailure {
  const factory ConnectionTimeOut(final String? message) =
      _$ConnectionTimeOutImpl;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$ConnectionTimeOutImplCopyWith<_$ConnectionTimeOutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnauthorizedImplCopyWith<$Res>
    implements $AppFailureCopyWith<$Res> {
  factory _$$UnauthorizedImplCopyWith(
          _$UnauthorizedImpl value, $Res Function(_$UnauthorizedImpl) then) =
      __$$UnauthorizedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$UnauthorizedImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$UnauthorizedImpl>
    implements _$$UnauthorizedImplCopyWith<$Res> {
  __$$UnauthorizedImplCopyWithImpl(
      _$UnauthorizedImpl _value, $Res Function(_$UnauthorizedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$UnauthorizedImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UnauthorizedImpl implements Unauthorized {
  const _$UnauthorizedImpl(this.message);

  @override
  final String? message;

  @override
  String toString() {
    return 'AppFailure.unAuthorized(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnauthorizedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnauthorizedImplCopyWith<_$UnauthorizedImpl> get copyWith =>
      __$$UnauthorizedImplCopyWithImpl<_$UnauthorizedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) badRequest,
    required TResult Function(String? message) connectionTimeOut,
    required TResult Function(String? message) unAuthorized,
    required TResult Function(String? message) socketException,
    required TResult Function(String? message) notFound,
  }) {
    return unAuthorized(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? badRequest,
    TResult? Function(String? message)? connectionTimeOut,
    TResult? Function(String? message)? unAuthorized,
    TResult? Function(String? message)? socketException,
    TResult? Function(String? message)? notFound,
  }) {
    return unAuthorized?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? badRequest,
    TResult Function(String? message)? connectionTimeOut,
    TResult Function(String? message)? unAuthorized,
    TResult Function(String? message)? socketException,
    TResult Function(String? message)? notFound,
    required TResult orElse(),
  }) {
    if (unAuthorized != null) {
      return unAuthorized(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) serverError,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(ConnectionTimeOut value) connectionTimeOut,
    required TResult Function(Unauthorized value) unAuthorized,
    required TResult Function(AppSocketException value) socketException,
    required TResult Function(NotFound value) notFound,
  }) {
    return unAuthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? serverError,
    TResult? Function(BadRequest value)? badRequest,
    TResult? Function(ConnectionTimeOut value)? connectionTimeOut,
    TResult? Function(Unauthorized value)? unAuthorized,
    TResult? Function(AppSocketException value)? socketException,
    TResult? Function(NotFound value)? notFound,
  }) {
    return unAuthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? serverError,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(ConnectionTimeOut value)? connectionTimeOut,
    TResult Function(Unauthorized value)? unAuthorized,
    TResult Function(AppSocketException value)? socketException,
    TResult Function(NotFound value)? notFound,
    required TResult orElse(),
  }) {
    if (unAuthorized != null) {
      return unAuthorized(this);
    }
    return orElse();
  }
}

abstract class Unauthorized implements AppFailure {
  const factory Unauthorized(final String? message) = _$UnauthorizedImpl;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$UnauthorizedImplCopyWith<_$UnauthorizedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AppSocketExceptionImplCopyWith<$Res>
    implements $AppFailureCopyWith<$Res> {
  factory _$$AppSocketExceptionImplCopyWith(_$AppSocketExceptionImpl value,
          $Res Function(_$AppSocketExceptionImpl) then) =
      __$$AppSocketExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$AppSocketExceptionImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$AppSocketExceptionImpl>
    implements _$$AppSocketExceptionImplCopyWith<$Res> {
  __$$AppSocketExceptionImplCopyWithImpl(_$AppSocketExceptionImpl _value,
      $Res Function(_$AppSocketExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$AppSocketExceptionImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AppSocketExceptionImpl implements AppSocketException {
  const _$AppSocketExceptionImpl(this.message);

  @override
  final String? message;

  @override
  String toString() {
    return 'AppFailure.socketException(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSocketExceptionImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSocketExceptionImplCopyWith<_$AppSocketExceptionImpl> get copyWith =>
      __$$AppSocketExceptionImplCopyWithImpl<_$AppSocketExceptionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) badRequest,
    required TResult Function(String? message) connectionTimeOut,
    required TResult Function(String? message) unAuthorized,
    required TResult Function(String? message) socketException,
    required TResult Function(String? message) notFound,
  }) {
    return socketException(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? badRequest,
    TResult? Function(String? message)? connectionTimeOut,
    TResult? Function(String? message)? unAuthorized,
    TResult? Function(String? message)? socketException,
    TResult? Function(String? message)? notFound,
  }) {
    return socketException?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? badRequest,
    TResult Function(String? message)? connectionTimeOut,
    TResult Function(String? message)? unAuthorized,
    TResult Function(String? message)? socketException,
    TResult Function(String? message)? notFound,
    required TResult orElse(),
  }) {
    if (socketException != null) {
      return socketException(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) serverError,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(ConnectionTimeOut value) connectionTimeOut,
    required TResult Function(Unauthorized value) unAuthorized,
    required TResult Function(AppSocketException value) socketException,
    required TResult Function(NotFound value) notFound,
  }) {
    return socketException(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? serverError,
    TResult? Function(BadRequest value)? badRequest,
    TResult? Function(ConnectionTimeOut value)? connectionTimeOut,
    TResult? Function(Unauthorized value)? unAuthorized,
    TResult? Function(AppSocketException value)? socketException,
    TResult? Function(NotFound value)? notFound,
  }) {
    return socketException?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? serverError,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(ConnectionTimeOut value)? connectionTimeOut,
    TResult Function(Unauthorized value)? unAuthorized,
    TResult Function(AppSocketException value)? socketException,
    TResult Function(NotFound value)? notFound,
    required TResult orElse(),
  }) {
    if (socketException != null) {
      return socketException(this);
    }
    return orElse();
  }
}

abstract class AppSocketException implements AppFailure {
  const factory AppSocketException(final String? message) =
      _$AppSocketExceptionImpl;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$AppSocketExceptionImplCopyWith<_$AppSocketExceptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotFoundImplCopyWith<$Res>
    implements $AppFailureCopyWith<$Res> {
  factory _$$NotFoundImplCopyWith(
          _$NotFoundImpl value, $Res Function(_$NotFoundImpl) then) =
      __$$NotFoundImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$NotFoundImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$NotFoundImpl>
    implements _$$NotFoundImplCopyWith<$Res> {
  __$$NotFoundImplCopyWithImpl(
      _$NotFoundImpl _value, $Res Function(_$NotFoundImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$NotFoundImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NotFoundImpl implements NotFound {
  const _$NotFoundImpl(this.message);

  @override
  final String? message;

  @override
  String toString() {
    return 'AppFailure.notFound(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotFoundImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotFoundImplCopyWith<_$NotFoundImpl> get copyWith =>
      __$$NotFoundImplCopyWithImpl<_$NotFoundImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) badRequest,
    required TResult Function(String? message) connectionTimeOut,
    required TResult Function(String? message) unAuthorized,
    required TResult Function(String? message) socketException,
    required TResult Function(String? message) notFound,
  }) {
    return notFound(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? badRequest,
    TResult? Function(String? message)? connectionTimeOut,
    TResult? Function(String? message)? unAuthorized,
    TResult? Function(String? message)? socketException,
    TResult? Function(String? message)? notFound,
  }) {
    return notFound?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? badRequest,
    TResult Function(String? message)? connectionTimeOut,
    TResult Function(String? message)? unAuthorized,
    TResult Function(String? message)? socketException,
    TResult Function(String? message)? notFound,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) serverError,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(ConnectionTimeOut value) connectionTimeOut,
    required TResult Function(Unauthorized value) unAuthorized,
    required TResult Function(AppSocketException value) socketException,
    required TResult Function(NotFound value) notFound,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? serverError,
    TResult? Function(BadRequest value)? badRequest,
    TResult? Function(ConnectionTimeOut value)? connectionTimeOut,
    TResult? Function(Unauthorized value)? unAuthorized,
    TResult? Function(AppSocketException value)? socketException,
    TResult? Function(NotFound value)? notFound,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? serverError,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(ConnectionTimeOut value)? connectionTimeOut,
    TResult Function(Unauthorized value)? unAuthorized,
    TResult Function(AppSocketException value)? socketException,
    TResult Function(NotFound value)? notFound,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class NotFound implements AppFailure {
  const factory NotFound(final String? message) = _$NotFoundImpl;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$NotFoundImplCopyWith<_$NotFoundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
