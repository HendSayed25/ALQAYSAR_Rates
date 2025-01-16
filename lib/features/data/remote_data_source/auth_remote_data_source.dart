import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../../core/error.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';
import '../../../core/config/supabase/supabase_client.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, String>> fetchUserRole(String userId);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  var logger = Logger();

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    logger.w("$email + $password");
    try {
      final response =
      await SupabaseClientProvider.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final userId = response.user!.id;
        final roleResult = await fetchUserRole(userId);
        return roleResult.fold(
              (failure) => Left(failure),
              (role) {
            final userModel = UserModel(
              id: userId,
              email: email,
              role: role,
            );
            return Right(userModel.toEntity()); // Convert to UserEntity
          },
        );
      } else {
        return const Left(AuthFailure("Invalid credentials"));
      }
    } catch (e) {
      logger.e("ex login: $e");
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await SupabaseClientProvider.client.auth.signOut();
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> fetchUserRole(String userId) async {
    try {
      final response = await SupabaseClientProvider.client
          .from('users')
          .select('role')
          .eq('uid', userId)
          .single();
      return Right(response['role'] as String);
    } catch (e) {
      logger.e("Error fetching user role: $e");
      return const Left(ServerFailure("Failed to fetch user role"));
    }
  }
}