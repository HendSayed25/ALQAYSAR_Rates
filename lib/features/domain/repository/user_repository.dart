import 'package:dartz/dartz.dart';

import '../entities/user.dart';

abstract class UserRepositoryInterface {
  Future<Either<String, UserEntity>> login(String email, String password);
}