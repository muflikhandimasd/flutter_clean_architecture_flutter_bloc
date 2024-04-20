part of 'get_post_bloc.dart';

@freezed
class GetPostState with _$GetPostState {
  const factory GetPostState.initial() = _Initial;
  const factory GetPostState.loading() = _Loading;
  const factory GetPostState.loaded(
      List<Post> posts
      ) = _Loaded;
  const factory GetPostState.error(
      String message
      ) = _Error;
}
