import 'package:bloc/bloc.dart';
import 'package:flutter_clean/app/core/params/no_params.dart';
import 'package:flutter_clean/app/features/auth/domain/entities/user.dart';
import 'package:flutter_clean/app/features/auth/domain/usecases/check_login_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_login_event.dart';
part 'check_login_state.dart';
part 'check_login_bloc.freezed.dart';

class CheckLoginBloc extends Bloc<CheckLoginEvent, CheckLoginState> {
  final CheckLoginUsecase _checkLoginUsecase;
  CheckLoginBloc(this._checkLoginUsecase) : super(const CheckLoginState.initial()) {
    add(CheckLoginEvent.started());
    on<CheckLoginEvent>((event, emit)async {
      event.maybeWhen(
        started: () async{
          emit(CheckLoginState.loading());
          final result = await _checkLoginUsecase(NoParams());
          result.fold((l) => emit(CheckLoginState.error(l.message)), (r) => emit(CheckLoginState.success(r)));

        },
        orElse: () {

      },);

    });
  }
}
