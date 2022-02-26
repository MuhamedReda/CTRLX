import 'dart:io';

import 'package:ctrlx/data/models/family_member.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';


abstract class FamilyRepo {
  Future<List<FamilyMember>> getAllFamily();
  Future addFamilyMember(String email , String password , String name,);
  Future deleteFamilyMember(int id);
}


class FamilyRepoImplementation extends FamilyRepo{
  @override
  Future addFamilyMember(String email , String password , String name,) async {
    var url = "http://www.control-x-co.com/api/SubUsers";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    await http.post(Uri.parse(url) , headers: {
      HttpHeaders.authorizationHeader : "Bearer $token",
    } , body: {
      'email' : email,
      'password' : password,
      'name' : name,
      'account_type' : 'Normal',
      'registeration_type' : 'Mobile'
    });
  }

  @override
  Future deleteFamilyMember(int id) async{
    var url = "http://www.control-x-co.com/api/SubUsers/$id";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    await http.delete(Uri.parse(url) , headers: {
      HttpHeaders.authorizationHeader : "Bearer $token",
    });
  }

  @override
  Future<List<FamilyMember>> getAllFamily() async {
    var url = "http://www.control-x-co.com/api/SubUsers";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.get(Uri.parse(url) , headers: {
      HttpHeaders.authorizationHeader : "Bearer $token",
    });
    var data = convert.jsonDecode(response.body);
    return data.map<FamilyMember>((item) => FamilyMember.fromJson(item)).toList();
  }
  
}