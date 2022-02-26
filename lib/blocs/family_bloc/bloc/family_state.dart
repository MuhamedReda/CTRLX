part of 'family_bloc.dart';

@immutable
abstract class FamilyState {}

class FamilyInitial extends FamilyState {}

class FamilyAddLoading extends FamilyState{}
class FamilyAddLoaded extends FamilyState{}
class FamilyAddErorr extends FamilyState{
  final String message;
  FamilyAddErorr(this.message);
}


class GetFamilyLoading extends FamilyState{}
class GetFamilyLoaded extends FamilyState{
  final List<FamilyMember> family;
  GetFamilyLoaded(this.family);
}
class GetFamilyErorr extends FamilyState{
  final String message;
  GetFamilyErorr(this.message);
}




class DeleteFamilyLoading extends FamilyState{}
class DeleteFamilyLoaded extends FamilyState{}
class DeleteFamilyErorr extends FamilyState{
  final String message;
  DeleteFamilyErorr(this.message);
}