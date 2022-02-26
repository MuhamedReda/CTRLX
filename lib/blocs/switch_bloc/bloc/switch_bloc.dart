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
      var data = await switchRepo!.getActiveSwitches();
      yield GetActiveSwitchesLoadedState(data);
    }
  }
}
