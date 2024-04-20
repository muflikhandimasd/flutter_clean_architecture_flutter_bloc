import 'package:dartz/dartz.dart';
import 'package:flutter_clean/app/core/failure/failure.dart';
import 'package:flutter_clean/app/core/usecase/usecase.dart';
import 'package:flutter_clean/app/features/auth/domain/entities/message.dart';
import 'package:flutter_clean/app/features/posts/data/params/delete_post_params.dart';
import 'package:flutter_clean/app/features/posts/domain/repositories/post_repository.dart';

class DeletePostUsecase extends Usecase<Message, DeletePostParams>{
  final PostRepository _repository;

  DeletePostUsecase({
    required PostRepository repository
}) : _repository = repository;
  @override
  Future<Either<Failure, Message>> call(DeletePostParams params) {
   return _repository.deletePost(params);
  }

}