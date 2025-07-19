import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_base/core/bloc/connectivity/connectivity_bloc.dart';
import 'package:flutter_bloc_base/shared/services/snackbar_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../core/bloc/connectivity/connectivity_state.dart';

class ConnectivityListenerWidget extends StatefulWidget {
  final Widget child;

  const ConnectivityListenerWidget({required this.child, super.key});

  @override
  State<ConnectivityListenerWidget> createState() => _ConnectivityListenerWidgetState();
}

class _ConnectivityListenerWidgetState extends State<ConnectivityListenerWidget> {
  final SnackbarService _snackbarService = GetIt.I<SnackbarService>();
  final Logger _logger = Logger();
  bool _isShowingNoInternet = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listenWhen: (previous, current) {
        _logger.d('listenWhen: previous=$previous, current=$current, isShowingNoInternet=$_isShowingNoInternet');
        return (current is ConnectivityOffline && !_isShowingNoInternet) ||
            (current is ConnectivityOnline && _isShowingNoInternet);
      },
      listener: (context, state) {
        _logger.d('Listener triggered: state=$state, isShowingNoInternet=$_isShowingNoInternet');
        if (state is ConnectivityOffline && mounted) {
          _snackbarService.showError('No internet connection', duration: const Duration(days: 1));
          setState(() => _isShowingNoInternet = true);
        } else if (state is ConnectivityOnline && _isShowingNoInternet && mounted) {
          _snackbarService.messengerKey.currentState?.clearSnackBars();
          _snackbarService.showSuccess('Internet connection restored', duration: const Duration(seconds: 3));
          setState(() => _isShowingNoInternet = false);
        }
      },
      child: widget.child,
    );
  }
}