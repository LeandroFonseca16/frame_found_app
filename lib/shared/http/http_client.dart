import 'package:dio/dio.dart';

import '../core/base_http_client.dart';
import 'http_client_impl.dart';

abstract class HttpClient extends BaseHttpClient {
  static HttpClient get instance => HttpClientImpl.instance;

  Future<Response<T>> post<T>({
    String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Response<T>> get<T>({
    String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
}
