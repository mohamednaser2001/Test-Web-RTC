
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class InitialLoginEvent extends Equatable{
const InitialLoginEvent();

@override
  List<Object> get props =>[];
}

class LoginEvent extends InitialLoginEvent {
  final String email;
  final String password;
  final BuildContext context;

  const LoginEvent({required this.email, required this.password, required this.context});
}


