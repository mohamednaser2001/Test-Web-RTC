import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:order_now/core/methods/navigation_method.dart';
import 'package:order_now/core/utils/enums.dart';
import 'package:order_now/src/authentication/domain/usecases/login_usecase.dart';
import 'package:order_now/src/chat/presentation/screens/messages_screen.dart';

import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginStates> {

  LoginUseCase loginUseCase;
  LoginBloc({required this.loginUseCase}) : super(const LoginStates()){

    on<LoginEvent>(_login);
  }

  void _login(LoginEvent event, Emitter<LoginStates> emit) async{
    emit(state.copyWith(loginState: RequestState.loading));
    final result= await loginUseCase.call(LoginParameters(
        email: 'mohamed444444444@gmail.com',//event.email,
        password: 'event.password'
    ));

    result.fold(
            (l){
              print('emit error');
              emit(state.copyWith(loginState: RequestState.error, loginMessage: l.errorMessageModel.statusMessage));
            },
            (r) {
              print('emit success');
              print('emit $r');

              navigateWithoutBack(event.context, const MessagesScreen());
              emit(state.copyWith(loginState: RequestState.loaded, loginModel: r));
            },
    );
  }

}
