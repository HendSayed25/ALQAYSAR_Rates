import '../../domain/entities/user.dart';

class UserModel {
  final String id;
  final String email;
  final String role;

  UserModel({required this.id, required this.email, required this.role});

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      role: role,
    );
  }
}
