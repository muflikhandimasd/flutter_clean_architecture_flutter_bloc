part of 'update_post_bloc.dart';

@freezed
class UpdatePostState with _$UpdatePostState {
  const factory UpdatePostState.initial() = _Initial;
  const factory UpdatePostState.loading() = _Loading;
  const factory UpdatePostState.success(String message) = _Success;
  const factory UpdatePostState.error(String message) = _Error;
}
