import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../../../shared/services/snackbar_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SnackbarService _snackbarService = SnackbarService();

  AuthBloc({required this.loginUseCase}) : super(const AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(const AuthLoading());
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