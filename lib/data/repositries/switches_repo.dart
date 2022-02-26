import 'dart:io';

import 'package:ctrlx/data/models/switch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

abstract class SwitchRepo {
  Future<List<Switch>> getSwitches(int roomId);
  Future attachSwitchToRoom(String roomId , String serial , String deviceName , String sub_1 , String sub_2 , String sub_3 );
  Future changeState(String? statename , int? currentState , String? serial);
  Future<List<Switch>> getActiveSwitches();
}

class SwitchesRepoImplementation extends SwitchRepo {
  @override
  Future attachSwitchToRoom(String roomId , String serial , String deviceName , String sub_1 , String sub_2 , String sub_3) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    await http.post(
      Uri.parse("http://control-x-co.com/api/AttachSwitchToRoom"),
      body:{
        'room_id' : roomId,
        'serial' : serial,
        'device_name' : deviceName,
        'sub_1' : sub_1,
        'sub_2' : sub_2,
        'sub_3' : sub_3,
      },
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
  }

  @override
  Future<List<Switch>> getSwitches(int roomId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    http.Response response = await http.get(
      Uri.parse("http://control-x-co.com/api/GetRoomSwitches/$roomId"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    var data = convert.jsonDecode(response.body);
    return data.map<Switch>((item) => Switch.fromJson(item)).toList();
  }

  @override
  Future changeState(String? statename, int? currentState , String? serial) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    String url = "http://control-x-co.com/api/${currentState == 0 ? 'on' : 'off'}/$serial?state=$statename";
    await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
  }

  @override
  Future<List<Switch>> getActiveSwitches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    http.Response response = await http.get(
      Uri.parse("http://control-x-co.com/api/GetActivatedSwitch"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    var data = convert.jsonDecode(response.body);
    return data.map<Switch>((item) => Switch.fromJson(item)).toList();
  }
}
