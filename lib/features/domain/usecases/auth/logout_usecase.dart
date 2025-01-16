import 'package:dartz/dartz.dart';

import '../../../../core/error.dart';
import '../../repository/auth_repository.dart';


class LogoutUsecase {
  final AuthRepository repository;

  LogoutUsecase(this.repository);

  Future<Either<Failure, Unit>> call() async {
    return await repository.logout();
  }
}