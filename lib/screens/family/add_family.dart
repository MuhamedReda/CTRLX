import 'package:ctrlx/blocs/family_bloc/bloc/family_bloc.dart';
import 'package:ctrlx/consts/colors.dart';
import 'package:ctrlx/consts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFamilyMember extends StatefulWidget {
  const AddFamilyMember({Key? key}) : super(key: key);

  @override
  _AddFamilyMemberState createState() => _AddFamilyMemberState();
}

class _AddFamilyMemberState extends State<AddFamilyMember> {

  FamilyBloc? familyBloc;

  @override
  void initState() {
    familyBloc = BlocProvider.of<FamilyBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColor,
        title: const Text("Add Member"),
        centerTitle: true,
      ),
      body: BlocListener<FamilyBloc, FamilyState>(
        listener: (context, state) {
          if(state is FamilyAddLoading){
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Row(
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Please Wait"),
                    ],
                  ),
                );
              },
            );
          }else if(state is FamilyAddLoaded){
            familyBloc!.add(GetFamily());
            Navigator.pop(context);
            Navigator.pop(context);            
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Icon(Icons.verified , size: 32, color: Colors.green,),
                  content: Center( child: Text("Member Added Successfully") , widthFactor: double.minPositive, heightFactor: double.minPositive),
                );
              },
            );
          }
        },
        child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  child: Column(
                    
                    children: [
                      memberNameField(),
                      const SizedBox(
                        height: 15,
                      ),
                      memberEmailField(),
                      const SizedBox(
                        height: 15,
                      ),
                      memberPasswordField(),
                      const SizedBox(
                        height: 25,
                      ),
                      addMemberButton(),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }

  TextEditingController memberNameController = TextEditingController();
  TextEditingController memberEmailController = TextEditingController();
  TextEditingController memberPasswordController = TextEditingController();
  Widget memberNameField() {
    return TextFormField(
      controller: memberNameController,
      decoration: InputDecoration(
        label: const Text("Memeber name"),
        contentPadding: const EdgeInsets.all(10),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.person),
        filled: true,
        fillColor: Colors.grey.shade200,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "@Required field";
        } else {
          return null;
        }
      },
    );
  }

  Widget memberEmailField() {
    return TextFormField(
      controller: memberEmailController,
      decoration: InputDecoration(
        label: const Text("Member Email"),
        contentPadding: const EdgeInsets.all(10),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.email),
        filled: true,
        fillColor: Colors.grey.shade200,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "@Required field";
        } else {
          return null;
        }
      },
    );
  }

  Widget memberPasswordField() {
    return TextFormField(
      controller: memberPasswordController,
      decoration: InputDecoration(
        label: const Text("Password"),
        contentPadding: const EdgeInsets.all(10),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.lock),
        filled: true,
        fillColor: Colors.grey.shade200,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "@Required field";
        } else {
          return null;
        }
      },
    );
  }

  Widget addMemberButton() {
    return SizedBox(
      width: screenWidth(context),
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: () {
          familyBloc!.add(AddFamilyMemeber(memberEmailController.text, memberPasswordController.text, memberNameController.text));
        },
        child: const Text("Add Member"),
      ),
    );
  }
}
