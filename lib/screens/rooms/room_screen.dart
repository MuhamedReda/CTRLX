// ignore_for_file: use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ctrlx/blocs/room_blocs/bloc/room_bloc.dart';
import 'package:ctrlx/blocs/switch_bloc/bloc/switch_bloc.dart';
import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/consts/sizes.dart';
import 'package:ctrlx/screens/rooms/add_switch.dart';
import 'package:ctrlx/screens/rooms/room_family.dart';
import 'package:ctrlx/widgets/switch_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class RoomScreen extends StatefulWidget {
  final String? name;
  final String? img;
  final int? id;
  const RoomScreen(this.id, this.name, this.img);

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  SwitchBloc? switchBloc;

  @override
  void initState() {
    switchBloc = BlocProvider.of<SwitchBloc>(context);
    switchBloc!.add(GetRoomSwitches(widget.id!));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name!),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => RoomFamily(widget.id.toString())));
          }, icon: const Icon(Icons.person),),
        ],
      ),
      body: Container(
        width: screenWidth(context),
        height: screenHeigh(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider("http://control-x-co.com/rooms-photos/${widget.img}"),
          ),
        ),
        child: Stack(
          children: [
            Container(
              width: screenWidth(context),
              height: screenHeigh(context),
              color: Colors.black.withOpacity(0.4),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: screenWidth(context),
                height: screenHeigh(context) / 3,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: BlocBuilder<SwitchBloc, SwitchState>(
                  builder: (context, state) {
                    if (state is GetRoomSwitchesLoadingState) {
                      return Row(
                        children: [
                          Container(
                            width: (screenWidth(context) / 2) * 1.5,
                            height: screenHeigh(context),
                            margin: const EdgeInsets.only(left: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
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
                            ),
                          ),
                        ],
                      );
                    } else if (state is GetRoomSwitchesLoadedState) {
                      if (state.switches.isNotEmpty) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddSwitchForm(widget.id.toString())));
                              },
                              child: Container(
                                width: 100,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                margin: const EdgeInsets.only(left: 15),
                                child: Center(
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                            
                                    child: const Center(
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth(context) - 115,
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.switches.length,
                                itemBuilder: (context, index) {
                                  return SwitchCard(
                                    Colors.white.withOpacity(0.7),
                                    state.switches[index].name,
                                    state.switches[index].id,
                                    state.switches[index].serialNumber,
                                    state.switches[index].sub1,
                                    state.switches[index].sub2,
                                    state.switches[index].sub3,
                                    state.switches[index].state1,
                                    state.switches[index].state2,
                                    state.switches[index].state3,
                                    widget.id,
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    } else if (state is GetRoomErorrState) {
                      return const Center(
                        child: Text("Something went wrong"),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
