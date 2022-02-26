import 'package:ctrlx/blocs/family_bloc/bloc/family_bloc.dart';
import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/screens/family/add_family.dart';
import 'package:ctrlx/widgets/family_member_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class FamilyScreen extends StatefulWidget {
  const FamilyScreen({Key? key}) : super(key: key);

  @override
  _FamilyScreenState createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  FamilyBloc? familyBloc;

  @override
  void initState() {
    familyBloc = BlocProvider.of<FamilyBloc>(context);
    familyBloc!.add(GetFamily());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FamilyBloc, FamilyState>(
      listener: (context, state) {
        if (state is DeleteFamilyLoading) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Row(
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      width: 15,
                    ),
                    Text("Please Wait"),
                  ],
                ),
              );
            },
          );
        } else if (state is DeleteFamilyLoaded) {
          familyBloc!.add(GetFamily());    
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Icon(
                  Icons.verified,
                  size: 38,
                  color: Colors.green,
                ),
                content: Text("Member is Deleted Successfully"),
              );
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: myColor,
          title: const Text("Family Members"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddFamilyMember()));
          },
          child: const Icon(Icons.add),
          backgroundColor: myColor,
        ),
        body: BlocBuilder<FamilyBloc, FamilyState>(
          builder: (context, state) {
            if (state is GetFamilyLoading) {
              return Center(
                child: Shimmer.fromColors(
                  child: const Text(
                    "Loading",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  baseColor: Colors.black12,
                  highlightColor: myColor,
                ),
              );
            } else if (state is GetFamilyLoaded) {
              if (state.family.isNotEmpty) {
                return ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: state.family.length,
                  itemBuilder: (context, index) {
                    return FamilyMemberCard(
                      state.family[index].id,
                      state.family[index].name,
                      state.family[index].accountType,
                    );
                  },
                );
              }
              else {
                return const Center(
                  child: Text("Your Family is Empty"),
                );
              }
            } else if (state is GetFamilyErorr) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
