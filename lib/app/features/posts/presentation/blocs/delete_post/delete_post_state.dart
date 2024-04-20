part of 'delete_post_bloc.dart';

@freezed
class DeletePostState with _$DeletePostState {
  const factory DeletePostState.initial() = _Initial;
  const factory DeletePostState.loading() = _Loading;
  const factory DeletePostState.success(String message) = _Success;
  const factory DeletePostState.error(String message) = _Error;
}
