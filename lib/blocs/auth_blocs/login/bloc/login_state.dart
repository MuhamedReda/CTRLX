part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState{}

class LoginSuccessgState extends LoginState{}
class NoInternetState extends LoginState{}

class LoginErorrState extends LoginState{
  final String message;
  LoginErorrState(this.message);
}