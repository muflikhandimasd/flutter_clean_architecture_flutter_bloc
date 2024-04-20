part of 'create_post_bloc.dart';

@freezed
class CreatePostEvent with _$CreatePostEvent {
  const factory CreatePostEvent.create({
    required String title,
    required String body
}) = _Create;
}
