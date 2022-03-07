import 'package:bloc/bloc.dart';
import 'package:ctrlx/data/models/offline_switch.dart';
import 'package:ctrlx/data/repositries/offline_repo.dart';
import 'package:meta/meta.dart';

part 'offline_event.dart';
part 'offline_state.dart';

class OfflineBloc extends Bloc<OfflineEvent, OfflineState> {
  OfflineRepo repo;
  OfflineBloc(this.repo) : super(OfflineInitial());

  @override
  Stream<OfflineState> mapEventToState(
    OfflineEvent event,
  ) async* {
    if(event is GetOffline){
      yield GetOfflineSwitchesLoadingState();
      
        var data = await repo.getAllSwitches();
        yield GetOfflineSwitchesLoadedState(data);
      
    }else if(event is GetOfflineActive){
      yield GetOfflineActiveSwitchesLoadingState();
      try{
        var data = await repo.getActiveSwitches();
        yield GetOfflineActiveSwitchesLoadedState(data);
      }catch(e){
        yield GetOfflineActiveSwitchesErorrState();
      }
    }else if(event is ChangeOfflineswitchStateEvent){
      try{
        var data = await repo.changeState(event.state, event.serial , event.pin);
        yield GetOfflineActiveSwitchesLoadedState(data);
      }catch(e){
        yield GetOfflineActiveSwitchesErorrState();
      }
    }
  }
}
