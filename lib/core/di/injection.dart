import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../network/network_info.dart';
import '../../shared/services/storage_service.dart';
import '../../shared/services/snackbar_service.dart';
import '../bloc/connectivity/connectivity_bloc.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  // Network
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<NetworkInfo>(NetworkInfo());

  // Services
  sl.registerSingleton<StorageService>(StorageService());
  sl.registerSingleton<SnackbarService>(SnackbarService());

  // BLoCs
  sl.registerFactory<ConnectivityBloc>(() => ConnectivityBloc(sl<NetworkInfo>()));
  sl.registerFactory<AuthBloc>(() => AuthBloc(loginUseCase: sl()));

  // Data Sources
  sl.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl(sl()));

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));

  // Use Cases
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
}