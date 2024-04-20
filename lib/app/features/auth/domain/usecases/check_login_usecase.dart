import 'package:dartz/dartz.dart';
import 'package:flutter_clean/app/core/failure/failure.dart';
import 'package:flutter_clean/app/core/params/no_params.dart';
import 'package:flutter_clean/app/core/usecase/usecase.dart';
import 'package:flutter_clean/app/features/auth/domain/entities/user.dart';
import 'package:flutter_clean/app/features/auth/domain/repositories/auth_repository.dart';

class CheckLoginUsecase extends Usecase<User?, NoParams>{
  final AuthRepository _repository;

  CheckLoginUsecase({
    required AuthRepository repository
}): _repository = repository;

  @override
  Future<Either<Failure, User?>> call(NoParams params) {
    return _repository.checkLogin(params);
  }
}