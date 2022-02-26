// ignore_for_file: use_key_in_widget_constructors

import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/consts/sizes.dart';
import 'package:ctrlx/screens/rooms/room_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RoomCard extends StatefulWidget {
  final int? id;
  final String? name;
  final String? img;
  const RoomCard(this.id, this.name, this.img);

  @override
  _RoomCardState createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomScreen( widget.id , widget.name , widget.img),
          ),
        );
      },
      child: Container(
        width: screenWidth(context),
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 200,
        child: Container(
          width: screenWidth(context),
          height: screenHeigh(context),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            boxShadow: [
              BoxShadow(
                  color: myColor.shade100.withOpacity(0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 16,
                  spreadRadius: 0),
            ],
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider("http://control-x-co.com/rooms-photos/${widget.img}"), 
            ),
          ),
          child: Container(
            width: screenWidth(context),
            height: screenHeigh(context),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                widget.name!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
