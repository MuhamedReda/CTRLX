import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ctrlx/data/repositries/auth_repo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepo authRepo;
  LoginBloc(this.authRepo) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if( event is LoginSubmit ){
      yield LoginLoadingState();
      try{
        
        var data = await authRepo.login(event.email, event.password);
        if(data['token'] != null ){
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("token", data['token']);
          prefs.setString("name", data['user_name']);
          prefs.setString("email", event.email);
          prefs.setString("id", data['id'].toString());
          prefs.setString("user_id", data['user_id'].toString());
        }
        yield LoginSuccessgState();
      }on SocketException {
        yield NoInternetState();
      }
      catch (e) {
        yield LoginErorrState("Incorrect Email-Address Or Password");
      }
    }
  }
}
