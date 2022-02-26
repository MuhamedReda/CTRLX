import 'package:bloc/bloc.dart';
import 'package:ctrlx/data/models/family_member.dart';
import 'package:ctrlx/data/repositries/Family_repo.dart';
import 'package:meta/meta.dart';

part 'family_event.dart';
part 'family_state.dart';

class FamilyBloc extends Bloc<FamilyEvent, FamilyState> {
  FamilyRepo repo;
  FamilyBloc(this.repo) : super(FamilyInitial());

  @override
  Stream<FamilyState> mapEventToState(
    FamilyEvent event,
  ) async* {
    if(event is GetFamily){
      yield GetFamilyLoading();
      try{
        var data = await repo.getAllFamily();
        yield GetFamilyLoaded(data);
      }catch (e) {
        yield GetFamilyErorr("Something went wrong");
      }
    }else if(event is AddFamilyMemeber){
      yield FamilyAddLoading();
      try{
        await repo.addFamilyMember(event.email, event.password, event.name);
        yield FamilyAddLoaded();
      }catch (e){
        yield FamilyAddErorr("Something went wrong");
      }
    }else if(event is DeleteMember){
      yield DeleteFamilyLoading();
      try{
        await repo.deleteFamilyMember(event.userId);
        yield DeleteFamilyLoaded();
      }catch(e){
        yield DeleteFamilyErorr("something went wrong");
      }
    }
  }
  
}
