import 'package:ctrlx/consts/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts/sizes.dart';

class OfflineScreen extends StatefulWidget {
  const OfflineScreen({Key? key}) : super(key: key);

  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  bool state = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Offline Mode",
          style: TextStyle(),
        ),
        elevation: 0,
        backgroundColor: myColor,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          
          ListTile(
            onTap: () {},
            title: const Text("Active Switches"),
            subtitle: const Text("Switches that turned on"),
            trailing: const Icon(Icons.arrow_right),
          ),
          ListTile(
            onTap: () {},
            title: const Text("All Switches"),
            subtitle: const Text("All Home's Smart Switches"),
            trailing: const Icon(Icons.arrow_right),
          ),
          ListTile(
            onTap: () {},
            title: const Text("Set Home Wifi"),
            subtitle: const Text("Home SSID And Password For Your Switches"),
            trailing: const Icon(Icons.arrow_right),
          ),
          ListTile(
            onTap: () {},
            title: const Text("Set Master Wifi"),
            subtitle: const Text("Switches that turned on"),
            trailing: const Icon(Icons.arrow_right),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: screenWidth(context),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: state ? Colors.green : Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("Offline Mode : ${state ? 'Active' : 'Disable'} "),
                  ],
                ),
                CupertinoSwitch(
                  value: state,
                  onChanged: (v) {
                    setState(() {
                      state = v;
                     
                    });
                  },
                  activeColor: myColor,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
