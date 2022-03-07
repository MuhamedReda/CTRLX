import 'package:ctrlx/data/models/offline_switch.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

abstract class OfflineRepo {
  Future<List<OfflineSwitch>> getActiveSwitches();
  Future<List<OfflineSwitch>> getAllSwitches();
  Future changeState(String state , String serial , String pin);
  Future setWifi(String type , String ssid , String password);
  Future changeConection(String connectionType);
}

class OfflineRepoImplementation extends OfflineRepo{
  @override
  Future<List<OfflineSwitch>> getActiveSwitches() async {
    var data = await http.get(Uri.parse("http://192.168.4.1/getActive"));
    var switches = convert.jsonDecode(data.body);
    return switches['switches'].map<OfflineSwitch>((item) => OfflineSwitch.fromJson(item)).toList();
  }

  @override
  Future<List<OfflineSwitch>> getAllSwitches() async {
    var data = await http.get(Uri.parse("http://192.168.4.1/getSwitches"));
    var switches = convert.jsonDecode(data.body);
    return switches['switches'].map<OfflineSwitch>((item) => OfflineSwitch.fromJson(item)).toList();
  }

  @override
  Future changeState(  String state , String serial , String pin ) async{
    await http.post(Uri.parse("http://192.168.4.1/setState") , body: {
      'serial' : serial,
      'pin' : pin,
      'state': state,
    });
  }

  @override
  Future changeConection(String connectionType)  async {
    await http.post(Uri.parse("http://192.168.4.1/setConnection") , body: {
      'type' : connectionType,
    });
  }

  @override
  Future setWifi(String type, String ssid, String password) async {
    await http.post(Uri.parse("http://192.168.4.1/updateWifi") , body: {
      'type' : type,
      'ssid' : ssid,
      'password': password,
    });
  }
}