part of 'switch_bloc.dart';

@immutable
abstract class SwitchState {}

class SwitchInitial extends SwitchState {}

class GetRoomSwitchesLoadingState extends SwitchState{}
class GetRoomSwitchesLoadedState extends SwitchState{
    final List<Switch> switches;
  GetRoomSwitchesLoadedState(this.switches);
}
class GetRoomSwitchesErorrState extends SwitchState{
  final String message;
  GetRoomSwitchesErorrState(this.message);
}

class GetActiveSwitchesLoadingState extends SwitchState{}
class GetActiveSwitchesLoadedState extends SwitchState{
  final List<Switch> switches;
  GetActiveSwitchesLoadedState(this.switches);
}
class GetActiveSwitchesErorrState extends SwitchState{
    final String message;
  GetActiveSwitchesErorrState(this.message);
}

class AttachSwitchToRoomLoadingState extends SwitchState{}
class AttachSwitchToRoomLoadedState extends SwitchState{}
class AttachSwitchToRoomErorrState extends SwitchState{
    final String message;
  AttachSwitchToRoomErorrState(this.message);
}