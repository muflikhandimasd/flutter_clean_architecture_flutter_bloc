import 'package:dartz/dartz.dart';
import 'package:flutter_clean/app/core/failure/failure.dart';
import 'package:flutter_clean/app/core/usecase/usecase.dart';
import 'package:flutter_clean/app/features/auth/data/params/login_params.dart';
import 'package:flutter_clean/app/features/auth/domain/entities/user.dart';
import 'package:flutter_clean/app/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase extends Usecase<User, LoginParams>{
  final AuthRepository _repository;

  LoginUsecase({
    required AuthRepository repository
}): _repository = repository;

  @override
  Future<Either<Failure, User>> call(LoginParams params) {
    return _repository.login(params);
  }
}