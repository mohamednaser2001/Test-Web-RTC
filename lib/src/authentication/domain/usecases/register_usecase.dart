

import 'package:order_now/core/error/failure.dart';
import 'package:order_now/core/usecase/base_usecase.dart';
import 'package:order_now/src/authentication/domain/entities/register_success_entity.dart';
import 'package:order_now/src/authentication/domain/repositories/base_authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUseCase extends BaseUseCase<RegisterEntity, RegisterParameter>{

  final BaseAuthenticationRepository authenticationRepository;

  RegisterUseCase({required this.authenticationRepository});

  @override
  Future<Either<Failure, RegisterEntity>> call(parameters)async {
    return await authenticationRepository.register(parameters);
  }

}

class RegisterParameter extends Equatable{
  final String name;
  // final String lastName;
  // final String phone;
  final String email;
  final String password;

  const RegisterParameter({
    required this.name,
    // required this.lastName,
    // required this.phone,
    required this.email,
    required this.password,});

  @override
  List<Object?> get props => [name, email, password];


}