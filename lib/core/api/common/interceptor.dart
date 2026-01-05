import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';  

class BaseInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    /* add authorization header */
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode != 200) {
      return handler.next(response);
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    /* switch case for error type   */
    if(err.type == DioExceptionType.badResponse) {
      return handler.next(err);
    }
    if(err.type == DioExceptionType.badCertificate) {
      return handler.next(err);
    }
    if(err.type == DioExceptionType.connectionTimeout) {
      return handler.next(err);
    }
    if(err.type == DioExceptionType.receiveTimeout) {
      return handler.next(err);
    }
    return handler.next(err);
  }
}
