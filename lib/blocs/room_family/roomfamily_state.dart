part of 'roomfamily_bloc.dart';

@immutable
abstract class RoomfamilyState {}

class RoomfamilyInitial extends RoomfamilyState {}

class GetRoomFamilyLoadingState extends RoomfamilyState{}

class GetRoomFamilyLoadedState extends RoomfamilyState{
  final List<FamilyMember> family;
  GetRoomFamilyLoadedState(this.family);
}

class GetRoomFamilyErorrState extends RoomfamilyState{
  final String message;
  GetRoomFamilyErorrState(this.message);
}

class AttachUserToRoomLoadingState extends RoomfamilyState {}
class AttachUserToRoomLoadedState extends RoomfamilyState {}
class AttachUserToRoomErorrState extends RoomfamilyState {}
