import 'package:ctrlx/blocs/auth_blocs/login/bloc/login_bloc.dart';
import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/consts/sizes.dart';
import 'package:ctrlx/screens/home_screen.dart';
import 'package:ctrlx/screens/auth/register_screen.dart';
import 'package:ctrlx/screens/root_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

var _loginformKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  LoginBloc? loginBloc;

  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc , LoginState>(
        listener: (context, state) {
          if(state is LoginErorrState){
            Navigator.pop(context);
            showDialog(
              context: context, 
              builder: (context) {
                return AlertDialog(
                  content: Text(state.message),
                );
              }
            );
          }else if(state is LoginLoadingState){
            showDialog(
              context: context, 
              builder: (context) {
                return AlertDialog(
                  content: Row(
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(width: 15,),
                      Text("Please Wait"),
                    ],
                  ),
                );
              }
            );
          }else{
            Navigator.pop(context);
            showDialog(
              context: context, 
              builder: (context) {
                return AlertDialog(
                  content: Row(
                    children: const [
                      Icon(Icons.verified),
                      SizedBox(width: 15,),
                      Text("Login Successed"),
                    ],
                  ),
                );
              }
            );
            Navigator.pushAndRemoveUntil(context, PageTransition(child: const RootApp(), type: PageTransitionType.rightToLeft) , (route) => false);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Container(
                width: screenWidth(context),
                height: screenHeigh(context) / 3 * 1.2,
                padding: const EdgeInsets.all(25),
                child: const Center(
                  child:  Image(
                    width: 180,
                    image: AssetImage("assets/images/logo.png"),),
                ),
              ),
              Container(
                width: screenWidth(context),
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: _loginformKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Login To Your Smart Home ." , 
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Row(
                        children: [
                          const Text("Do'nt have an account ? "),
                          TextButton(
                            onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                            }, 
                            child: const Text("Register")
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      emailAddressField(),
                      const SizedBox(
                        height: 15,
                      ),
                      passwordField(),
                      const SizedBox(
                        height: 15,
                      ),
                      loginButton(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget emailAddressField() {
  return TextFormField(
    controller: email,
    decoration: InputDecoration(
      label: const Text("Email Address"),
      border: UnderlineInputBorder(
        borderRadius:BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      prefixIcon: const Icon(Icons.email),
      fillColor: myColor.shade100,
      filled: true,  
      
    ),
    
    validator: (valu) {
      if( RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(valu.toString())){
        return null;
      }
      else{
        return "Enter Valid Email-Address examble@examble.com";
      }
    },

    keyboardType: TextInputType.emailAddress,
    
  );
}


Widget passwordField() {
  return TextFormField(
    controller: password,
    decoration: InputDecoration(
      label: const Text("Password"),
      border: UnderlineInputBorder(
        borderRadius:BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      prefixIcon: const Icon(Icons.lock),
      fillColor: Colors.grey.shade200,
      filled: true,  
      
    ),
    keyboardType: TextInputType.visiblePassword,
    obscureText: true,
    obscuringCharacter: "*",
    validator: (valu) {
      if( valu!.length >= 8){
        return null;
      }
      else{
        return "Enter Valid Password With at least 8 character";
      }
    },
  );                    
}


Widget loginButton(BuildContext context) {

  return SizedBox(
    width: screenWidth(context),
    height: 55,
    child: ElevatedButton(
      onPressed: (){
        if(_loginformKey.currentState!.validate()){
          loginBloc!.add(LoginSubmit(email.text, password.text));
        }
      }, 
      child: const Text("Login"),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          myColor,
        )
      ),
    ),
  );
}
}


