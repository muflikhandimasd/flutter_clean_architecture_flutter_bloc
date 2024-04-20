import 'package:dartz/dartz.dart';
import 'package:flutter_clean/app/core/failure/failure.dart';
import 'package:flutter_clean/app/core/usecase/usecase.dart';
import 'package:flutter_clean/app/features/auth/domain/entities/message.dart';
import 'package:flutter_clean/app/features/posts/data/params/update_post_params.dart';
import 'package:flutter_clean/app/features/posts/domain/repositories/post_repository.dart';

class UpdatePostUsecase extends Usecase<Message, UpdatePostParams>{
  final PostRepository _repository;

  UpdatePostUsecase({
    required PostRepository repository
}) : _repository = repository;
  @override
  Future<Either<Failure, Message>> call(UpdatePostParams params) {
   return _repository.updatePost(params);
  }

}