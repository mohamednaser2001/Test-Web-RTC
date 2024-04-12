
import 'package:order_now/core/network/error_message_model.dart';
import 'package:order_now/core/utils/enums.dart';
import 'package:order_now/src/authentication/domain/entities/register_success_entity.dart';
import 'package:equatable/equatable.dart';

class RegisterStates {

  final RequestState registerState;
  final RegisterEntity? registerModel;
  final ErrorMessageModel? errorModel;

  const RegisterStates({
    this.registerState= RequestState.none,
    this.errorModel,
    this.registerModel,
});


  RegisterStates copyWith({
  RequestState? registerState,
    ErrorMessageModel? errorModel,
    RegisterEntity? registerModel,
})=> RegisterStates(
    errorModel: errorModel ?? this.errorModel,
    registerModel: registerModel?? this.registerModel,
    registerState: registerState ?? this.registerState,
  );



}




