import 'package:ctrlx/blocs/offline_bloc/offline_bloc.dart';
import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/consts/sizes.dart';
import 'package:ctrlx/widgets/offline_Switch_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllOfflineSwitches extends StatefulWidget {
  const AllOfflineSwitches({Key? key}) : super(key: key);

  @override
  State<AllOfflineSwitches> createState() => _AllOfflineSwitchesState();
}

class _AllOfflineSwitchesState extends State<AllOfflineSwitches> {
  OfflineBloc? offlineBloc;
  List<String> names = [];
  @override
  void initState() {
    getnamed();
    offlineBloc = BlocProvider.of<OfflineBloc>(context);
    offlineBloc!.add(GetOffline());
    super.initState();
  }

  getnamed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      names = prefs.getStringList("names")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColor,
        title: const Text("Home Switches"),
      ),
      body: BlocBuilder<OfflineBloc, OfflineState>(
        builder: (context, state) {
          if (state is GetOfflineSwitchesLoadingState) {
            return SizedBox(
              width: screenWidth(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  Text("loading ..."),
                ],
              ),
            );
          } else if (state is GetOfflineSwitchesLoadedState) {
            if (state.switches.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 1));
                  offlineBloc!.add(GetOffline());
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: state.switches.length,
                  itemBuilder: (context, index) {
                    for (var x = 0; x < names.length; x++) {
                      var name = names[x].split('-')[1];
                      var serial = names[x].split('-')[0];
                      if (serial == state.switches[index].serialNumber) {
                        return OfflineSwitchCard(
                            name,
                            state.switches[index].serialNumber,
                            state.switches[index].state1,
                            state.switches[index].state2,
                            state.switches[index].state3);
                      }
                    }
                    return OfflineSwitchCard(
                        state.switches[index].serialNumber,
                        state.switches[index].serialNumber,
                        state.switches[index].state1,
                        state.switches[index].state2,
                        state.switches[index].state3);
                  },
                ),
              );
            } else {
              return const Center(
                child: Text("No Switches"),
              );
            }
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }
}
