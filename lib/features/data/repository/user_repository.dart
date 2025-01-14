import 'package:dartz/dartz.dart';

import '../../domain/entities/user.dart';
import '../../domain/repository/user_repository.dart';
import '../data_source/remote_data_source.dart';

class UserRepositoryImpl implements UserRepositoryInterface {
  final RemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, UserEntity>> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }

  @override
  Future<Either<String, Unit>> logout() {
    return remoteDataSource.logout();
  }

  @override
  Future<Either<String, String>> fetchUserRole(String userId) {
    return remoteDataSource.fetchUserRole(userId);
  }
}
