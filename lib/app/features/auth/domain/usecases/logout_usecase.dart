import 'package:dartz/dartz.dart';
import 'package:flutter_clean/app/core/failure/failure.dart';
import 'package:flutter_clean/app/core/params/no_params.dart';
import 'package:flutter_clean/app/core/usecase/usecase.dart';
import 'package:flutter_clean/app/features/auth/data/params/login_params.dart';
import 'package:flutter_clean/app/features/auth/domain/entities/user.dart';
import 'package:flutter_clean/app/features/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase extends Usecase<void, NoParams>{
  final AuthRepository _repository;

  LogoutUsecase({
    required AuthRepository repository
}): _repository = repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return _repository.logout(params);
  }
}