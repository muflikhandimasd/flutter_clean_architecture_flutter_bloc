import 'package:dartz/dartz.dart';
import 'package:flutter_clean/app/core/failure/failure.dart';
import 'package:flutter_clean/app/core/params/no_params.dart';
import 'package:flutter_clean/app/core/usecase/usecase.dart';
import 'package:flutter_clean/app/features/auth/domain/entities/message.dart';
import 'package:flutter_clean/app/features/posts/data/params/create_post_params.dart';
import 'package:flutter_clean/app/features/posts/domain/entities/post_response.dart';
import 'package:flutter_clean/app/features/posts/domain/repositories/post_repository.dart';

class CreatePostUsecase extends Usecase<Message, CreatePostParams>{
  final PostRepository _repository;

  CreatePostUsecase({
    required PostRepository repository
}) : _repository = repository;
  @override
  Future<Either<Failure, Message>> call(CreatePostParams params) {
   return _repository.createPost(params);
  }

}