part of 'family_bloc.dart';

@immutable
abstract class FamilyEvent {}

class GetFamily extends FamilyEvent {}

class AddFamilyMemeber extends FamilyEvent {
  final String email;
  final String password;
  final String name;

  AddFamilyMemeber(this.email , this.password , this.name);
}

class DeleteMember extends FamilyEvent {
  final int userId;
  DeleteMember(this.userId);
}