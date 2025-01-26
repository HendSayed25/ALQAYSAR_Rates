import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../remote_data_source/auth_remote_data_source.dart';



class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    return await remoteDataSource.logout();
  }

}