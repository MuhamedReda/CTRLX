part of 'timer_bloc.dart';

@immutable
abstract class TimerState {}

class TimerInitial extends TimerState {}

class GetTimerLoadingState extends TimerState{}
class GetTimerLoadedState extends TimerState{
  final List<Timer> timers;
  GetTimerLoadedState(this.timers);
}
class GetTimerErorrState extends TimerState{}

class SetTimerLoadingState extends TimerState{}
class SetTimerLoadedState extends TimerState{}
class SetTimerErorrState extends TimerState{}

class DeleteTimerLoadingState extends TimerState{}
class DeleteTimerLoadedState extends TimerState{}
class DeleteTimerErorrState extends TimerState{}