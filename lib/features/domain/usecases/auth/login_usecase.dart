import 'package:dartz/dartz.dart';

import '../../../../core/error.dart';
import '../../entities/user.dart';
import '../../repository/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<Either<Failure, UserEntity>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}