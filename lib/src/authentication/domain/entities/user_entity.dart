

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{

  final String? token;
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? image;

  const UserEntity({
    required this.token,
    required this.phone,
    required this.email,
    required this.id,
    required this.image,
    required this.name,
  });

  @override
  List<Object?> get props => [
    token,
    phone,
    email,
    id,
    image,
    name,
  ];
}