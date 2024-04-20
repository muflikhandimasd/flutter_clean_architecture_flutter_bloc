import 'package:bloc/bloc.dart';
import 'package:flutter_clean/app/core/params/no_params.dart';
import 'package:flutter_clean/app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogoutUsecase _logoutUsecase;
  LogoutBloc(this._logoutUsecase) : super(const LogoutState.initial()) {
    on<LogoutEvent>((event, emit) async{
      event.maybeWhen(
        started: ()async {
          emit(LogoutState.loading());
          final result = await _logoutUsecase(NoParams());
          result.fold((l) => emit(LogoutState.error(l.message)), (_) => emit(LogoutState.success()));
        },
        orElse: () {

      },);

    });
  }
}
