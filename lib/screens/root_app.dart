import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/screens/auth/login_screen.dart';
import 'package:ctrlx/screens/family/family_screen.dart';
import 'package:ctrlx/screens/home_screen.dart';
import 'package:ctrlx/screens/rooms/rooms_screen.dart';
import 'package:ctrlx/screens/setting_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/bottombar_item.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with TickerProviderStateMixin {
  int activeTab = 0;
  List barItems = [
    {
      "icon": "assets/icons/home.svg",
      "active_icon": "assets/icons/home.svg",
      "page": const HomeScreen(),
      'name': 'Home'
    },
    {
      "icon": "assets/icons/chat.svg",
      "active_icon": "assets/icons/chat.svg",
      "page": const RoomsScreen(),
      'name': 'Rooms'
    },
    {
      "icon": "assets/icons/profile.svg",
      "active_icon": "assets/icons/profile.svg",
      "page": const FamilyScreen(),
      'name': 'Family'
    },
    {
      "icon": "assets/icons/setting.svg",
      "active_icon": "assets/icons/setting.svg",
      "page": const SettingScreen(),
      'name': 'Settings'
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      activeTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getBottomBar(),
      body: barItems[activeTab]['page'],
    );
  }

  Widget getBottomBar() {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: const Offset(1, 1),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            barItems.length,
            (index) => BottomBarItem(
              barItems[index]["icon"],
              isActive: activeTab == index,
              activeColor: myColor,
              name: barItems[index]['name'],
              onTap: () {
                onPageChanged(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
