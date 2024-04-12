

import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable{

  final String? token;
  final String message;
  final String email;


  const RegisterEntity({
    required this.token,
    required this.message,
    required this.email,
  });

  @override
  List<Object?> get props => [
    token,
    email,
    message];
}