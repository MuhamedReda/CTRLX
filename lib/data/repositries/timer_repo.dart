import 'dart:io';

import 'package:ctrlx/data/models/timer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

abstract class TimerRepo{
  Future<List<Timer>> getTimers( String switchId );
  Future setTimers( String switchId  ,String roomId , String time , String stateNo , int state);
  Future deleteTimers( String timerId );
}

class TimerRepoImplementation extends TimerRepo{
  @override
  Future deleteTimers(String timerId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    await http.delete(
      Uri.parse("https://control-x-co.com/api/DeleteTimer/$timerId"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
  }

  @override
  Future<List<Timer>> getTimers(String switchId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    http.Response response = await http.get(
      Uri.parse("https://control-x-co.com/api/GetTimer/$switchId"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    var data = convert.jsonDecode(response.body);
    return data.map<Timer>((item) => Timer.fromJson(item)).toList();
  }

  @override
  Future setTimers(String switchId, String roomId, String time , String stateNo , int state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    await http.post(
      Uri.parse("https://control-x-co.com/api/SetTimer"),
      body:{
        'time' : time,
        'switch_id' : switchId,
        'sub_no' : stateNo,
        'state' : state.toString() ,
      },
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
  }
  
}