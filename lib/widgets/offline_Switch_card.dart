import 'package:ctrlx/blocs/offline_bloc/offline_bloc.dart';
import 'package:http/http.dart' as http; 
import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/data/repositries/offline_repo.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfflineSwitchCard extends StatefulWidget {
  final String? name;
  final int? state1;
  final int? state2;
  final int? state3;
  final String? serial;

  const OfflineSwitchCard(
      this.name, this.serial, this.state1, this.state2, this.state3);

  @override
  _OfflineSwitchCardState createState() => _OfflineSwitchCardState();
}

class _OfflineSwitchCardState extends State<OfflineSwitchCard> {
  int s1 = 0;
  int s2 = 0;
  int s3 = 0;

  OfflineBloc? offlineBloc;
  OfflineRepo? repo;

  @override
  void initState() {
    offlineBloc = BlocProvider.of<OfflineBloc>(context);
    setState(() {
      s1 = widget.state1!;
      s2 = widget.state2!;
      s3 = widget.state3!;
    });
    super.initState();
  }



  Future changeState(  String state , String serial , String pin ) async{
    try{
      await http.post(Uri.parse("http://192.168.4.1/setState") , body: {
        'serial' : serial,
        'pin' : pin,
        'state': state,
      });
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: myColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                    const Text("Left"),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          s1 = s1 == 0 ? 1 : 0;
                        });
                        await changeState(
                            s1 == 0 ? "off" : "on", widget.serial!, "left");
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
                const SizedBox(
                  width: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Middle"),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          s2 = s2 == 0 ? 1 : 0;
                        });
                        await changeState(
                            s2 == 0 ? "off" : "on", widget.serial!, "middle");
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: s2 == 0 ? Colors.grey.shade200 : myColor,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Text(
                            s2 == 0 ? "Off" : "On",
                            style: TextStyle(
                                color: s2 == 1 ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Right"),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          s3 = s3 == 0 ? 1 : 0;
                        });
                        await changeState(
                            s3 == 0 ? "off" : "on",widget.serial!, "right");
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: s3 == 0 ? Colors.grey.shade200 : myColor,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Text(
                            s3 == 0 ? "Off" : "On",
                            style: TextStyle(
                                color: s3 == 1 ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
