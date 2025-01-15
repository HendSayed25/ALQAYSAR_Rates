import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login_usecase.dart';
import '../states/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    final result = await loginUseCase.execute(email, password);
    result.fold(
          (failure) => emit(LoginError(failure)),
          (user) => emit(LoginSuccess(user)),
    );
  }
}
