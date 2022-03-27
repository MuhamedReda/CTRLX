import 'package:ctrlx/blocs/family_bloc/bloc/family_bloc.dart';
import 'package:ctrlx/blocs/room_family/roomfamily_bloc.dart';
import 'package:ctrlx/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoomUsersCard extends StatefulWidget {
  final String roomId;
  final String name;
  final int id;
  final String accountType;
  final bool state;
  const RoomUsersCard(this.id, this.name, this.accountType, this.roomId , this.state);

  @override
  _RoomUsersCardState createState() => _RoomUsersCardState();
}

class _RoomUsersCardState extends State<RoomUsersCard> {
  bool? isAttached;

  FamilyBloc? familyBloc;
  RoomfamilyBloc? roomfamilyBloc;

  @override
  void initState() {
    roomfamilyBloc = BlocProvider.of<RoomfamilyBloc>(context);
    setState(() {
      isAttached = widget.state;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(widget.name),
        subtitle: Text(widget.accountType),
        leading: Container(
          decoration: BoxDecoration(
            color: myColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset("assets/icons/profile.svg"),
        ),
        trailing: ElevatedButton(
          onPressed: isAttached!
              ? null
              : () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Are You Sure To Give ${widget.name} Permission To Access This Room ?",
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
                              roomfamilyBloc!.add(AttachUserToRoom(
                                  widget.roomId, widget.id.toString()));
                              roomfamilyBloc!.add(GetRoomFamily(widget.roomId));
                              Navigator.pop(context);
                              setState(() {
                                isAttached = isAttached! ? false : true;
                              });
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      );
                    },
                  );
                },
          child: isAttached! ? const Text("Attached") : const Text("Attach"),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                isAttached! ? Colors.grey : Colors.green),
          ),
        ),
      ),
    );
  }
}
