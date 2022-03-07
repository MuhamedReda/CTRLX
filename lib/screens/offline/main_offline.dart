import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/screens/offline/active_offline.dart';
import 'package:ctrlx/screens/offline/allSwitches.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../consts/sizes.dart';

class OfflineScreen extends StatefulWidget {
  const OfflineScreen({Key? key}) : super(key: key);

  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  bool state = true;
  String homeSsid = "";
  String homePassword = "";
  String masterSsid = "";
  String masterPassword = "";
  var masterFormKey = GlobalKey<FormState>();
  var homeFormKey = GlobalKey<FormState>();

  Future changeConection(String connectionType) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: const [
              CircularProgressIndicator(),
              SizedBox(
                width: 15,
              ),
              Text("Please Wait ...")
            ],
          ),
        );
      },
    );
    if(homePassword.isNotEmpty && homePassword.length > 7){
      try {
      await http.post(
        Uri.parse("http://192.168.4.1/setConnection"),
        body: {
          'type': connectionType,
        },
      );
      setState(() {
        state = !state;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("connectionType", "online");
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Icon(
              Icons.error,
              color: Colors.red,
            ),
            content: Text("Make Sure That You Connected To Master Wifi"),
          );
        },
      );
    }
    }else{
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Icon(
              Icons.error,
              color: Colors.red,
            ),
            content: Text("You Must Set Your home wifi to your muster to Change the connection to Online"),
          );
        },
      );
    }
  }

  Future setWifi(String type, String ssid, String password) async {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: const [
              CircularProgressIndicator(),
              SizedBox(
                width: 15,
              ),
              Text("Please Wait ...")
            ],
          ),
        );
      },
    );
    try {
      await http.post(Uri.parse("http://192.168.4.1/updateWifi"), body: {
        'type': type,
        'ssid': ssid,
        'password': password,
      });
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const Icon(
                  Icons.verified,
                  color: Colors.green,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text("$type changed successfully"),
              ],
            ),
          );
        },
      );
    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Icon(
              Icons.error,
              color: Colors.red,
            ),
            content: Text("Make Sure That You Connected To Master Wifi"),
          );
        },
      );
    }
  }

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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ActiveOfflineSwitches()));
            },
            title: const Text("Active Switches"),
            subtitle: const Text("Switches that turned on"),
            trailing: const Icon(Icons.arrow_right),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllOfflineSwitches()));
            },
            title: const Text("All Switches"),
            subtitle: const Text("All Home's Smart Switches"),
            trailing: const Icon(Icons.arrow_right),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Set Your Home Wifi"),
                    content: SizedBox(
                      height: 300,
                      child: Form(
                        key: homeFormKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                label: const Text("SSID"),
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(Icons.wifi),
                                fillColor: myColor.shade100,
                                filled: true,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Required Field";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  homeSsid = value;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                label: const Text("Password"),
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(Icons.lock),
                                fillColor: myColor.shade100,
                                filled: true,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Required Field";
                                } else if (value.length < 8) {
                                  return "Password Must Be 8 Character at least";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  homePassword = value;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: screenWidth(context),
                              height: 55,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (homeFormKey.currentState!.validate()) {
                                    await setWifi(
                                        "home", homeSsid, homePassword);
                                  }
                                },
                                child: const Text("Change"),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    myColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            title: const Text("Set Home Wifi"),
            subtitle: const Text("Home SSID And Password For Your Switches"),
            trailing: const Icon(Icons.arrow_right),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Set Your Master Wifi"),
                    content: SizedBox(
                      height: 300,
                      child: Form(
                        key: masterFormKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                label: const Text("SSID"),
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(Icons.wifi),
                                fillColor: myColor.shade100,
                                filled: true,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Required Field";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  masterSsid = value;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                label: const Text("Password"),
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(Icons.lock),
                                fillColor: myColor.shade100,
                                filled: true,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Required Field";
                                } else if (value.length < 8) {
                                  return "Password Must Be 8 Character at least";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  masterPassword = value;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: screenWidth(context),
                              height: 55,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (masterFormKey.currentState!.validate()) {
                                    await setWifi(
                                        "master", masterSsid, masterPassword);
                                  }
                                },
                                child: const Text("Change"),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    myColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
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
                    changeConection("online");
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
