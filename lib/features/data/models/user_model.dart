import '../../domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.role,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      role: json['role'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      role: role,
      token: token,
    );
  }
}
