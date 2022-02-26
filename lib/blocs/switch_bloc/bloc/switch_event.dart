part of 'switch_bloc.dart';

@immutable
abstract class SwitchEvent {}

class GetRoomSwitches extends SwitchEvent {
  final int roomId;
  GetRoomSwitches(this.roomId);
}

class AttachSwitchToRoom extends SwitchEvent {
  final String roomId;
  final String serial;
  final String deviceName;
  final String sub_1;
  final String sub_2;
  final String sub_3;
  AttachSwitchToRoom(this.roomId, this.serial, this.deviceName, this.sub_1, this.sub_2, this.sub_3);
}

class ChangeSwitchState extends SwitchEvent{
  final String? serial;
  final int? currentState;
  final String? state;
  ChangeSwitchState(this.serial , this.state , this.currentState);
}

class GetActiveSwitches extends SwitchEvent{}

