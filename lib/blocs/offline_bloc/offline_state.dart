part of 'offline_bloc.dart';

@immutable
abstract class OfflineState {}

class OfflineInitial extends OfflineState {}

class GetOfflineActiveSwitchesLoadingState extends OfflineState{}
class GetOfflineActiveSwitchesLoadedState extends OfflineState{
  final List<Switch> switches;
  GetOfflineActiveSwitchesLoadedState(this.switches);
}
class GetOfflineActiveSwitchesErorrState extends OfflineState{}

class GetOfflineSwitchesLoadingState extends OfflineState{}
class GetOfflineSwitchesLoadedState extends OfflineState{
  final List<Switch> switches;
  GetOfflineSwitchesLoadedState(this.switches);
}
class GetOfflineSwitchesErorrState extends OfflineState{}