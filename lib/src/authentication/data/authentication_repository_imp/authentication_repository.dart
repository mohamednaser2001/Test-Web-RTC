

import 'package:order_now/core/error/exceptions.dart';
import 'package:order_now/core/error/failure.dart';
import 'package:order_now/src/authentication/data/authentication_datasource/authentication_remote_datasource.dart';
import 'package:order_now/src/authentication/domain/entities/register_success_entity.dart';
import 'package:order_now/src/authentication/domain/entities/user_entity.dart';
import 'package:order_now/src/authentication/domain/repositories/base_authentication_repository.dart';
import 'package:order_now/src/authentication/domain/usecases/login_usecase.dart';
import 'package:order_now/src/authentication/domain/usecases/register_usecase.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImp extends BaseAuthenticationRepository{

  BaseAuthenticationRemoteDataSource authenticationRemoteDataSource;

  AuthenticationRepositoryImp({required this.authenticationRemoteDataSource});


  @override
  Future<Either<Failure, UserEntity>> login(LoginParameters parameters) async{

    try{
      final result= await authenticationRemoteDataSource.login(parameters);
      return Right(result);

    } on ServerException catch(failure){
      return Left(ServerFailure(errorMessageModel: failure.errorMessageModel));
    }
  }



  @override
  Future<Either<Failure, RegisterEntity>> register(RegisterParameter parameters) async {
    try{
      final result= await authenticationRemoteDataSource.register(parameters);
      return Right(result);

    } on ServerException catch(failure){
      print('================rr failer ${failure.errorMessageModel}');
      return Left(ServerFailure( errorMessageModel: failure.errorMessageModel));
    }
  }

}