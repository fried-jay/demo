import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:demo/core/api/common/interceptor.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();

  ApiClient._internal() {
    if (kDebugMode) {
      _baseDio.interceptors.add(PrettyDioLogger());
      _baseDio.interceptors.add(BaseInterceptor());
    }

    _baseDio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
    );

    
    _initService();
  }

  factory ApiClient() {
    return _instance;
  }

  static final Dio _baseDio = Dio();
  _initService() {
    // TODO: init services
  }
}
