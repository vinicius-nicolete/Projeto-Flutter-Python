import 'dart:convert';
import 'package:aqd_projeto/Services/Usuarios/LoginUsuario.dart';
import 'package:http/http.dart' as http;

class Login {
  
  static Future<LoginUsuario>? login(String user, String password) async {
    var url = Uri.parse('http://192.168.10.5:5000/login');

    var header = {"Content-Type": "application/json"};

    Map params = {"email": user, "password": password};

    var _body = json.encode(params);

    var response = await http.post(url, headers: header, body: _body);
    var usuario;

    Map mapResponse = json.decode(response.body);


      usuario = LoginUsuario.fromJson(mapResponse);

    return usuario;
  }
  

}
