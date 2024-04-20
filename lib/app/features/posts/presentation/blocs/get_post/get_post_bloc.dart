import 'package:bloc/bloc.dart';
import 'package:flutter_clean/app/core/params/no_params.dart';
import 'package:flutter_clean/app/features/posts/domain/entities/post.dart';
import 'package:flutter_clean/app/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_post_event.dart';
part 'get_post_state.dart';
part 'get_post_bloc.freezed.dart';

class GetPostBloc extends Bloc<GetPostEvent, GetPostState> {
  final GetPostsUsecase _getPostsUsecase;
  GetPostBloc(this._getPostsUsecase) : super(const GetPostState.initial()) {
    on<GetPostEvent>((event, emit)  {
      event.maybeWhen(
        started: () async{
          emit(GetPostState.loading());
          final result = await _getPostsUsecase(NoParams());
          result.fold((l) => emit(GetPostState.error(l.message)), (r) => emit(GetPostState.loaded(r.posts)));
        },
        orElse: () {

      },);

    });
  }
}
