import 'package:dartz/dartz.dart';
import 'package:flutter_clean/app/core/failure/failure.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
