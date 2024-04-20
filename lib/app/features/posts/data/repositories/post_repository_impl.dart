import 'package:dartz/dartz.dart';
import 'package:flutter_clean/app/core/exceptions/exceptions.dart';
import 'package:flutter_clean/app/core/failure/failure.dart';
import 'package:flutter_clean/app/core/network_info/network_info.dart';
import 'package:flutter_clean/app/core/params/no_params.dart';
import 'package:flutter_clean/app/features/auth/domain/entities/message.dart';
import 'package:flutter_clean/app/features/posts/data/datasources/post_remote_datasource.dart';
import 'package:flutter_clean/app/features/posts/data/params/create_post_params.dart';
import 'package:flutter_clean/app/features/posts/data/params/delete_post_params.dart';
import 'package:flutter_clean/app/features/posts/data/params/update_post_params.dart';
import 'package:flutter_clean/app/features/posts/domain/entities/post_response.dart';
import 'package:flutter_clean/app/features/posts/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository{
  final PostRemoteDatasource _remoteDatasource;
  final NetworkInfo _networkInfo;

  PostRepositoryImpl({
    required PostRemoteDatasource remoteDatasource,
    required NetworkInfo networkInfo,

}): _remoteDatasource = remoteDatasource,
  _networkInfo = networkInfo;
  @override
  Future<Either<Failure, Message>> createPost(CreatePostParams params) async{
    if(await _networkInfo.isConnected){
      try{
        final result = await _remoteDatasource.createPost(params);
        return Right(result);
      } on ServerException catch(e){
        return Left(ServerFailure(message: e.message, code: e.code));
      }
    }else{
      return Left(NoInternetFailure());
    }

  }

  @override
  Future<Either<Failure, Message>> deletePost(DeletePostParams params) async{
    if(await _networkInfo.isConnected){
      try{
        final result = await _remoteDatasource.deletePost(params);
        return Right(result);
      } on ServerException catch(e){
        return Left(ServerFailure(message: e.message, code: e.code));
      }
    }else{
      return Left(NoInternetFailure());
    }

  }

  @override
  Future<Either<Failure, PostResponse>> getPosts(NoParams params) async{
    if(await _networkInfo.isConnected){
      try{
        final result = await _remoteDatasource.getPosts(params);
        return Right(result);
      } on ServerException catch(e){
        return Left(ServerFailure(message: e.message, code: e.code));
      }
    }else{
      return Left(NoInternetFailure());
    }

  }

  @override
  Future<Either<Failure, Message>> updatePost(UpdatePostParams params) async{
    if(await _networkInfo.isConnected){
      try{
        final result = await _remoteDatasource.updatePost(params);
        return Right(result);
      } on ServerException catch(e){
        return Left(ServerFailure(message: e.message, code: e.code));
      }
    }else{
      return Left(NoInternetFailure());
    }

  }

}