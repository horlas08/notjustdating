import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';

// import 'package:footfan/domain/core/failure/app_failure.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/core/constants/error_messages.dart';
// import '../../domain/core/env.dart';
import '../../domain/core/failure/app_failure.dart';
import '../../domain/http_service/http_service.dart';
import 'env.dart';
import 'handler.dart';

@LazySingleton(as: IHttpService)
class IHttpRepo implements IHttpService {
  Duration timout = const Duration(seconds: 120);
  @override
  Future<Either<AppFailure, Right>> delete({required String path}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<AppFailure, Right>> getData({required String path}) async {
    final String url = baseUrl + path;
    log("path :: $url");

    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: await getHeaders(),
          )
          .timeout(timout);

      var body = json.decode(response.body);
      log(body.toString());

      return handleResponse(body: body, statusCode: response.statusCode);
    } on TimeoutException catch (e) {
      log(e.toString());
      return Left(AppFailure.connectionTimeOut(ErrorMessages().timeoutString));
    } on SocketException catch (e) {
      log(e.toString());
      return Left(
          AppFailure.socketException(ErrorMessages().socketExceptionString));
    } on http.ClientException catch (e) {
      log(e.toString());
      return Left(
          AppFailure.socketException(ErrorMessages().socketExceptionString));
    } catch (e) {
      log(e.toString());
      return Left(AppFailure.serverError(
        ErrorMessages().serverErrorString,
      ));
    }
  }

  @override
  Future<Either<AppFailure, Right>> patch(
      {required Map<String, dynamic> payload, required String path}) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<Either<AppFailure, Right>> post(
      {required Map<String, dynamic> payload, required String path}) async {
    final String url = baseUrl + path;
    log("path :: $url");
    try {
      var data = await getHeaders();
      final response = await http
          .post(Uri.parse(url), headers: data, body: json.encode(payload))
          .timeout(timout);

      // log("headerss:::::$data");
      log(payload.toString());
      log(response.body.toString());
      var body = json.decode(response.body);
      log(body.toString());

      return handleResponse(body: body, statusCode: response.statusCode);
    } on TimeoutException catch (e) {
      log(e.toString());
      return Left(AppFailure.connectionTimeOut(ErrorMessages().timeoutString));
    } on SocketException catch (e) {
      log(e.toString());
      return Left(
          AppFailure.socketException(ErrorMessages().socketExceptionString));
    } on http.ClientException catch (e) {
      log(e.toString());
      return Left(
          AppFailure.socketException(ErrorMessages().socketExceptionString));
    } catch (e) {
      log(e.toString());
      return Left(AppFailure.serverError(
        ErrorMessages().serverErrorString,
      ));
    }
  }

  @override
  Future<Either<AppFailure, Right>> postFormData(
      {required Map<String, String> payload,
      required String path,
      File? file,
      String? imageKey}) async {
    final String url = baseUrl + path;
    log("path :: $url");
    try {
      // log(getHeaders().toString());
      var request = http.MultipartRequest("POST", Uri.parse(url))
        ..headers.addAll(await getHeaders())
        ..fields.addAll(payload);

      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath(
            imageKey ?? 'picture', file.path));
      }
      http.Response response =
          await http.Response.fromStream(await request.send());
      var body = json.decode(response.body);
      log(body.toString());

      return handleResponse(body: body, statusCode: response.statusCode);
    } on TimeoutException catch (e) {
      log(e.toString());
      return Left(AppFailure.connectionTimeOut(ErrorMessages().timeoutString));
    } on SocketException catch (e) {
      log(e.toString());
      return Left(
          AppFailure.socketException(ErrorMessages().socketExceptionString));
    } on http.ClientException catch (e) {
      log(e.toString());
      return Left(
          AppFailure.socketException(ErrorMessages().socketExceptionString));
    } catch (e) {
      log(e.toString());
      return Left(AppFailure.serverError(
        ErrorMessages().serverErrorString,
      ));
    }
  }

  @override
  Future<Either<AppFailure, Right>> put(
      {required Map<String, dynamic> payload, required String path}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    log(token.toString());
    // // print('token $accessToken');
    // var token = await _localStorage.readData("token");

    return <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }

  @override
  Future<Either<AppFailure, Right>> postFormDataWithFiles(
      {required Map<String, String> payload,
      required String path,
      List<dynamic>? listData,
      String? listKey,
      String? imageKey,
      File? data}) async {
    final String url = baseUrl + path;
    log("path :: $url");
    try {
      // log(getHeaders().toString());
      // var newPayload = {}
      var request = http.MultipartRequest("POST", Uri.parse(url))
        ..headers.addAll(await getHeaders())
        ..fields.addAll(payload);
      if (listData != null) {
        for (int i = 0; i < listData.length; i++) {
          request.fields['$listKey[$i]'] = '${listData[i]}';
        }
      }
      if (data != null) {
        request.files.add(await http.MultipartFile.fromPath(
            imageKey ?? 'profile_picture', data.path));
      }
      log(request.fields.toString());
      http.Response response =
          await http.Response.fromStream(await request.send());
      var body = json.decode(response.body);
      log(body.toString());

      return handleResponse(body: body, statusCode: response.statusCode);
    } on TimeoutException catch (e) {
      log(e.toString());
      return Left(AppFailure.connectionTimeOut(ErrorMessages().timeoutString));
    } on SocketException catch (e) {
      log(e.toString());
      return Left(
          AppFailure.socketException(ErrorMessages().socketExceptionString));
    } on http.ClientException catch (e) {
      log(e.toString());
      return Left(
          AppFailure.socketException(ErrorMessages().socketExceptionString));
    } catch (e) {
      log(e.toString());
      return Left(AppFailure.serverError(
        ErrorMessages().serverErrorString,
      ));
    }
  }

  @override
  Future<Either<AppFailure, Right>> postList(
      {required List payload, required String path}) async {
    final String url = baseUrl + path;
    log("path :: $url");
    try {
      final response = await http
          .post(Uri.parse(url),
              headers: await getHeaders(), body: json.encode(payload))
          .timeout(timout);

      var data = await getHeaders();
      log("headerss:::::$data");
      log(payload.toString());
      log(response.body.toString());
      var body = json.decode(response.body);
      log(body.toString());

      return handleResponse(body: body, statusCode: response.statusCode);
    } on TimeoutException catch (e) {
      log(e.toString());
      return Left(AppFailure.connectionTimeOut(ErrorMessages().timeoutString));
    } on SocketException catch (e) {
      log(e.toString());
      return Left(
          AppFailure.socketException(ErrorMessages().socketExceptionString));
    } on http.ClientException catch (e) {
      log(e.toString());
      return Left(
          AppFailure.socketException(ErrorMessages().socketExceptionString));
    } catch (e) {
      log(e.toString());
      return Left(AppFailure.serverError(
        ErrorMessages().serverErrorString,
      ));
    }
  }
}
