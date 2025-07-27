import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:to_do_app/infrastructure/network/api_endpoints.dart';
import 'package:to_do_app/infrastructure/network/interceptor/token_interceptor.dart';

class ApiClient {
  /// dio instance
  final Dio _dio;

  /// Defines the base URL that will be used for each network request.
  final String? _baseUrl;

  /// Defines the [Uri.scheme] to use for connecting to the API.
  ///
  /// Setting this to `UriScheme.http` should only be done locally within in
  /// dev when absolutely necessary.
  // for later use to make http request

  // injecting dio instance
  ApiClient(this._dio, this._baseUrl) {
    _dio
      ..options.baseUrl = _baseUrl ?? ''
      ..options.connectTimeout = const Duration(
        milliseconds: ApiConstants.connectionTimeout,
      )
      ..options.receiveTimeout = const Duration(
        milliseconds: ApiConstants.receiveTimeout,
      )
      ..options.responseType = ResponseType.json
      ..interceptors.addAll([
        TokenInterceptor(dio: _dio),
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      ]);
  }

  // Get:-----------------------------------------------------------------------
  Future<Response?> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response response;
    try {
      response = await _dio.get<Map<String, dynamic>>(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (error) {
      return error.response;
    }
    return response;
  }

  // Post:----------------------------------------------------------------------
  Future<Response?> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response response;
    try {
      response = await _dio.post<dynamic>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (error) {
      return error.response;
    }

    return response;
  }

  Future<Response?> patch(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response response;
    try {
      response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (error) {
      return error.response;
    }
    return response;
  }

  // Put:-----------------------------------------------------------------------
  Future<Response?> put(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response response;
    try {
      response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (error) {
      return error.response;
    }
    return response;
  }

  // Delete:--------------------------------------------------------------------
  Future<Response?> delete(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response response;
    try {
      response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (error) {
      return error.response;
    }
    return response;
  }
}
