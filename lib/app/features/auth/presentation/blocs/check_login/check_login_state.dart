part of 'check_login_bloc.dart';

@freezed
class CheckLoginState with _$CheckLoginState {
  const factory CheckLoginState.initial() = _Initial;
  const factory CheckLoginState.loading() = _Loading;
  const factory CheckLoginState.success(User? user) = _Success;
  const factory CheckLoginState.error(String message) = _Error;
}
