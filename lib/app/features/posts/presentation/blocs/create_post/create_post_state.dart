part of 'create_post_bloc.dart';

@freezed
class CreatePostState with _$CreatePostState {
  const factory CreatePostState.initial() = _Initial;
  const factory CreatePostState.loading() = _Loading;
  const factory CreatePostState.success(String message) = _Success;
  const factory CreatePostState.error(String message) = _Error;
}
