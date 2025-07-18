import 'package:dio/dio.dart';
import '../../config/environment/env_config.dart';
import '../constants/api_constants.dart';
import 'dio_interceptor.dart';

class DioClient {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: EnvConfig.apiBaseUrl,
      connectTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
      receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
    ),
  )..interceptors.add(ErrorInterceptor());
}