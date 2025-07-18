import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(const AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(const AuthLoading());
      try {
        final result = await loginUseCase(event.email, event.password);
        emit(AuthAuthenticated(userId: result['userId']));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
  }
}
