import 'package:bloc/bloc.dart';
import 'package:flutter_clean/app/features/posts/data/params/update_post_params.dart';
import 'package:flutter_clean/app/features/posts/domain/usecases/update_post_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_post_event.dart';
part 'update_post_state.dart';
part 'update_post_bloc.freezed.dart';

class UpdatePostBloc extends Bloc<UpdatePostEvent, UpdatePostState> {
  final UpdatePostUsecase _updatePostUsecase;
  UpdatePostBloc(this._updatePostUsecase) : super(const UpdatePostState.initial()) {

    on<UpdatePostEvent>((event, emit)async {
      event.maybeWhen(
        update: (id, title, body)async {
          emit(UpdatePostState.loading());
          final result = await _updatePostUsecase(UpdatePostParams(title: title, body: body, id: id));
          result.fold((l) => UpdatePostState.error(l.message), (r) => UpdatePostState.success(r.message));
        },
        orElse: () {

      },);

    });
  }
}
