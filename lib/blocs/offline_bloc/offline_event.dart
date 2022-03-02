part of 'offline_bloc.dart';

@immutable
abstract class OfflineEvent {}

class GetOfflineActive extends OfflineEvent{
  
}
class GetOffline extends OfflineEvent{
  final String serial;
  GetOffline(this.serial);
}