import 'package:dartz/dartz.dart';

import '../../domain/entities/user.dart';
import '../models/user_model.dart';
import '../../../core/config/supabase/supabase_client.dart';

abstract class AuthRemoteDataSource {
  Future<Either<String, UserEntity>> login(String email, String password);

  Future<Either<String, Unit>> logout();

  Future<Either<String, String>> fetchUserRole(String userId);
}

class RemoteDataSource implements AuthRemoteDataSource {
  @override
  Future<Either<String, UserEntity>> login(
      String email, String password) async {
    try {
      final response =
          await SupabaseClientProvider.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // Assuming your Supabase database contains a "role" field for the user
        final userId = response.user!.id;
        final userMetadata = response.user!.userMetadata;

        final role = userMetadata?['role'] ??
            'user'; // Default to 'User' if role is missing

        // Map to UserModel
        final userModel = UserModel(
          id: userId,
          email: email,
          role: role,
        );
        return Right(userModel.toEntity());
      } else {
        return const Left("Invalid credentials");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> logout() async {
    try {
      await SupabaseClientProvider.client.auth.signOut();
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> fetchUserRole(String userId) async {
    try {
      final response = await SupabaseClientProvider.client
          .from('users')
          .select('role')
          .eq('uid', userId)
          .single();
      return Right(response['role'] as String);
    } catch (e) {
      return const Left("Error fetching user role");
    }
  }
}
