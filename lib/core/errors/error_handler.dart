import 'exceptions.dart';
import 'failures.dart';

Failure handleException(Exception e) {
  if (e is ServerException) {
    return ServerFailure(e.message);
  } else if (e is CacheException) {
    return CacheFailure(e.message);
  } else {
    return ServerFailure('Unexpected error: ${e.toString()}');
  }
}
