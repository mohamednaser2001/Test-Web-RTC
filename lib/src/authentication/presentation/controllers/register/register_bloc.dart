import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:order_now/configrations/routes/app_routes.dart';
import 'package:order_now/core/adapter/error_adapter.dart';
import 'package:order_now/core/methods/navigation_method.dart';
import 'package:order_now/core/methods/show_snackbar.dart';
import 'package:order_now/core/utils/enums.dart';
import 'package:order_now/src/authentication/data/models/register_success_model.dart';
import 'package:order_now/src/authentication/domain/entities/register_success_entity.dart';
import 'package:order_now/src/authentication/domain/usecases/login_usecase.dart';
import 'package:order_now/src/authentication/domain/usecases/register_usecase.dart';
import 'package:order_now/src/authentication/presentation/controllers/register/register_event.dart';
import 'package:order_now/src/authentication/presentation/controllers/register/register_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterStates> {

  RegisterUseCase registerUseCase;
  RegisterBloc({required this.registerUseCase}) : super(const RegisterStates()){

    on<RegisterEvent>(_register);
  }

  void _register(RegisterEvent event, Emitter<RegisterStates> emit) async{
    emit(state.copyWith(registerState: RequestState.loading));
    final result= await registerUseCase.call(
        const RegisterParameter(
            name: 'event.name',
            // lastName: event.lName,
            // phone: event.phone,
            email: 'mohamed444444444@gmail.com',//event.email,
            password: 'event.password',
        ));

    print('------res ${result}');
    result.fold(
            (l){
              showSnackBar(
                  context:  event.context,
                  // text: l.errorMessageModel.statusMessage!,
                  title: l.errorMessageModel.statusMessage!,
                  responseState: ResponseState.error
              );
              emit(state.copyWith(registerState: RequestState.error, errorModel: l.errorMessageModel));

            },
            (r) {
              showSnackBar(
                  context:  event.context,
                  title: r.message,
                  text: 'You have been create an account, check your email',
                  responseState: ResponseState.success,
              );
              emit(state.copyWith(registerState: RequestState.loaded, registerModel: r));
              Navigator.pushNamed(event.context, Routes.otpRoute);
            },
    );
  }

}
