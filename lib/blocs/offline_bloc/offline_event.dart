part of 'offline_bloc.dart';

@immutable
abstract class OfflineEvent {}

class GetOfflineActive extends OfflineEvent{
  
}
class GetOffline extends OfflineEvent{
  
}

class ChangeOfflineswitchStateEvent extends OfflineEvent{
  final String serial;
  final String pin;
  final String state;
  ChangeOfflineswitchStateEvent(this.serial , this.pin , this.state);
}