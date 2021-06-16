import 'dart:convert';
import 'package:aqd_projeto/Services/Usuarios/MessagemUsuario.dart';
import 'package:http/http.dart' as http;

class AdicionarUsuario {
  static Future<MessageUsuario>? adicionarUsuario(
      String email, String nome, String sobrenome, String password) async {
    var url = Uri.parse('http://192.168.10.5:5000/createuser');

    var header = {"Content-Type": "application/json"};

    Map params = {
      "email": email,
      "name": nome,
      "lastname": sobrenome,
      "password": password
    };

    var _body = json.encode(params);

    var response = await http.post(url, headers: header, body: _body);
    var usuario;

    Map mapResponse = json.decode(response.body);

    usuario = MessageUsuario.fromJson(mapResponse);

    return usuario;
  }
}
