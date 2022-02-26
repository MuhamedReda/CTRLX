import 'package:ctrlx/blocs/family_bloc/bloc/family_bloc.dart';
import 'package:ctrlx/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FamilyMemberCard extends StatefulWidget {
  final String? name;
  final String? type;
  final int? id;
  const FamilyMemberCard(this.id , this.name , this.type);

  @override
  _FamilyMemberCardState createState() => _FamilyMemberCardState();
}

class _FamilyMemberCardState extends State<FamilyMemberCard> {
  
  FamilyBloc? familyBloc;

  @override
  void initState() {
    familyBloc = BlocProvider.of<FamilyBloc>(context);
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
        title: Text(widget.name!),
        subtitle: Text(widget.type!),
        leading: Container(
          decoration: BoxDecoration(
            color: myColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset("assets/icons/profile.svg"),
        ),
        trailing: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    "Are You Sure To Delete Room name ?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No")),
                    TextButton(
                      onPressed: () {
                        familyBloc!.add(DeleteMember(widget.id!));
                      },
                      child: const Text("Yes"),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Image(
            image: AssetImage("assets/icons/delete.png"),
            width: 20,
          ),
        ),
      ),
    );
  }
}
