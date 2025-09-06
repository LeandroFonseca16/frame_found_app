import 'package:dio/dio.dart';

class HttpClientException implements Exception {
  final String? message;
  final int? statusCode;
  final dynamic error;
  final Response response;

  const HttpClientException({
    this.message,
    this.statusCode,
    required this.error,
    required this.response,
  });

  @override
  String toString() {
    return 'ClientException(message: $message, statusCode: $statusCode, erro: $error, response: $response)';
  }
}
