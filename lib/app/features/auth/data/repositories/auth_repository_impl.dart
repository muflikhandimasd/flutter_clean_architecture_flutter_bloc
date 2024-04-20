import 'package:dartz/dartz.dart';
import 'package:flutter_clean/app/core/exceptions/exceptions.dart';
import 'package:flutter_clean/app/core/failure/failure.dart';
import 'package:flutter_clean/app/core/network_info/network_info.dart';
import 'package:flutter_clean/app/core/params/no_params.dart';
import 'package:flutter_clean/app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:flutter_clean/app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_clean/app/features/auth/data/params/login_params.dart';
import 'package:flutter_clean/app/features/auth/data/params/register_params.dart';
import 'package:flutter_clean/app/features/auth/domain/entities/user.dart';
import 'package:flutter_clean/app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDatasource _remoteDatasource;
  final AuthLocalDatasource _localDatasource;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl({
    required AuthRemoteDatasource remoteDatasource,
    required AuthLocalDatasource localDatasource,
    required NetworkInfo networkInfo
}): _remoteDatasource = remoteDatasource,
  _localDatasource = localDatasource,
  _networkInfo = networkInfo;
  @override
  Future<Either<Failure, User>> login(LoginParams params)async {

    if(await _networkInfo.isConnected){
      try{
        final result = await _remoteDatasource.login(params);
        await Future.wait([
          _localDatasource.cacheUser(result),
          _localDatasource.cacheToken(result.token),
        ]);
        return Right(result);
      } on ServerException catch(e){
        return Left(ServerFailure(message: e.message, code: e.code));
      }on CacheException{
        return Left(CacheFailure());
      }
    }else{
      return Left(NoInternetFailure());
    }

  }

  @override
  Future<Either<Failure, void>> logout(NoParams params) async {
    if(await _networkInfo.isConnected){
      try{
        final result = await _remoteDatasource.logout(params);
        await _localDatasource.logout();
        return Right(result);
      } on ServerException catch(e){
        return Left(ServerFailure(message: e.message, code: e.code));
      }on CacheException{
        return Left(CacheFailure());
      }
    }else{
      return Left(NoInternetFailure());
    }

  }

  @override
  Future<Either<Failure, User>> register(RegisterParams params) async {
    if(await _networkInfo.isConnected){

    }else{
      return Left(NoInternetFailure());
    }
    try{
      final result = await _remoteDatasource.register(params);
      await Future.wait([
        _localDatasource.cacheUser(result),
        _localDatasource.cacheToken(result.token),
      ]);
      return Right(result);
    } on ServerException catch(e){
      return Left(ServerFailure(message: e.message, code: e.code));
    }on CacheException{
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User?>> checkLogin(NoParams params)async {
   try{
     final user = await _localDatasource.getUser();
     return Right(user );
   } on CacheException catch(_){
     return Left(CacheFailure());
   }
  }

}