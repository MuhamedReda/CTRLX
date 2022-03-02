import 'package:ctrlx/data/models/switch.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

abstract class OfflineRepo {
  Future<List<Switch>> getActiveSwitches();
  Future<List<Switch>> getAllSwitches();
  Future changeState(String state , String serial);
}

class OfflineRepoImplementation extends OfflineRepo{
  @override
  Future<List<Switch>> getActiveSwitches() async {
    var data = await http.get(Uri.parse("uri"));
    var switches = convert.jsonDecode(data.body);
    return switches.map<Switch>((item) => Switch.fromJson(item)).toList();
  }

  @override
  Future<List<Switch>> getAllSwitches() async {
    var data = await http.get(Uri.parse("uri"));
    var switches = convert.jsonDecode(data.body);
    return switches.map<Switch>((item) => Switch.fromJson(item)).toList();
  }

  @override
  Future changeState(  String state , String serial ) async{
    await http.post(Uri.parse("uri") , body: {
      'state' : state,
      'serial' : serial,
    });
  }
}