
import 'package:order_now/core/utils/enums.dart';
import 'package:order_now/src/authentication/domain/entities/register_success_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:order_now/src/authentication/domain/entities/user_entity.dart';
import 'package:order_now/src/authentication/domain/entities/user_entity.dart';

class LoginStates extends Equatable {

  final RequestState loginState;
  final UserEntity? loginModel;
  final String loginMessage;

  const LoginStates({
    this.loginState= RequestState.none,
    this.loginMessage= '',
    this.loginModel,
});


  LoginStates copyWith({
  RequestState? loginState,
    String? loginMessage,
    UserEntity? loginModel,
})=> LoginStates(
    loginMessage: loginMessage ?? this.loginMessage,
    loginModel: loginModel?? this.loginModel,
    loginState: loginState ?? this.loginState,
  );


  @override
  List<Object> get props => [loginMessage, loginState, ];

}




