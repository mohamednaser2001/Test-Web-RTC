


import 'package:order_now/src/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  const UserModel({
    required super.token,
    required super.phone,
    required super.email,
    required super.id,
    required super.image,
    required super.name,
  });



  factory UserModel.fromJson(Map<String, dynamic> json)
  => UserModel(
    token: json['token'],
    id : json['user']['_id'],
    name : json['user']['name'],
    email : json['user']['email'],
    phone : json['user']['phone'],
    image : json['user']['image'],
  );

}