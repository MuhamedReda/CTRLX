import 'package:bloc/bloc.dart';
import 'package:ctrlx/data/models/switch.dart';
import 'package:ctrlx/data/repositries/switches_repo.dart';
import 'package:meta/meta.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchRepo? switchRepo;
  SwitchBloc(this.switchRepo) : super(SwitchInitial());

  @override
  Stream<SwitchState> mapEventToState (
    SwitchEvent event,
  ) async* {
    if(event is GetRoomSwitches){
      yield GetRoomSwitchesLoadingState();
      try{
        var data = await switchRepo!.getSwitches(event.roomId);
        yield GetRoomSwitchesLoadedState(data);
      }catch(e){
        yield GetRoomSwitchesErorrState("Some thing went wrong");
      }
    }else if(event is ChangeSwitchState){
        await switchRepo!.changeState(event.state, event.currentState, event.serial);
    }else if(event is GetActiveSwitches){
      yield GetActiveSwitchesLoadingState();
      try{
        var data = await switchRepo!.getActiveSwitches();
        yield GetActiveSwitchesLoadedState(data);
      }catch(e){
        print(e);
      }
    }else if(event is AttachSwitchToRoom){
      yield AttachSwitchToRoomLoadingState();
      try{
        var res = await switchRepo!.attachSwitchToRoom(event.roomId, event.serial, event.deviceName, event.type, event.sub_1, event.sub_2, event.sub_3);
        if(res){
          yield AttachSwitchToRoomLoadedState();
        }else{
          yield AttachSwitchToRoomErorrState("Wrong Serial number");  
        }
      }catch(e){
        yield AttachSwitchToRoomErorrState("Wrong Serial number");
      }
    }
  }
}
