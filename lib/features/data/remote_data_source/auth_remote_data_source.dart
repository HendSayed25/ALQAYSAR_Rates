import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../../core/error.dart';
import '../../../service_locator.dart';
import '../../domain/entities/user_entity.dart';
import '../local/app_prefs.dart';
import '../models/user_model.dart';
import '../../../core/config/supabase/supabase_client.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, String>> fetchUserRole(String userId);
  Future<Either<Failure, Unit>> saveToken(String userId, String token);
  Future<Either<Failure, List<String>>> getAdminTokens();
  Future<Either<Failure, Unit>> sendNotificationToAdmins(String message);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Logger logger = Logger();

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    logger.i("Login attempt with email: $email");
    try {
      final response = await SupabaseClientProvider.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return const Left(AuthFailure("Invalid credentials"));
      }

      final userId = response.user!.id;
      final roleResult = await fetchUserRole(userId);

      return roleResult.fold(
            (failure) => Left(failure),
            (role) async {
          final token = sl<AppPrefs>().getString("token") ?? "";
          final updateTokenResult = await saveToken(userId, token);

          if (updateTokenResult.isLeft()) {
            return Left(updateTokenResult.fold((failure) => failure, (_) => throw Exception('Failed to update token')));
          }

          final userModel = UserModel(
            uid: userId,
            email: email,
            role: role,
            token: token,
          );
          return Right(userModel.toEntity());
        },
      );
    } catch (e) {
      logger.e("Login exception: $e");
      return Left(ServerFailure("Login failed: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await SupabaseClientProvider.client.auth.signOut();
      return const Right(unit);
    } catch (e) {
      logger.e("Logout exception: $e");
      return Left(ServerFailure("Logout failed: ${e.toString()}"));
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

  @override
  Future<Either<Failure, Unit>> saveToken(String userId, String token) async {
    try {
      await SupabaseClientProvider.client.from('users').update({
        'token': token,
      }).eq('uid', userId);
      return const Right(unit);
    } catch (e) {
      logger.e("Failed to save token: $e");
      return const Left(ServerFailure("Failed to save token"));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAdminTokens() async {
    try {
      final response = await SupabaseClientProvider.client
          .from('users')
          .select('token')
          .eq('role', 'admin');

      final List<Map<String, dynamic>> data = response;
      return Right(data.map((user) => user['token'].toString()).toList());
    } catch (e) {
      logger.e("Failed to fetch admin tokens: $e");
      return const Left(ServerFailure("Failed to fetch admin tokens"));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendNotificationToAdmins(String message) async {
    try {
      final tokensResult = await getAdminTokens();
      return tokensResult.fold(
            (failure) => Left(failure),
            (tokens) async {
          ///TODO: Implement logic to send notifications to admins
          return const Right(unit);
        },
      );
    } catch (e) {
      logger.e("Failed to send notifications: $e");
      return const Left(ServerFailure("Failed to send notifications"));
    }
  }
}