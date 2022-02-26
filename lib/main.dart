import 'package:ctrlx/blocs/auth_blocs/login/bloc/login_bloc.dart';
import 'package:ctrlx/blocs/auth_blocs/register/bloc/register_bloc.dart';
import 'package:ctrlx/blocs/family_bloc/bloc/family_bloc.dart';
import 'package:ctrlx/blocs/room_blocs/bloc/room_bloc.dart';
import 'package:ctrlx/blocs/switch_bloc/bloc/switch_bloc.dart';
import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/data/repositries/Family_repo.dart';
import 'package:ctrlx/data/repositries/auth_repo.dart';
import 'package:ctrlx/data/repositries/rooms_repo.dart';
import 'package:ctrlx/data/repositries/switches_repo.dart';
import 'package:ctrlx/screens/root_app.dart';
import 'package:ctrlx/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  
  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(AuthRepoImplementation())),
        BlocProvider(create: (context) => RegisterBloc(AuthRepoImplementation())),
        BlocProvider(create: (context) => RoomBloc(RoomsRepoImplementation())),
        BlocProvider(create: (context) => SwitchBloc(SwitchesRepoImplementation())),
        BlocProvider(create: (context) => FamilyBloc(FamilyRepoImplementation())),
      ],
      child: MaterialApp(
        title: 'CTRLX',
        theme: ThemeData(
          primarySwatch: myColor,
          textTheme: GoogleFonts.cairoTextTheme(
          Theme.of(context).textTheme,
        ),
        ),
        debugShowCheckedModeBanner: false,
        home: const Splash(),
      ),
    );
  }
}
