import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserEntity userEntity;

  AuthAuthenticated(this.userEntity);

  @override
  List<Object?> get props => [userEntity];
}

class AuthError extends AuthState {
  final String? message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}