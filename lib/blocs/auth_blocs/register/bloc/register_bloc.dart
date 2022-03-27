import 'package:bloc/bloc.dart';
import 'package:ctrlx/data/repositries/auth_repo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  AuthRepo authRepo;
  RegisterBloc(this.authRepo) : super(RegisterInitial());
  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if( event is RegisterSubmitted){
      yield RegisterLoadingState();
      try{
        var data = await authRepo.createAccount(event.username, event.email, event.phone, event.address, event.password);
        if(data['access_token'] != null){
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("token", data['access_token']);
          prefs.setString("name", event.username);
          prefs.setString("email", event.email);
          yield RegisterSuccessState();
        }else{
          throw Exception("This Email Already Exist");
        }
      }catch(e){
        yield RegisterErorrState(e.toString());
      }

    }
  }
}
