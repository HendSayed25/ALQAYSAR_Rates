import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String role;
  final String token;

  const UserEntity({
    required this.id,
    required this.email,
    required this.role,
    required this.token,
  });

  @override
  List<Object?> get props => [id, email, role];
}
