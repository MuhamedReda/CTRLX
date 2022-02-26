import 'package:bloc/bloc.dart';
import 'package:ctrlx/data/models/family_member.dart';
import 'package:ctrlx/data/repositries/rooms_repo.dart';
import 'package:meta/meta.dart';

part 'roomfamily_event.dart';
part 'roomfamily_state.dart';

class RoomfamilyBloc extends Bloc<RoomfamilyEvent, RoomfamilyState> {
  RoomsRepo roomsRepo;
  RoomfamilyBloc(this.roomsRepo) : super(RoomfamilyInitial());

  @override
  Stream<RoomfamilyState> mapEventToState(
    RoomfamilyEvent event,
  ) async* {
    if(event is GetRoomFamily){
      yield GetRoomFamilyLoadingState();
      try{
        var data = await roomsRepo.getRoomFamily(event.roomId);
        yield GetRoomFamilyLoadedState(data);
      }
      catch(e) {
        yield GetRoomFamilyErorrState("Something went wrong");
      }
    }else if (event is AttachUserToRoom){
      //yield AttachUserToRoomLoadingState();
      try{
        await roomsRepo.attachUserToRoom(event.roomId, event.userId);
        //yield AttachUserToRoomLoadedState();
      }catch(e){
        //yield AttachUserToRoomErorrState();
      }
    }
  }

}
