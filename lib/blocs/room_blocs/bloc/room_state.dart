part of 'room_bloc.dart';

@immutable
abstract class RoomState {}

class RoomInitial extends RoomState {}

class AddRoomLoadingState extends RoomState{}
class DeleteRoomLoadingState extends RoomState{}
class GetRoomLoadingState extends RoomState{}

class AddRoomLoadedState extends RoomState{}

class DeleteRoomLoadedState extends RoomState{
  final String name ;
  DeleteRoomLoadedState(this.name);
}
class GetRoomLoadedState extends RoomState{
  final List<Room> rooms;
  GetRoomLoadedState(this.rooms);
}

class AddRoomErrorState extends RoomState{
  final String message;
  AddRoomErrorState(this.message);
}
class DeleteRoomErrorState extends RoomState{
  final String message;
  DeleteRoomErrorState(this.message);
}
class GetRoomErorrState extends RoomState{
  final String message;
  GetRoomErorrState(this.message);
}