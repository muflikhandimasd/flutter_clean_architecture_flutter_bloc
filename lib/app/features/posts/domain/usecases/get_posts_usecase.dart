import 'package:dartz/dartz.dart';
import 'package:flutter_clean/app/core/failure/failure.dart';
import 'package:flutter_clean/app/core/params/no_params.dart';
import 'package:flutter_clean/app/core/usecase/usecase.dart';
import 'package:flutter_clean/app/features/posts/domain/entities/post_response.dart';
import 'package:flutter_clean/app/features/posts/domain/repositories/post_repository.dart';

class GetPostsUsecase extends Usecase<PostResponse, NoParams>{
  final PostRepository _repository;

  GetPostsUsecase({
    required PostRepository repository
}) : _repository = repository;
  @override
  Future<Either<Failure, PostResponse>> call(NoParams params) {
   return _repository.getPosts(params);
  }

}