import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../network/dio_client.dart';
import '../../shared/services/storage_service.dart';
import '../../shared/services/snackbar_service.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  // Network
  sl.registerSingleton<Dio>(DioClient().dio);

  // Services
  sl.registerSingleton<StorageService>(StorageService());
  sl.registerSingleton<SnackbarService>(SnackbarService());

  // Data Sources
  sl.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(sl()),
  );

  // Use Cases
  sl.registerSingleton<LoginUseCase>(
    LoginUseCase(sl()),
  );

  // BLoCs
  sl.registerFactory<AuthBloc>(
        () => AuthBloc(loginUseCase: sl()),
  );
}