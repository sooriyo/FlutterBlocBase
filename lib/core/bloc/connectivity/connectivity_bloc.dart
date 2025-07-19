import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_base/core/network/network_info.dart';
import 'package:logger/logger.dart';
import 'connectivity_event.dart';
import 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final NetworkInfo _networkInfo;
  StreamSubscription<bool>? _connectivitySubscription;
  final Logger _logger = Logger();

  ConnectivityBloc(this._networkInfo) : super(const ConnectivityInitial()) {
    on<ConnectivityChanged>(_onConnectivityChanged);

    _connectivitySubscription = _networkInfo.onConnectivityChanged.listen((isConnected) {
      _logger.d('Stream emitted: isConnected=$isConnected');
      add(ConnectivityChanged(isConnected));
    });
  }

  Future<void> _onConnectivityChanged(ConnectivityChanged event, Emitter<ConnectivityState> emit) async {
    _logger.d('Handling ConnectivityChanged: isConnected=${event.isConnected}');
    if (event.isConnected) {
      emit(const ConnectivityOnline());
    } else {
      emit(const ConnectivityOffline());
    }
  }

  @override
  Future<void> close() {
    _logger.d('Closing ConnectivityBloc');
    _connectivitySubscription?.cancel();
    return super.close();
  }
}