import 'package:bloc/bloc.dart';
import 'package:flutter_clean/app/features/posts/data/params/create_post_params.dart';
import 'package:flutter_clean/app/features/posts/domain/usecases/create_post_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';
part 'create_post_bloc.freezed.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final CreatePostUsecase _createPostUsecase;
  CreatePostBloc(this._createPostUsecase) : super(const CreatePostState.initial()) {
    on<CreatePostEvent>((event, emit)async {
      event.maybeWhen(
        create: (title, body) async{
          emit(CreatePostState.loading());
          final result = await _createPostUsecase(CreatePostParams(title: title, body: body));
          result.fold((l) => emit(CreatePostState.error(l.message)), (r) => CreatePostState.success(r.message));
        },
        orElse: () {

      },);

    });
  }
}
