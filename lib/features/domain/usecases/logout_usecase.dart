import 'package:dartz/dartz.dart';

import '../repository/user_repository.dart';

class LogoutUseCase {
  final UserRepositoryInterface repository;

  LogoutUseCase(this.repository);

  Future<Either<String, Unit>> execute(String email, String password) {
    return repository.logout();
  }
}