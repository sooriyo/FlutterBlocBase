import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'core/bloc/connectivity/connectivity_event.dart';
import 'core/themes/app_theme.dart';
import 'config/routes/router.dart';
import 'core/di/injection.dart';
import 'core/bloc/connectivity/connectivity_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'shared/services/snackbar_service.dart';
import 'shared/widgets/connectivity_listener_widget.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<ConnectivityBloc>()),
      ],
      child: ConnectivityListenerWidget(
        child: Builder(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<ConnectivityBloc>().add(const ConnectivityChanged(true));
            });
            return MaterialApp.router(
              theme: lightTheme(),
              darkTheme: darkTheme(),
              themeMode: ThemeMode.system,
              routerConfig: AppRouter().config(),
              builder: (context, child) {
                return ScaffoldMessenger(
                  key: sl<SnackbarService>().messengerKey,
                  child: child ?? const SizedBox.shrink(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}