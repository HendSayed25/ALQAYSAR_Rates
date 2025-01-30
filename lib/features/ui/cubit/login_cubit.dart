import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../states/login_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase login;

  AuthCubit({required this.login}) : super(AuthInitial());

  Future<void> loginUser({required String email, required String password}) async {
    emit(AuthLoading());
    final Either<Failure, UserEntity> result = await login(email, password);
    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (userEntity) => emit(AuthAuthenticated(userEntity)),
    );
  }

}
