part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  final String username;
  final String email;
  final String address;
  final String phone;
  final String password;
  RegisterSubmitted(this.username , this.email , this.address , this.phone , this.password);
}