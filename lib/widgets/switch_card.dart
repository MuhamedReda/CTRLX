import 'package:ctrlx/blocs/switch_bloc/bloc/switch_bloc.dart';
import 'package:ctrlx/blocs/timer_bloc/timer_bloc.dart';
import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/consts/sizes.dart';
import 'package:ctrlx/widgets/set_timer_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SwitchCard extends StatefulWidget {
  final String? name;
  final int? id;
  final int? state1;
  final int? state2;
  final int? state3;
  final String? serial;
  final String? sub_1;
  final String? sub_2;
  final String? sub_3;
  final Color? color;
  final int? roomId;
  const SwitchCard(this.color, this.name, this.id, this.serial, this.sub_1,
      this.sub_2, this.sub_3, this.state1, this.state2, this.state3 , this.roomId);

  @override
  _SwitchCardState createState() => _SwitchCardState();
}

class _SwitchCardState extends State<SwitchCard> {
  int s1 = 0;
  int s2 = 0;
  int s3 = 0;
  SwitchBloc? switchBloc;
  TimerBloc? timerBloc;
  List<Map<String, String>> devices = [];

  @override
  void initState() {
    switchBloc = BlocProvider.of<SwitchBloc>(context);
    timerBloc = BlocProvider.of<TimerBloc>(context);
    setState(() {
      s1 = widget.state1!;
      s2 = widget.state2!;
      s3 = widget.state3!;
      devices.addAll([
        {"state_1": "${widget.sub_1}"},
        {"state_2": "${widget.sub_2}"},
        {"state_3": "${widget.sub_3}"}
      ]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeigh(context),
      margin: const EdgeInsets.only(left: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SizedBox(
            width: widget.sub_3 != null
                ? (60 * 3) + 50
                : widget.sub_2 != null
                    ? (60 * 2) + 25
                    : 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name!,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton(
                    alignment: Alignment.center,
                    splashRadius: 20,
                    onPressed: () {
                      timerBloc!.add(GetTimers(widget.id.toString()));
                      showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: screenHeigh(context) / 2,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: screenWidth(context),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${widget.name!} Timers"),
                                      IconButton(
                                        onPressed: () {
                                          showMaterialModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return SizedBox(
                                                height: 250,
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 50,
                                                      child: Center(
                                                        child: Text(
                                                            "Select Switch"),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: ListView.builder(
                                                        itemCount: widget
                                                                    .sub_3 !=
                                                                null
                                                            ? 3
                                                            : widget.sub_2 !=
                                                                    null
                                                                ? 2
                                                                : 1,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return ListTile(
                                                            onTap: () {
                                                              pickupDate(
                                                                   "state_${index + 1}");
                                                            },
                                                            title: Text(devices[
                                                                    index][
                                                                'state_${index + 1}']!),
                                                            trailing:
                                                                const Icon(Icons
                                                                    .arrow_right_alt),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: BlocBuilder<TimerBloc, TimerState>(
                                    builder: (context, state) {
                                      if (state is GetTimerLoadingState) {
                                        return const SizedBox(
                                          height: 100,
                                          child: Center(
                                            child: Text("Loading"),
                                          ),
                                        );
                                      } else if (state is GetTimerLoadedState) {
                                        if (state.timers.isEmpty) {
                                          return const SizedBox(
                                            height: 100,
                                            child: Center(
                                              child: Text("No Timers"),
                                            ),
                                          );
                                        } else {
                                          return ListView.separated(
                                            itemCount: state.timers.length,
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    const Divider(),
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: Text(
                                                    state.timers[index].time!),
                                                subtitle: Text(
                                                    "${state.timers[index].subNo!} : ${state.timers[index].state == 0 ? 'Off' : 'On'}"),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    timerBloc!.add(DeleteTimers(
                                                        state.timers[index].id
                                                            .toString()));
                                                    timerBloc!.add(GetTimers(
                                                        widget.id.toString()));
                                                  },
                                                  icon: const Image(
                                                    image: AssetImage(
                                                        "assets/icons/delete.png"),
                                                    width: 20,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      } else {
                                        return const Text(
                                            "some thing went wrong");
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.timer,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.sub_1!),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        switchBloc!.add(
                            ChangeSwitchState(widget.serial, 'state_1', s1));
                        setState(() {
                          s1 = s1 == 0 ? 1 : 0;
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: s1 == 0 ? Colors.grey.shade200 : myColor,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Text(
                            s1 == 0 ? "Off" : "On",
                            style: TextStyle(
                                color: s1 == 1 ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                widget.sub_2 != null
                    ? const SizedBox(
                        width: 25,
                      )
                    : const SizedBox(),
                widget.sub_2 != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.sub_2!),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              switchBloc!.add(ChangeSwitchState(
                                  widget.serial, 'state_2', s2));
                              setState(() {
                                s2 = s2 == 0 ? 1 : 0;
                              });
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  color:
                                      s2 == 0 ? Colors.grey.shade200 : myColor,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                child: Text(
                                  s2 == 0 ? "Off" : "On",
                                  style: TextStyle(
                                      color: s2 == 1
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                widget.sub_3 != null
                    ? const SizedBox(
                        width: 25,
                      )
                    : const SizedBox(),
                widget.sub_3 != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.sub_3!),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              switchBloc!.add(ChangeSwitchState(
                                  widget.serial, 'state_3', s3));
                              setState(() {
                                s3 = s3 == 0 ? 1 : 0;
                              });
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  color:
                                      s3 == 0 ? Colors.grey.shade200 : myColor,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                child: Text(
                                  s3 == 0 ? "Off" : "On",
                                  style: TextStyle(
                                      color: s3 == 1
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pickupDate(String state) async {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) {
        return SetTimerForm(widget.id.toString() , state , widget.roomId );
      },
    );
  }
}
