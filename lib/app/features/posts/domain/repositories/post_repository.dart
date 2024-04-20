import 'package:dartz/dartz.dart';
import 'package:flutter_clean/app/core/failure/failure.dart';
import 'package:flutter_clean/app/core/params/no_params.dart';
import 'package:flutter_clean/app/features/auth/domain/entities/message.dart';
import 'package:flutter_clean/app/features/posts/data/params/create_post_params.dart';
import 'package:flutter_clean/app/features/posts/data/params/delete_post_params.dart';
import 'package:flutter_clean/app/features/posts/data/params/update_post_params.dart';
import 'package:flutter_clean/app/features/posts/domain/entities/post_response.dart';

abstract class PostRepository{
  Future<Either<Failure,PostResponse>> getPosts(NoParams params);
  Future<Either<Failure,Message>> createPost(CreatePostParams params);
  Future<Either<Failure,Message>> updatePost(UpdatePostParams params);
  Future<Either<Failure,Message>> deletePost(DeletePostParams params);
}