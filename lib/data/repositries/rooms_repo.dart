import 'dart:io';

import 'package:ctrlx/data/models/room.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

abstract class RoomsRepo {
  Future<List<Room>> getAllRooms();
  Future addRoom(String name, XFile img);
  Future<void> deleteRoom(String id);
}

class RoomsRepoImplementation extends RoomsRepo {
  @override
  Future addRoom(String name, XFile img) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    MultipartFile image = await MultipartFile.fromFile(img.path);
    FormData data = FormData.fromMap({'name': name, 'photo_link': image});
    await Dio().post(
      "http://control-x-co.com/api/rooms",
      data: data,
      options: Options(
        headers: {
          'authorization': 'Bearer $token',
        },
      ),
    );
  }

  @override
  Future<void> deleteRoom(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    await http
        .delete(Uri.parse("http://control-x-co.com/api/rooms/$id"), headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    });
  }

  @override
  Future<List<Room>> getAllRooms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var roomResponse = await http
        .get(Uri.parse("http://control-x-co.com/api/rooms"), headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    });
    var data = convert.jsonDecode(roomResponse.body);
    return data.map<Room>((item) => Room.fromJson(item)).toList();
  }
}
