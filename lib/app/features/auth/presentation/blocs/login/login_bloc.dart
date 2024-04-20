import 'package:bloc/bloc.dart';
import 'package:flutter_clean/app/features/auth/data/params/login_params.dart';
import 'package:flutter_clean/app/features/auth/domain/usecases/login_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase _loginUsecase;
  LoginBloc(this._loginUsecase) : super(const LoginState.initial()) {
    on<LoginEvent>((event, emit) async{
      event.maybeWhen(
        login: (email, password)async {
          emit(LoginState.loading());
          final result = await _loginUsecase(LoginParams(email: email, password: password));
          result.fold((l) => emit(LoginState.error(l.message)), (_) => emit(LoginState.success()));
        },
        orElse: () {

      },);

    });
  }
}
