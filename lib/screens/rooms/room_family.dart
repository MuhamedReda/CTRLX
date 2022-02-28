import 'package:ctrlx/blocs/family_bloc/bloc/family_bloc.dart';
import 'package:ctrlx/blocs/room_family/roomfamily_bloc.dart';
import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/data/models/family_member.dart';
import 'package:ctrlx/screens/rooms/family_to_attach.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class RoomFamily extends StatefulWidget {
  final String roomId;
  const RoomFamily(this.roomId);

  @override
  State<RoomFamily> createState() => _RoomFamilyState();
}

class _RoomFamilyState extends State<RoomFamily> {
  RoomfamilyBloc? roomfamilyBloc;
  List<FamilyMember> family = [];

  
  FamilyBloc? familyBloc;

  @override
  void initState() {
    familyBloc = BlocProvider.of<FamilyBloc>(context);
    roomfamilyBloc = BlocProvider.of<RoomfamilyBloc>(context);
    roomfamilyBloc!.add(GetRoomFamily(widget.roomId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Room Family"),
        backgroundColor: myColor,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            FamilyToAttach(family, widget.roomId))));
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: BlocBuilder<RoomfamilyBloc, RoomfamilyState>(
        builder: (context, state) {
          if (state is GetRoomFamilyLoadingState) {
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
          } else if (state is GetRoomFamilyLoadedState) {
            if (state.family.isEmpty) {
              return const Center(
                child: Text("There Are No Users For This Room"),
              );
            } else {
              family = state.family ;
              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                itemCount: state.family.length,
                itemBuilder: (context, index) {
                  return Card(
                    shadowColor: myColor.withOpacity(0.2),
                    margin: const EdgeInsets.only(bottom: 15),
                    elevation: 10,
                    borderOnForeground: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white,
                    child: ListTile(
                      title: Text(state.family[index].name!),
                      subtitle: Text(state.family[index].accountType!),
                      leading: Container(
                        decoration: BoxDecoration(
                          color: myColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset("assets/icons/profile.svg"),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Are You Sure To Remove ${state.family[index].name} From This Room ?",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      roomfamilyBloc!.add(DeAttachUserToRoom(
                                          widget.roomId,
                                          state.family[index].id.toString()));
                                      
                                      roomfamilyBloc!
                                          .add(GetRoomFamily(widget.roomId));
                                      familyBloc!.add(GetFamily());
                                    },
                                    child: const Text("Confirm"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text("DeAttach"),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else if (state is GetRoomFamilyErorrState) {
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
