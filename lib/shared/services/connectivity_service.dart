import 'package:flutter_bloc_base/core/network/network_info.dart';
import 'package:flutter_bloc_base/shared/services/snackbar_service.dart';

class ConnectivityService {
  final NetworkInfo _networkInfo;
  final SnackbarService _snackbarService;

  ConnectivityService(this._networkInfo, this._snackbarService) {
    _startMonitoring();
  }

  bool _isShowingNoInternet = false;

  void _startMonitoring() {
    _networkInfo.onConnectivityChanged.listen((isConnected) {
      if (!isConnected && !_isShowingNoInternet) {
        _snackbarService.showError('No internet connection');
        _isShowingNoInternet = true;
      } else if (isConnected && _isShowingNoInternet) {
        _snackbarService.showSuccess('Internet connection restored');
        _isShowingNoInternet = false;
      }
    });
  }
}