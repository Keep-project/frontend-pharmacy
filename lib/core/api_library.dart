import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class ApiRequest {
  final String? url;
  final String? token;
  final Map<String, dynamic>? data;
  ApiRequest({
    required this.url,
    this.token,
    this.data,
  });

  Dio _dio() {
    Dio _dioR = Dio(BaseOptions(headers: {
      'Authorization': 'Bearer $token',
      "Content-Type": 'application/json',
    }));
    (_dioR.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    return _dioR;
  }

  void get({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    _dio().get(url!).then((res) {
      if (onSuccess != null) onSuccess(res.data);
    }).catchError((error) {
      // catchAllError(error);
      if (onError != null) onError(error);
    });
  }

  void post({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    _dio().post(url!, data: data!).then((res) {
      if (onSuccess != null) onSuccess(res.data);
    }).catchError((error) {
      catchAllError(error);
      if (onError != null) onError(error);
    });
  }

  void put({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(DioError error)? onError,
  }) {
    _dio().put(url!, data: data!).then((res) {
      if (onSuccess != null) onSuccess(res.data);
    }).catchError((error) {
      catchAllError(error);
      if (onError != null) onError(error);
    });
  }

  void delete({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(DioError error)? onError,
  }) {
    _dio().delete(url!, data: data!).then((res) {
      if (onSuccess != null) onSuccess(res.data);
    }).catchError((error) {
      catchAllError(error);
      if (onError != null) onError(error);
    });
  }

  void catchAllError(dynamic error) {
    print(error.response!.toString());
    // final data = jsonDecode(error.response!.toString());
    // if (error.response!.statusCode == 403 ||
    //     data["status"] == 407 ||
    //     data["status"] == 403) {
    //   Get.offAllNamed(AppRoutes.LOGIN);
    // }
  }
}
