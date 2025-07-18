import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../../../shared/services/snackbar_service.dart';
import '../../../../core/network/network_info.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SnackbarService _snackbarService = SnackbarService();
  final NetworkInfo _networkInfo = NetworkInfo();

  AuthBloc({required this.loginUseCase}) : super(const AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(const AuthLoading());
      if (!await _networkInfo.isConnected) {
        emit(const AuthError(message: 'No internet connection'));
        _snackbarService.showError('Please check your internet connection');
        return;
      }
      try {
        final result = await loginUseCase(event.email, event.password);
        emit(AuthAuthenticated(userId: result['userId']));
        _snackbarService.showSuccess('Login successful!');
      } catch (e) {
        emit(AuthError(message: e.toString()));
        _snackbarService.showError('Login failed: $e');
      }
    });
  }
}