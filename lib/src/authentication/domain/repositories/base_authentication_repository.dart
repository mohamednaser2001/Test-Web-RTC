

import 'package:order_now/core/error/failure.dart';
import 'package:order_now/src/authentication/domain/entities/register_success_entity.dart';
import 'package:order_now/src/authentication/domain/entities/user_entity.dart';
import 'package:order_now/src/authentication/domain/usecases/login_usecase.dart';
import 'package:order_now/src/authentication/domain/usecases/register_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class BaseAuthenticationRepository{

  Future<Either<Failure, UserEntity>> login(LoginParameters parameters);
  Future<Either<Failure, RegisterEntity>> register(RegisterParameter parameters);

}