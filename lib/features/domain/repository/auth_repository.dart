import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../entities/user_entity.dart';


abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, Unit>> logout();
}