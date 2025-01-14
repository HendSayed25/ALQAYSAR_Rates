import 'package:dartz/dartz.dart';

import '../../domain/entities/user.dart';
import '../models/user_model.dart';
import '../supabase_client.dart';

class RemoteDataSource {

  Future<Either<String, UserEntity>> login(String email, String password) async {
    try {
      final response = await SupabaseClientProvider.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // Assuming your Supabase database contains a "role" field for the user
        final userId = response.user!.id;
        final userMetadata = response.user!.userMetadata;

        final role = userMetadata?['role'] ?? 'User'; // Default to 'User' if role is missing

        // Map to UserModel
        final userModel = UserModel(
          id: userId,
          email: email,
          role: role,
        );
        return Right(userModel.toEntity());
      } else {
        return Left("Invalid credentials");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
