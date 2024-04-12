

import 'package:order_now/core/error/failure.dart';
import 'package:order_now/core/usecase/base_usecase.dart';
import 'package:order_now/src/authentication/domain/entities/register_success_entity.dart';
import 'package:order_now/src/authentication/domain/entities/user_entity.dart';
import 'package:order_now/src/authentication/domain/entities/user_entity.dart';
import 'package:order_now/src/authentication/domain/repositories/base_authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginUseCase extends BaseUseCase<UserEntity, LoginParameters>{

  final BaseAuthenticationRepository authenticationRepository;

  LoginUseCase({required this.authenticationRepository});


  @override
  Future<Either<Failure, UserEntity>> call(LoginParameters parameters) async {
    return await authenticationRepository.login(parameters);
  }
}


class LoginParameters extends Equatable {
  final String email;
  final String password;
  const LoginParameters({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}