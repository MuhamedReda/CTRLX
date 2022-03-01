import 'package:ctrlx/blocs/timer_bloc/timer_bloc.dart';
import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/consts/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetTimerForm extends StatefulWidget {
  final String? switchId;
  final String? state;
  final int? roomId;
  const SetTimerForm(this.switchId , this.state , this.roomId);

  @override
  _SetTimerFormState createState() => _SetTimerFormState();
}

class _SetTimerFormState extends State<SetTimerForm> {
  TimerBloc? timerBloc;
  var time = DateTime.now();
  int state = 1;

  @override
  void initState() {
    timerBloc = BlocProvider.of<TimerBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoButton(
                  child: const Text("Set Timer"),
                  onPressed: () {
                    timerBloc!.add(SetTimers(widget.switchId, widget.roomId.toString(), time.toString(), state, widget.state));
                    timerBloc!.add(GetTimers(widget.switchId));
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (DateTime newDateTime) {
                setState(() {
                  time = newDateTime;
                });
              },
              use24hFormat: false,
              minuteInterval: 1,
            ),
          ),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      state = 1;
                    });
                  },
                  child: Container(
                    width: screenWidth(context) / 2 - 70,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(20),
                      color: state == 1 ? myColor : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "On",
                        style: TextStyle(
                          color: state == 1 ? Colors.white : myColor,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      state = 0;
                    });
                  },
                  child: Container(
                    width: screenWidth(context) / 2 - 70,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(20),
                      color: state == 0 ? myColor : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "Off",
                        style: TextStyle(
                          color: state == 0 ? Colors.white : myColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
