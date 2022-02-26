import 'dart:io';

import 'package:ctrlx/blocs/room_blocs/bloc/room_bloc.dart';
import 'package:ctrlx/consts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({Key? key}) : super(key: key);

  @override
  _AddRoomScreenState createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? img;
  RoomBloc? roomBloc;
  TextEditingController roomNameController = TextEditingController();
  var addRoomFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    roomBloc = BlocProvider.of<RoomBloc>(context);
    super.initState();
  }

  pickRoomImage() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    setState(() {
      img = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "Add Room",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: BlocListener<RoomBloc, RoomState>(
        listener: (context, state) {
          if (state is AddRoomLoadingState) {
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
          } else if (state is AddRoomLoadedState) {
            Navigator.pop(context);
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Icon(Icons.verified , size: 30, color: Colors.green,),
                  content: Center( child: Text("Room Added Successfully") , widthFactor: double.minPositive, heightFactor: double.minPositive),
                );
              },
            );
          } else if (state is AddRoomErrorState) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Icon(Icons.warning),
                  content: Text(state.message),
                );
              },
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    pickRoomImage();
                  },
                  child: Container(
                    width: screenWidth(context),
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: img != null
                          ? Image(
                              fit: BoxFit.cover,
                              image: FileImage(File(img!.path)),
                            )
                          : const Image(
                              width: 100,
                              height: 100,
                              image: AssetImage("assets/images/image.png"),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Form(
                  key: addRoomFormKey,
                  child: Column(
                    children: [
                      roomNameField(),
                      const SizedBox(
                        height: 15,
                      ),
                      addRoomButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget roomNameField() {
    return TextFormField(
      controller: roomNameController,
      decoration: InputDecoration(
        label: const Text("Room name"),
        contentPadding: const EdgeInsets.all(10),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.king_bed),
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

  Widget addRoomButton() {
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
          if (addRoomFormKey.currentState!.validate()) {
            roomBloc!.add(AddRoom(roomNameController.text, img));
          }
        },
        child: const Text("Add Room"),
      ),
    );
  }
}
