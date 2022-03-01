part of 'timer_bloc.dart';

@immutable
abstract class TimerEvent {}

class GetTimers extends TimerEvent{
  final String? switchId;
  GetTimers(this.switchId);
}

class SetTimers extends TimerEvent{
  final String? switchId;
  final String? roomId;
  final String? time;
  final String? stateNo;
  final int? state;

  SetTimers(this.switchId , this.roomId , this.time , this.state, this.stateNo);
  
}


class DeleteTimers extends TimerEvent{
  final String? timerId;
  DeleteTimers(this.timerId);
}