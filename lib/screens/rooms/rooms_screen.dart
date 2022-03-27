import 'package:ctrlx/blocs/room_blocs/bloc/room_bloc.dart';
import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/screens/rooms/add_room.dart';
import 'package:ctrlx/widgets/room_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({Key? key}) : super(key: key);

  @override
  _RoomsScreenState createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  RoomBloc? roomBloc;
  bool isSub = false;
  @override
  void initState() {
    roomBloc = BlocProvider.of<RoomBloc>(context);
    roomBloc!.add(GetRooms());
    getUser();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSub = prefs.getString("user_id") != "null" ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          roomBloc = BlocProvider.of<RoomBloc>(context);
          roomBloc!.add(GetRooms());
      },
      child: BlocListener<RoomBloc, RoomState>(
        listener: (context, state) {
          if (state is DeleteRoomLoadingState) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Row(
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Please Wait"),
                    ],
                  ),
                );
              },
            );
          } else if (state is DeleteRoomLoadedState) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Row(
                    children: [
                      const Icon(
                        Icons.verified,
                        size: 20,
                        color: Colors.green,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(state.name),
                    ],
                  ),
                );
              },
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Rooms"),
            backgroundColor: myColor,
            centerTitle: true,
          ),
          floatingActionButton: isSub == false ? FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddRoomScreen()));
            },
            child: const Icon(Icons.add),
            backgroundColor: myColor,
          ): const SizedBox(),
          body: BlocBuilder<RoomBloc, RoomState>(
            builder: (context, state) {
              if (state is GetRoomLoadingState) {
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
              } else if (state is GetRoomLoadedState) {
                if (state.rooms.isNotEmpty) {
                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.rooms.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        endActionPane: ActionPane(
                            extentRatio: 0.3,
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                            "Are You Sure To Delete ${state.rooms[index].name} ?"),
                                        actionsAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("No")),
                                          TextButton(
                                            onPressed: () {
                                              roomBloc!.add(
                                                DeleteRoom(
                                                  state.rooms[index].id
                                                      .toString(),
                                                ),
                                              );
                                              roomBloc!.add(
                                                GetRooms(),
                                              );
                                            },
                                            child: const Text("Yes"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: Icons.delete,
                                label: "Delete",
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.red,
                                spacing: 1,
                              )
                            ]),
                        child: RoomCard(
                            state.rooms[index].id,
                            state.rooms[index].name,
                            state.rooms[index].photoLink),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("You have no rooms"),
                  );
                }
              } else if (state is GetRoomErorrState) {
                return const Center(
                  child: Text("Something went wrong"),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
