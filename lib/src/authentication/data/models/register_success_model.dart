


import 'package:order_now/src/authentication/domain/entities/register_success_entity.dart';

class RegisterModel extends RegisterEntity{
  const RegisterModel({
    required super.token,
    required super.message,
    required super.email,
});


  factory RegisterModel.fromJson(Map<String, dynamic> json)
  => RegisterModel(
      token: json['token'],
      email: json['user']['email'],
      message: json['message'],
  );

}