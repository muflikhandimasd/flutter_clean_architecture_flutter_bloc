import 'package:dio/dio.dart';
import 'package:flutter_clean/app/core/api/api.dart';
import 'package:flutter_clean/app/core/exceptions/exceptions.dart';
import 'package:flutter_clean/app/core/failure/failure.dart';
import 'package:flutter_clean/app/core/helpers/get_data_map.dart';
import 'package:flutter_clean/app/core/helpers/get_error_message.dart';
import 'package:flutter_clean/app/core/params/no_params.dart';
import 'package:flutter_clean/app/features/auth/data/models/message_model.dart';
import 'package:flutter_clean/app/features/auth/domain/entities/message.dart';
import 'package:flutter_clean/app/features/posts/data/models/post_response_model.dart';
import 'package:flutter_clean/app/features/posts/data/params/create_post_params.dart';
import 'package:flutter_clean/app/features/posts/data/params/delete_post_params.dart';
import 'package:flutter_clean/app/features/posts/data/params/update_post_params.dart';
import 'package:flutter_clean/app/features/posts/domain/entities/post_response.dart';

abstract class PostRemoteDatasource{
  Future<PostResponse> getPosts(NoParams params);
  Future<Message> createPost(CreatePostParams params);
  Future<Message> updatePost(UpdatePostParams params);
  Future<Message> deletePost(DeletePostParams params);
}

class PostRemoteDatasourceImpl implements PostRemoteDatasource{
  final Api _api;
  PostRemoteDatasourceImpl({
    required Api api
}) : _api = api;
  @override
  Future<Message> createPost(CreatePostParams params)async{
    try{
      const url ='/posts';
      final response = await _api.post(url, data: params.toJson());
      final result = MessageModel.fromJson(response.data);
      return result;
    } on DioException catch(e){
      throw ServerException(message: getErrorMessage(e), code: e.response?.statusCode?? statusInternal);
    }
  }

  @override
  Future<Message> deletePost(DeletePostParams params) async{
    try{
      final url ='/posts/${params.id}';
      final response = await _api.delete(url,);
      final result = MessageModel.fromJson(response.data);
      return result;
    } on DioException catch(e){
      throw ServerException(message: getErrorMessage(e), code: e.response?.statusCode?? statusInternal);
    }
  }


  @override
  Future<PostResponse> getPosts(NoParams params)async{
    try{
      const url ='/posts';
      final response = await _api.get(url,);
      final result = PostResponseModel.fromJson(getDataMap(response));
      return result;
    } on DioException catch(e){
      throw ServerException(message: getErrorMessage(e), code: e.response?.statusCode?? statusInternal);
    }
  }

  @override
  Future<Message> updatePost(UpdatePostParams params) async{
    try{
      final url ='/posts/${params.id}';
      final response = await _api.put(url,data: params.toJson());
      final result = MessageModel.fromJson(response.data);
      return result;
    } on DioException catch(e){
      throw ServerException(message: getErrorMessage(e), code: e.response?.statusCode?? statusInternal);
    }
  }

}