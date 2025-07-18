import '../../../../core/errors/exceptions.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final result = await remoteDataSource.login(email, password);
      return result;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
