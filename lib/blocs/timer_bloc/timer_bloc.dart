import 'package:bloc/bloc.dart';
import 'package:ctrlx/data/models/timer.dart';
import 'package:ctrlx/data/repositries/timer_repo.dart';
import 'package:meta/meta.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerRepo timerRepo;
  TimerBloc(this.timerRepo) : super(TimerInitial());

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is GetTimers) {
      yield GetTimerLoadingState();
        var data = await timerRepo.getTimers(event.switchId!);
        yield GetTimerLoadedState(data);
      
    }else if(event is SetTimers){
      //yield SetTimerLoadingState();
      try{
        await timerRepo.setTimers(event.switchId!, event.roomId!, event.time!, event.stateNo!, event.state!);
        //yield SetTimerLoadedState();
      }catch(e){
        yield SetTimerErorrState();
      }
    }else if(event is DeleteTimers){
      try{
        await timerRepo.deleteTimers(event.timerId!);
        
      }catch(e){
        yield DeleteTimerErorrState();
      }
    }
  }
}
