import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logger/logger.dart';

class NetworkInfo {
  final InternetConnection _internetConnection = InternetConnection();
  final Logger _logger = Logger();

  Stream<bool> get onConnectivityChanged => _internetConnection.onStatusChange.map((status) {
    final isConnected = status == InternetStatus.connected;
    _logger.d('Internet status: $status, isConnected: $isConnected');
    return isConnected;
  });

  Future<bool> get isConnected async {
    final status = await _internetConnection.hasInternetAccess;
    _logger.d('isConnected check: $status');
    return status;
  }
}