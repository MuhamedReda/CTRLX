import 'package:bloc/bloc.dart';
import 'package:ctrlx/data/models/room.dart';
import 'package:ctrlx/data/repositries/rooms_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomsRepo roomsRepo;
  RoomBloc(this.roomsRepo) : super(RoomInitial());

  @override
  Stream<RoomState> mapEventToState(
    RoomEvent event,
  ) async* {
    if(event is GetRooms){
      yield GetRoomLoadingState();
      try{
        var data = await roomsRepo.getAllRooms();
        yield GetRoomLoadedState(data);
      }catch(e){
        yield GetRoomErorrState("Something went wrong ...");
      }
    }else if(event is DeleteRoom){
      yield DeleteRoomLoadingState();
      try{
        await roomsRepo.deleteRoom(event.roomId);
        yield DeleteRoomLoadedState("Room Deleted Successfully");
      }catch(e){
        yield DeleteRoomErrorState("Some thing went wrong");
      }
    }else if(event is AddRoom){
      yield AddRoomLoadingState();
      try{
        await roomsRepo.addRoom(event.roomname, event.img!);
        yield AddRoomLoadedState();
      }catch(e){
        yield AddRoomErrorState("Something went wrong please try again");
      }
      try{
        var data = await roomsRepo.getAllRooms();
        yield GetRoomLoadedState(data);
      }catch(e){
        yield GetRoomErorrState("Something went wrong ...");
      }
    }
  }
}
