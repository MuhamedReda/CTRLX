part of 'roomfamily_bloc.dart';

@immutable
abstract class RoomfamilyEvent {}

class GetRoomFamily extends RoomfamilyEvent {
  final String roomId;
  GetRoomFamily(this.roomId);
}

class AttachUserToRoom extends RoomfamilyEvent {
  final String roomId;
  final String userId;
  AttachUserToRoom(this.roomId , this.userId);
}