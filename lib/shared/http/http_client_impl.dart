import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../env/env.dart';
import 'http_client.dart';

class HttpClientImpl extends HttpClient {
  static final HttpClientImpl instance = HttpClientImpl._internal();

  late final Dio dio;

  final defaultOptions = BaseOptions(
    baseUrl: '${Env.host}?apiKey=${Env.apikey}',
    validateStatus: (status) => true,
    headers: {
      HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
    },
  );

  HttpClientImpl._internal() {
    dio = Dio(defaultOptions);
    dio.interceptors.addAll([
      if (kDebugMode) LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }

  factory HttpClientImpl() {
    return instance;
  }

  @override
  Future<Response<T>> post<T>({
    String path = '',
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return responseConverter(response);
    } on DioException catch (error) {
      throwRestClientException(error);
    }
  }

  @override
  Future<Response<T>> get<T>({
    String path = '',
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return responseConverter(response);
    } on DioException catch (error) {
      throwRestClientException(error);
    }
  }
}
