
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class InitialRegisterEvent extends Equatable{
const InitialRegisterEvent();

@override
  List<Object> get props =>[];
}

class RegisterEvent extends InitialRegisterEvent {
  final String email;
  final String password;
  final String name;
  // final String lName;
  // final String passwordConfirmation;
  // final String phone;
  final BuildContext context;

  const RegisterEvent({
    required this.name,
    // required this.lName,
    required this.email,
    // required this.phone,
    required this.password,
    // required this.passwordConfirmation,
    required this.context,
  });
}


