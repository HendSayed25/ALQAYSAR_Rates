import 'package:dartz/dartz.dart';

import '../repository/user_repository.dart';

class FetchUserRoleUsecase {
  final UserRepositoryInterface repository;

  FetchUserRoleUsecase(this.repository);

  Future<Either<String, String>> execute(String userId) async {
    return repository.fetchUserRole(userId);
  }
}
