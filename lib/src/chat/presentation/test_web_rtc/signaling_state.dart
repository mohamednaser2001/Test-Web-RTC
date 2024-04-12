part of 'signaling_cubit.dart';

@immutable
abstract class SignalingStates {}

class SignalingInitialState extends SignalingStates {}

class JoinMeetingState extends SignalingStates {}
class CreateRoomState extends SignalingStates {}
class ToggleMicState extends SignalingStates {}
class ToggleCameraState extends SignalingStates {}
class PeerDisconnectState extends SignalingStates {}
class ListenOnEventState extends SignalingStates {}

class ListenForMicState extends SignalingStates {}
class ListenForCameraState extends SignalingStates {}
