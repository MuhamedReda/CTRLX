import 'package:ctrlx/blocs/auth_blocs/register/bloc/register_bloc.dart';
import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/consts/sizes.dart';
import 'package:ctrlx/screens/auth/login_screen.dart';
import 'package:ctrlx/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../root_app.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

var _registerformKey = GlobalKey<FormState>();

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  RegisterBloc? registerBloc;
  @override
  void initState() {
    registerBloc = BlocProvider.of<RegisterBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoadingState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Row(
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Please Wait"),
                    ],
                  ),
                );
              },
            );
          } else if (state is RegisterErorrState) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(state.message),
                );
              },
            );
          }else{
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const RootApp()), (route) => false);
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
                height: screenHeigh(context) / 3 * 1,
                padding: const EdgeInsets.all(25),
                child: const Center(
                  child: Image(
                    width: 180,
                    image: AssetImage("assets/images/logo.png"),
                  ),
                ),
              ),
              Container(
                width: screenWidth(context),
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: _registerformKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Create Your Smart Home .",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      userName(),
                      const SizedBox(
                        height: 15,
                      ),
                      emailAddressField(),
                      const SizedBox(
                        height: 15,
                      ),
                      phonenumberField(),
                      const SizedBox(
                        height: 15,
                      ),
                      addressField(),
                      const SizedBox(
                        height: 15,
                      ),
                      passwordField(),
                      const SizedBox(
                        height: 15,
                      ),
                      loginButton(context),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account ? "),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              },
                              child: const Text("Login")),
                        ],
                      ),
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
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.email),
        fillColor: myColor.shade100,
        filled: true,
      ),
      validator: (valu) {
        if (RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(valu.toString())) {
          return null;
        } else {
          return "Enter Valid Email-Address examble@examble.com";
        }
      },
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget userName() {
    return TextFormField(
      controller: username,
      decoration: InputDecoration(
        label: const Text("Username"),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.person),
        fillColor: myColor.shade100,
        filled: true,
      ),
      validator: (valu) {
        if (valu!.length > 6) {
          return null;
        } else if (valu.isEmpty) {
          return "username is required";
        } else {
          return "Enter Valid username";
        }
      },
      keyboardType: TextInputType.text,
    );
  }

  Widget addressField() {
    return TextFormField(
      controller: address,
      decoration: InputDecoration(
        label: const Text("Address"),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.location_city),
        fillColor: Colors.grey.shade200,
        filled: true,
      ),
      validator: (valu) {
        if (valu!.length > 10) {
          return null;
        } else if (valu.isEmpty) {
          return "Address is required";
        } else {
          return "Enter Valid Address";
        }
      },
      keyboardType: TextInputType.streetAddress,
    );
  }

  Widget phonenumberField() {
    return TextFormField(
      controller: phonenumber,
      decoration: InputDecoration(
        label: const Text("Phone number"),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.phone),
        fillColor: Colors.grey.shade200,
        filled: true,
      ),
      validator: (valu) {
        if (valu!.length > 11) {
          return "Phone number must be only 11 Characters";
        } else if (valu.isEmpty) {
          return "Phone number is required";
        } else if (RegExp(r'(^(?:[+0]1)[0-2]{1}?[0-9]{8})').hasMatch(valu)) {
          return null;
        } else {
          return "Enter Valid phone number";
        }
      },
      keyboardType: TextInputType.phone,
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: password,
      decoration: InputDecoration(
        label: const Text("Password"),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
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
        if (valu!.length > 8) {
          return null;
        } else {
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
        onPressed: () {
          if (_registerformKey.currentState!.validate()) {
            registerBloc!.add(RegisterSubmitted(username.text, email.text,
                address.text, phonenumber.text, password.text));
          }
        },
        child: const Text("Create Account"),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
          myColor.shade900,
        )),
      ),
    );
  }
}
