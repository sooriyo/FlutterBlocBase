import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'core/themes/app_theme.dart';
import 'config/routes/router.dart';
import 'core/di/injection.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'shared/services/snackbar_service.dart';

class App extends StatelessWidget {
  final SnackbarService _snackbarService = SnackbarService();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
      ],
      child: ScaffoldMessenger(
        key: _snackbarService.messengerKey,
        child: MaterialApp.router(
          theme: lightTheme(),
          darkTheme: darkTheme(),
          themeMode: ThemeMode.system,
          routerConfig: AppRouter().config(),
        ),
      ),
    );
  }
}