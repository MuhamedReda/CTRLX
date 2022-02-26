import 'package:ctrlx/screens/auth/login_screen.dart';
import 'package:ctrlx/screens/root_app.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {





  @override
  void initState() {
    check();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
        body: Center(
      child: Image(
        width: 180,
        image: AssetImage('assets/images/logo.png'),
      ),
    ));
  }

  check() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Future.delayed( const Duration(seconds: 5) , () {
      if (token != null) {
        Navigator.pushAndRemoveUntil(context, PageTransition(child: const RootApp(), type: PageTransitionType.rightToLeft), (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(context, PageTransition(child: const LoginScreen(), type: PageTransitionType.rightToLeft), (route) => false);
      }
    });   
  }
}
