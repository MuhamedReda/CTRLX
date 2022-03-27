import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

abstract class AuthRepo {
  login(String email, String password);
  createAccount(String username, String email, String phone, String address,
      String password);
}

class AuthRepoImplementation extends AuthRepo {
  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    var response = await http.post(
        Uri.parse("https://control-x-co.com/api/login"),
        body: {'email': email, 'password': password});
    final data = convert.jsonDecode(response.body);
    return data;
  }

  @override
  Future<Map<String, dynamic>> createAccount(String username, String email,
      String phone, String address, String password) async {
    http.Response response = await http.post(
      Uri.parse("https://control-x-co.com/api/Register"),
      body: {
        'name' : username,
        'email' : email,
        'phone' : phone,
        'address' : address,
        'account_type' : 'Normal',
        'password' : password,
        'registeration_type' : "Mobile"
      }
    );
    final data = convert.jsonDecode(response.body);
    return data;
  }
}
