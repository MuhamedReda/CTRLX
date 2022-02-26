import 'package:ctrlx/blocs/family_bloc/bloc/family_bloc.dart';
import 'package:ctrlx/blocs/room_blocs/bloc/room_bloc.dart';
import 'package:ctrlx/blocs/switch_bloc/bloc/switch_bloc.dart';
import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/consts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/switch_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String active = "0";
  String rooms = "0";
  String members = "0";
  SwitchBloc? switchBloc;
  RoomBloc? roomBloc;
  FamilyBloc? familyBloc;
  @override
  void initState() {
    switchBloc = BlocProvider.of<SwitchBloc>(context);
    switchBloc!.add(GetActiveSwitches());
    roomBloc = BlocProvider.of<RoomBloc>(context);
    roomBloc!.add(GetRooms());
    familyBloc = BlocProvider.of<FamilyBloc>(context);
    familyBloc!.add(GetFamily());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              width: screenWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Welcome ,"),
                      Text(
                        "Muhamed Reda",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: myColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: screenWidth(context),
              height: 220,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: (screenWidth(context) / 3) - 20,
                    height: 200,
                    decoration: BoxDecoration(
                      color: myColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        BlocBuilder<SwitchBloc, SwitchState>(
                          builder: (context, state) {
                            if (state is GetActiveSwitchesLoadedState) {
                              active = "${state.switches.length}";
                              return Text(
                                "${state.switches.length}",
                                style: const TextStyle(
                                  fontSize: 22,
                                ),
                              );
                            } else {
                              return Text(
                                active,
                                style: const TextStyle(
                                  fontSize: 22,
                                ),
                              );
                            }
                          },
                        ),
                        const Positioned(bottom: 15, child: Text("Active")),
                      ],
                    ),
                  ),
                  Container(
                    width: (screenWidth(context) / 3) - 20,
                    height: 220,
                    decoration: BoxDecoration(
                      color: myColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        BlocBuilder<RoomBloc, RoomState>(
                          builder: (context, state) {
                            if (state is GetRoomLoadedState) {
                              active = "${state.rooms.length}";
                              return Text(
                                "${state.rooms.length}",
                                style: const TextStyle(
                                  fontSize: 22,
                                ),
                              );
                            } else {
                              return Text(
                                active,
                                style: const TextStyle(
                                  fontSize: 22,
                                ),
                              );
                            }
                          },
                        ),
                        const Positioned(bottom: 15, child: Text("Rooms")),
                      ],
                    ),
                  ),
                  Container(
                    width: (screenWidth(context) / 3) - 20,
                    height: 200,
                    decoration: BoxDecoration(
                      color: myColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        BlocBuilder<FamilyBloc, FamilyState>(
                          builder: (context, state) {
                            if (state is GetFamilyLoaded) {
                              active = "${state.family.length}";
                              return Text(
                                "${state.family.length}",
                                style: const TextStyle(
                                  fontSize: 22,
                                ),
                              );
                            } else {
                              return Text(
                                active,
                                style: const TextStyle(
                                  fontSize: 22,
                                ),
                              );
                            }
                          },
                        ),
                        const Positioned(bottom: 15, child: Text("Members")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Activated Switches",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<SwitchBloc, SwitchState>(
                  builder: (context, state) {
                    if (state is GetActiveSwitchesLoadingState) {
                      return SizedBox(
                        width: screenWidth(context),
                        height: 200,
                        child: Center(
                          child: Shimmer.fromColors(
                              child: const Text(
                                "Loading",
                                style: TextStyle(fontSize: 28),
                              ),
                              baseColor: Colors.black12,
                              highlightColor: myColor),
                        ),
                      );
                    } else if (state is GetActiveSwitchesLoadedState) {
                      if (state.switches.isNotEmpty) {
                        return SizedBox(
                          width: screenWidth(context),
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(right: 20),
                            itemCount: state.switches.length,
                            itemBuilder: (context, index) {
                              return SwitchCard(
                                myColor.withOpacity(0.2) ,
                                state.switches[index].name,
                                state.switches[index].id,
                                state.switches[index].serialNumber,
                                state.switches[index].sub1,
                                state.switches[index].sub2,
                                state.switches[index].sub3,
                                state.switches[index].state1,
                                state.switches[index].state2,
                                state.switches[index].state3,
                              );
                            },
                          ),
                        );
                      } else {
                        return SizedBox(
                          width: screenWidth(context),
                        height: 200,
                          child: const Center(
                            child: Text("No Active Switches"),
                          ),
                        );
                      }
                    } else {
                      return SizedBox(
                        width: screenWidth(context),
                        height: 200,
                        child: const Center(
                          child: Text("No Active Switches"),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
