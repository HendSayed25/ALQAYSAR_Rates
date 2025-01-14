import 'package:dartz/dartz.dart';

import '../entities/user.dart';
import '../repository/user_repository.dart';

class LoginUseCase {
  final UserRepositoryInterface repository;

  LoginUseCase(this.repository);

  Future<Either<String, UserEntity>> execute(String email, String password) {
    return repository.login(email, password);
  }
}