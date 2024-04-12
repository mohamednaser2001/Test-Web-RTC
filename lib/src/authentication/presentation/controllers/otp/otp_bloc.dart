import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'otp_event.dart';
import 'otp_state.dart';


class OtpBloc extends Cubit<OtpStates> {
  OtpBloc() : super(OtpInitialState());


  late Timer timer;
  String remainingTime = '09:59';
  bool isResendButtonActive= false;

  FutureOr<void> startTimer() {
    int seconds = 5;
    int minutes= 0;
    isResendButtonActive= false;

    timer = Timer.periodic(const Duration(seconds: 1), (timer){

      if (seconds == 1) {
        if (minutes == 0) {
          timer.cancel();
          remainingTime = '00:00';
          isResendButtonActive= true;
          emit(ChangeTimerState());
          return;
        } else {
          minutes--;
        }
      }
      seconds--;
      if (seconds == 0) {
        seconds = 59;
      }

      remainingTime =
      '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

      emit(ChangeTimerState());
    });
  }




}
