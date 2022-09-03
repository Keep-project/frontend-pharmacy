
// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiRequest {
  final String? url;
  final String? token;
  final Map<String, dynamic>? data;
  ApiRequest({
    @required this.url,
    this.token,
    this.data,
  });

  Dio _dio() {
    Dio _dioR =
        Dio(BaseOptions( headers: {
      'Authorization': 'Bearer $token',
      "Content-Type": 'application/json',
    }));
    (_dioR.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
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
    _dio()
        .get(
      url!
    )
        .then((res) {
      if (onSuccess != null) onSuccess(res.data);
    }).catchError((error) {
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
      if (onError != null) onError(error);
    });
  }
}
