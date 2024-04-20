import 'package:dio/dio.dart';
import 'package:flutter_clean/app/core/api/api.dart';
import 'package:flutter_clean/app/core/exceptions/exceptions.dart';
import 'package:flutter_clean/app/core/failure/failure.dart';
import 'package:flutter_clean/app/core/helpers/cekMap.dart';
import 'package:flutter_clean/app/core/helpers/get_data_map.dart';
import 'package:flutter_clean/app/core/helpers/get_error_message.dart';
import 'package:flutter_clean/app/core/params/no_params.dart';
import 'package:flutter_clean/app/features/auth/data/models/user_model.dart';
import 'package:flutter_clean/app/features/auth/data/params/login_params.dart';
import 'package:flutter_clean/app/features/auth/data/params/register_params.dart';
import 'package:flutter_clean/app/features/auth/domain/entities/user.dart';


abstract class AuthRemoteDatasource{
  const AuthRemoteDatasource();
  Future<User> login(LoginParams params);
  Future<User> register(RegisterParams params);
  Future<void> logout(NoParams params);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource{
  final Api _api;

  const AuthRemoteDatasourceImpl({
    required Api api
}): _api=api;


  @override
  Future<User> login(LoginParams params) async{
  try{
    const url ='/auth/login';
    final response = await _api.post(url, data: params.toJson());
    final dataMap = getDataMap(response);
    final result = UserModel.fromJson(cekMap(dataMap, 'user')?? <String,dynamic>{},token: cekMap(dataMap, 'token') ?? '');
    return result;
  } on DioException catch(e){
    throw ServerException(message: getErrorMessage(e), code: e.response?.statusCode?? statusInternal);
  }
  }

  @override
  Future<void> logout(NoParams params)async{
    try{
      const url ='/auth/logout';
       await _api.post(url);

    } on DioException catch(e){
      throw ServerException(message: getErrorMessage(e), code: e.response?.statusCode?? statusInternal);
    }
  }

  @override
  Future<User> register(RegisterParams params)async{
    try{
      const url ='/auth/register';
      final response = await _api.post(url, data: params.toJson());
      final dataMap = getDataMap(response);
      final result = UserModel.fromJson(cekMap(dataMap, 'user')?? <String,dynamic>{},token: cekMap(dataMap, 'token') ?? '');
      return result;
    } on DioException catch(e){
      throw ServerException(message: getErrorMessage(e), code: e.response?.statusCode?? statusInternal);
    }
  }

}