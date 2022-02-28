import 'package:ctrlx/blocs/family_bloc/bloc/family_bloc.dart';
import 'package:ctrlx/blocs/room_family/roomfamily_bloc.dart';
import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/data/models/family_member.dart';
import 'package:ctrlx/widgets/attached_user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class FamilyToAttach extends StatefulWidget {
  final List<FamilyMember> roomFamily;
  final String roomId;
  const FamilyToAttach(this.roomFamily , this.roomId);

  @override
  _FamilyToAttachState createState() => _FamilyToAttachState();
}

class _FamilyToAttachState extends State<FamilyToAttach> {


  FamilyBloc? familyBloc;
  RoomfamilyBloc? roomfamilyBloc;

  @override
  void initState() {
    familyBloc = BlocProvider.of<FamilyBloc>(context);
    familyBloc!.add(GetFamily());
    roomfamilyBloc = BlocProvider.of<RoomfamilyBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Family"),
        backgroundColor: myColor,
        centerTitle: true,
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
            if (state.family.isEmpty) {
              return const Center(
                child: Text("There Are No Users For This Room"),
              );
            } else {
              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                itemCount: state.family.length,
                itemBuilder: (context, index) {
                  bool isAttached = widget.roomFamily.any((e) => e.id == state.family[index].id);
                  return  RoomUsersCard(state.family[index].id!, state.family[index].name!, state.family[index].accountType!, widget.roomId , isAttached);
                },
              );
            }
          } else if (state is GetFamilyErorr) {
            return const Center(
              child: Text("Something went wrong"),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}