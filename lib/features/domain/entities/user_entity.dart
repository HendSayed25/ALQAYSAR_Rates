class UserEntity {
  final String uid;
  final String email;
  final String role;
  final String token;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.role,
    required this.token,
  });
}