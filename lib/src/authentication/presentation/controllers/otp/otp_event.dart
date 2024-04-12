

abstract class OtpEvents{}

class VerifyOtpEvent extends OtpEvents{}
class StartTimerEvent extends OtpEvents{
  final int timerMinutes;

  StartTimerEvent({required this.timerMinutes});
}
