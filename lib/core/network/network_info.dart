import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class NetworkInfo {
  final Dio _dio = Dio();

  Future<bool> get isConnected async {
    // Check device connectivity
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    // Perform true internet check by pinging one.one.one.one
    try {
      final response = await _dio.get('https://1.1.1.1', options: Options(
        sendTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}