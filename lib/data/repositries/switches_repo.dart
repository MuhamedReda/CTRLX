import 'dart:io';

import 'package:ctrlx/data/models/switch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

abstract class SwitchRepo {
  Future<List<Switch>> getSwitches(int roomId);
  Future attachSwitchToRoom(String? roomId , String? serial ,  String? deviceName , String? type ,String? sub_1 , String? sub_2 , String? sub_3 );
  Future changeState(String? statename , int? currentState , String? serial);
  Future<List<Switch>> getActiveSwitches();
  Future allSwitches();
}

class SwitchesRepoImplementation extends SwitchRepo {
  @override
  Future attachSwitchToRoom(String? roomId , String? serial , String? deviceName ,  String? type , String? sub_1 , String? sub_2 , String? sub_3) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var data =await http.post(
      Uri.parse("http://control-x-co.com/api/AttachSwitchToRoom"),
      body:{
        'room_id' : roomId,
        'serial' : serial,
        'device_name' : deviceName,
        'type' : type ,
        'sub_1' : sub_1 ?? "",
        'sub_2' : sub_2 ?? "" ,
        'sub_3' : sub_3 ?? "",
      },
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    var res = convert.jsonDecode(data.body);
    if(res['error'] != null){
      return false;
    }else{
      return true;
    }
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

  @override
  Future allSwitches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    http.Response response = await http.get(
      Uri.parse("http://control-x-co.com/api/switches"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    var data = convert.jsonDecode(response.body);
    return data.map<Switch>((item) => Switch.fromJson(item)).toList();
  }

  
}
