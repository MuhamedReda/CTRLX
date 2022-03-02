import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/consts/sizes.dart';
import 'package:ctrlx/screens/auth/login_screen.dart';
import 'package:ctrlx/screens/family/add_family.dart';
import 'package:ctrlx/screens/offline/main_offline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool state = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: screenWidth(context),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(100),
                      image: const DecorationImage(
                          image: AssetImage("assets/images/setting.jpg")),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Muhamed Reda",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("Muhamed.reda@gmail.com"),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove("token");
                      prefs.remove("name");
                      prefs.remove("id");
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (route) => false);
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                          color: myColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SvgPicture.asset(
                            "assets/icons/logout.svg",
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            const Divider(
              indent: 50,
              endIndent: 50,
            ),
            Container(
              width: screenWidth(context),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddFamilyMember()));
                    },
                    child: Container(
                      width: screenWidth(context),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/profile.svg",
                                color: myColor,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("Add Family Member"),
                            ],
                          ),
                          const Icon(Icons.arrow_right_alt)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: screenWidth(context),
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/key.svg",
                              color: myColor,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text("Change Password"),
                          ],
                        ),
                        const Icon(Icons.arrow_right_alt)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: (){
                      Share.share("Controle Your Smart Home");
                    },
                    child: Container(
                      width: screenWidth(context),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/share.svg",
                                color: myColor,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("Share With Family"),
                            ],
                          ),
                          const Icon(Icons.arrow_right_alt)
                        ],
                      ),
                    ),
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
                                color:state ? Colors.green : Colors.black12,
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
                              if(v){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const OfflineScreen()));
                              }
                            });
                          },
                          activeColor: myColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
