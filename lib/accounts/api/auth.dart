import 'dart:core';
import 'package:dio/dio.dart';

import '../../utils/query_string.dart';

import '../models/csrf.dart';

import '../../config.dart';

final Map<String, dynamic> data = config();
final String auth = data['auth'];
final String domain = data['domain'];
final String appLink = data['appLink'];
final oauthConfig = data['oauthConfig'];

class Auth {
  Dio dio = new Dio(
    new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 5000,
      followRedirects: false,
    ),
  );

  getCsrf() async {
    try {
      var url = '$domain/api/v1/videos/__csrf';
      Response response = await dio.get(url);

      return Csrf.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return Csrf.withError("$error");
    }
  }

  requestLogin({email, password}) async {
    Csrf csrf = await getCsrf();
    String url = '$auth/v1/login';

    if (csrf.error != null) {
      return csrf.error;
    }

    try {
      dio.interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions options) {},
          onError: (DioError error) {
            if (error.response?.statusCode == 400) {
              return null;
            }
          }));

      Response response = await dio.post(url,
          data: {"email": email, "password": password},
          options: Options(headers: {
            "x-csrf-token": csrf.token,
            "cookie": '_csrf=${csrf.csrf};'
          }));

      if (response.data["status_code"] == 400) {
        return {
          "statusCode": response.data["status_code"],
          "error": response.data["error_description"]
        };
      }

      /*
        expected queryString parsed `rawCookies` value
        Map<String, dynamic> {
          SID: '',
          Path: '/',
          Expires: 'Fri, 05 Apr 2019 10:45:19 GMT',
          HttpOnly: '',
          Secure: ''
        }
      */
      List<String> rawCookies = response.headers['set-cookie'];

      var cookiesObj = QueryString.parse(rawCookies[0].replaceAll('; ', '&'));
      cookiesObj["statusCode"] = 200;
      return cookiesObj;
    } catch (error, stacktrace) {
      print(error.response);
      var description =
          await error.response?.data ?? {"error_description": 'Timeout'};
      return {
        "statusCode": error.response?.statusCode,
        "error": description["error_description"]
      };
    }
  }

  // requestCode() {
  //   Map<String, String> json = {
  //     "app_key": oauthConfig["appKey"],
  //     "response_type": 'code',
  //     "redirect_uri": appLink,
  //     "scope": oauthConfig["scope"],
  //     "state": 'molatvdemoapp',
  //   };

  //   var url = domain.replaceFirst('https://', '');

  //   Uri outgoingUri = Uri.https(url, '/accounts/_/oauth2/v1/authorize', json);

  //   return outgoingUri;
  // }

  requestCode(sid) async {
    Map<String, String> json = {
      "app_key": oauthConfig["appKey"],
      "response_type": 'code',
      "redirect_uri": appLink,
      "scope": oauthConfig["scope"],
      "state": 'molatvdemoapp',
    };

    try {
      dio.interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions options) {},
          onError: (DioError error) {
            if (error.response?.statusCode == 400) {
              return error.response?.data;
            }
          }));

      Response response = await dio.get('$auth/oauth2/v1/authorize',
          queryParameters: json,
          options: Options(headers: {"cookie": 'SID=$sid;'}));

      return response;
    } catch (error, stacktrace) {
      if (error.response.statusCode == 302) {
        String outgoingUri = error.response?.data;

        return {
          "statusCode": 200,
          "data": outgoingUri.substring(outgoingUri.indexOf('?') + 1),
        };
      }
      var description =
          error.response?.data == '' ? error.response?.statusCode : 'Timeout';
      return {"statusCode": error.response?.statusCode, "error": description};
    }
  }
}
