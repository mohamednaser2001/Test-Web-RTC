

import 'dart:convert';

import 'package:order_now/core/error/exceptions.dart';
import 'package:order_now/core/network/crud.dart';
import 'package:order_now/core/network/error_message_model.dart';
import 'package:order_now/src/authentication/data/models/register_success_model.dart';
import 'package:order_now/src/authentication/data/models/user_model.dart';
import 'package:order_now/src/authentication/domain/usecases/login_usecase.dart';
import 'package:order_now/src/authentication/domain/usecases/register_usecase.dart';

abstract class BaseAuthenticationRemoteDataSource{

  Future<UserModel> login(LoginParameters parameters);
  Future<RegisterModel> register(RegisterParameter parameters);
}


class AuthenticationRemoteDataSourceImp extends BaseAuthenticationRemoteDataSource{

  Crud crud= Crud();


  @override
  Future<UserModel> login(LoginParameters parameters) async {

    final response= await crud.postData(
        url: 'https://create-chat-api.onrender.com/api/users/login',
        data: {
          'email': parameters.email,
          'password': parameters.password,
        });

    Map<String, dynamic> re= jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(re);
      } else {
        throw ServerException(
            errorMessageModel: ErrorMessageModel.fromJson(re));
      }
  }

  @override
  Future<RegisterModel> register(RegisterParameter parameters) async {

    final response= await crud.postData(
        url: 'https://create-chat-api.onrender.com/api/users/register',
        data: {
          'email': parameters.email,
          'name': parameters.name,
          // 'lname': parameters.lastName,
          // 'phone': parameters.phone,
          'password': parameters.password,
          // 'password_confirmation': parameters.passwordConfirmation,
          // 'username': 'aa123154785',
        });

    Map<String, dynamic> re= jsonDecode(response.body);

    print('=================rr $re');
    print('=================rr ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegisterModel.fromJson(re);
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(re));
    }
  }


}