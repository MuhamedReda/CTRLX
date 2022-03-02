import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'offline_event.dart';
part 'offline_state.dart';

class OfflineBloc extends Bloc<OfflineEvent, OfflineState> {
  OfflineBloc() : super(OfflineInitial()) {
    on<OfflineEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
