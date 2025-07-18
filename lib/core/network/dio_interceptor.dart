import 'package:dio/dio.dart';
import '../../shared/services/snackbar_service.dart';
import '../utils/logger.dart';

class ErrorInterceptor extends Interceptor {
  final SnackbarService _snackbarService = SnackbarService();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage;
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Network timeout. Please try again.';
        break;
      case DioExceptionType.badResponse:
        errorMessage = 'Server error: ${err.response?.statusCode}';
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request cancelled';
        break;
      default:
        errorMessage = 'Unexpected error: ${err.message}';
    }

    AppLogger.logError(errorMessage, err);
    _snackbarService.showError(errorMessage);
    return super.onError(err, handler);
  }
}