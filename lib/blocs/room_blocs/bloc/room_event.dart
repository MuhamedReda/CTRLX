part of 'room_bloc.dart';

@immutable
abstract class RoomEvent {}

class GetRooms extends RoomEvent{}

class DeleteRoom extends RoomEvent{
  final String roomId;
  DeleteRoom(this.roomId);
}
class AddRoom extends RoomEvent{
  final XFile? img;
  final String roomname;
  AddRoom(this.roomname , this.img);
}