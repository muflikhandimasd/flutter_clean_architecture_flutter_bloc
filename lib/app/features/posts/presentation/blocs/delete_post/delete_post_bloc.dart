import 'package:bloc/bloc.dart';
import 'package:flutter_clean/app/features/posts/data/params/delete_post_params.dart';
import 'package:flutter_clean/app/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_post_event.dart';
part 'delete_post_state.dart';
part 'delete_post_bloc.freezed.dart';

class DeletePostBloc extends Bloc<DeletePostEvent, DeletePostState> {
  final DeletePostUsecase _deletePostUsecase;
  DeletePostBloc(this._deletePostUsecase) : super(const DeletePostState.initial()) {
    on<DeletePostEvent>((event, emit) async{
      event.maybeWhen(
        delete: (id)async {
          emit(const DeletePostState.loading());
          final result = await _deletePostUsecase(DeletePostParams(id: id));
          result.fold((l) => emit(DeletePostState.error(l.message)), (r) => emit(DeletePostState.success(r.message)));
        },
        orElse: () {

      },);

    });
  }
}
