part of 'update_post_bloc.dart';

@freezed
class UpdatePostEvent with _$UpdatePostEvent {
  const factory UpdatePostEvent.update({
    required int id,
    required String title,
    required String body,
}) = _Update;
}
