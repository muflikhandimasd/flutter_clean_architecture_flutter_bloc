import 'package:bloc/bloc.dart';
import 'package:flutter_clean/app/features/auth/data/params/register_params.dart';
import 'package:flutter_clean/app/features/auth/domain/usecases/register_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUsecase _registerUsecase;
  RegisterBloc(this._registerUsecase) : super(const RegisterState.initial()) {
    on<RegisterEvent>((event, emit)async {
      event.maybeWhen(
        register: (name, email, password)async {
          emit(RegisterState.loading());
          final result = await _registerUsecase(RegisterParams(email: email, name: name, password: password));
          result.fold((l) => emit(RegisterState.error(l.message)), (_) => emit(RegisterState.success()));

        },
        orElse: () {

      },);

    });
  }
}
