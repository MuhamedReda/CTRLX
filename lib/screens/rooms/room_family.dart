import 'package:ctrlx/consts/colors.dart';
import 'package:flutter/material.dart';


class RoomFAmily extends StatelessWidget {
  const RoomFAmily({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Room Family"),
        backgroundColor: myColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(),
      ),
    );
  }
}