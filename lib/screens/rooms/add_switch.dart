import 'package:ctrlx/blocs/switch_bloc/bloc/switch_bloc.dart';
import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/consts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AddSwitchForm extends StatefulWidget {
  final String roomId;
  const AddSwitchForm(this.roomId);

  @override
  _AddSwitchFormState createState() => _AddSwitchFormState();
}

var formkey = GlobalKey<FormState>();

class _AddSwitchFormState extends State<AddSwitchForm> {
  List<Map<String, String>> deviceType = [
    {'icon': 'assets/icons/plugin.svg', 'name': 'Plugin'},
  ];

  String? dropDownDeviceType;
  String? switchName;
  String? serial;
  String? leftName, rightName, middleName;
  bool? left, middle = false, right = false;

  SwitchBloc? switchBloc;
  @override
  void initState() {
    switchBloc = BlocProvider.of<SwitchBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SwitchBloc, SwitchState>(
      listener: (context, state) {
        if (state is AttachSwitchToRoomLoadedState) {
          Navigator.pop(context);
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Row(
                  children: const [
                    Icon(Icons.verified , color: Colors.green,),
                    SizedBox(
                      width: 15,
                    ),
                    Text("Switch Added Successfully"),
                  ],
                ),
              );
            },
          );
          switchBloc!.add(GetRoomSwitches(int.parse(widget.roomId)));
        }
        else if (state is AttachSwitchToRoomLoadingState) {
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
        } else if (state is AttachSwitchToRoomErorrState) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(state.message),
              );
            },
          );
        } 
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Switch",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black12.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 12),
                    child: DropdownButton(
                      value: dropDownDeviceType,
                      hint: const Text("Select Device Type"),
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: deviceType.map((value) {
                        return DropdownMenuItem(
                          value: value['name'],
                          child: Row(
                            children: [
                              SvgPicture.asset(value['icon']!),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(value['name']!),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (v) {
                        setState(() {
                          dropDownDeviceType = v as String;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      label: const Text("Serial number"),
                      fillColor: myColor.withOpacity(0.1),
                      filled: true,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.security),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Serial number field Can not be empty";
                      } else if (val.split("")[0] != "1" &&
                          val.split("")[0] != "2" &&
                          val.split("")[0] != "3") {
                        return "Serial number must start with '1' , '2' or '3'";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      if (val.isNotEmpty && val.split("")[0] == "2") {
                        setState(() {
                          middle = true;
                        });
                      } else if (val.isNotEmpty && val.split("")[0] == "3") {
                        setState(() {
                          right = true;
                          middle = true;
                        });
                      } else {
                        setState(() {
                          right = false;
                          middle = false;
                        });
                      }
                      setState(() {
                        serial = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      label: const Text("Switch name"),
                      fillColor: myColor.withOpacity(0.1),
                      filled: true,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Switch name can not be empty";
                      }else if(val.length > 8){
                        return "Switch Name Must be Maxmiumum 8 charater ";
                      } 
                      else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        switchName = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      label: const Text("Left switch"),
                      fillColor: myColor.withOpacity(0.1),
                      filled: true,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        leftName = val;
                      });
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Left switch name can not be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  middle!
                      ? TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 12),
                            label: const Text("Middle switch"),
                            fillColor: myColor.withOpacity(0.1),
                            filled: true,
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              middleName = val;
                            });
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Middle switch name can not be empty";
                            } else {
                              return null;
                            }
                          },
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 15,
                  ),
                  right!
                      ? TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 12),
                            label: const Text("Right switch"),
                            fillColor: myColor.withOpacity(0.1),
                            filled: true,
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              rightName = val;
                            });
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Right switch name can not be empty";
                            } else {
                              return null;
                            }
                          },
                        )
                      : const SizedBox(),
                  right!
                      ? const SizedBox(
                          height: 15,
                        )
                      : const SizedBox(),
                  SizedBox(
                    width: screenWidth(context),
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          switchBloc!.add(
                            AttachSwitchToRoom(
                              widget.roomId,
                              serial,
                              switchName,
                              dropDownDeviceType,
                              leftName,
                              middleName,
                              rightName,
                            ),
                          );
                        }
                      },
                      child: const Text("Add Switch"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                        myColor,
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
