import 'package:dartz/dartz.dart';
import 'package:flutter_clean/app/core/failure/failure.dart';
import 'package:flutter_clean/app/core/usecase/usecase.dart';
import 'package:flutter_clean/app/features/auth/data/params/register_params.dart';
import 'package:flutter_clean/app/features/auth/domain/entities/user.dart';
import 'package:flutter_clean/app/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase extends Usecase<User, RegisterParams>{
  final AuthRepository _repository;

 RegisterUsecase({
    required AuthRepository repository
}): _repository = repository;

  @override
  Future<Either<Failure, User>> call(RegisterParams params) {
    return _repository.register(params);
  }
}