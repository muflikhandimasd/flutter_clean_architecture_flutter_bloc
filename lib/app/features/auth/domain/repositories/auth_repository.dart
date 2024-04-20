import 'package:dartz/dartz.dart';
import 'package:flutter_clean/app/core/failure/failure.dart';
import 'package:flutter_clean/app/core/params/no_params.dart';
import 'package:flutter_clean/app/features/auth/data/params/login_params.dart';
import 'package:flutter_clean/app/features/auth/data/params/register_params.dart';
import 'package:flutter_clean/app/features/auth/domain/entities/user.dart';

abstract class AuthRepository{
  Future<Either<Failure,User>> login(LoginParams params);
  Future<Either<Failure,User>> register(RegisterParams params);
  Future<Either<Failure,void>> logout(NoParams params);
  Future<Either<Failure,User?>> checkLogin(NoParams params);
}