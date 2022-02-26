import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class BottomBarItem extends StatelessWidget {
  const BottomBarItem(this.icon, {Key? key, this.onTap, this.color = Colors.grey, this.activeColor = Colors.green, this.isActive = false, required this.name, this.isNotified = false }) : super(key: key);
  final String icon;
  final Color color;
  final Color activeColor;
  final bool isNotified;
  final bool isActive;
  final String name;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: 
      AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.all(7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon, color: isActive ? activeColor : color, width: 23, height: 23,),
            Text(name , style:  TextStyle(
              color: isActive ? activeColor : color
            ),),
          ],
        ),
      ),
    );  
  }
}
