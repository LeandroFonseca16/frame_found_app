import 'package:dio/dio.dart';

import 'http_client_exception.dart';

abstract class BaseHttpClient {
  Future<Response<T>> responseConverter<T>(Response<dynamic> response) async {
    return Response<T>(
      requestOptions: response.requestOptions,
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  Never throwRestClientException(DioException dioError) {
    final response = dioError.response;
    throw HttpClientException(
      error: dioError.error,
      message: response?.statusMessage,
      statusCode: response?.statusCode,
      response: Response(
        requestOptions: response?.requestOptions ?? RequestOptions(path: ""),
        data: response?.data,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
      ),
    );
  }
}
