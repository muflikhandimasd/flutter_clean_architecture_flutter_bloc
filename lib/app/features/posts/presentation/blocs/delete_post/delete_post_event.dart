part of 'delete_post_bloc.dart';

@freezed
class DeletePostEvent with _$DeletePostEvent {
  const factory DeletePostEvent.delete({
    required int id
}) = _Delete;
}
