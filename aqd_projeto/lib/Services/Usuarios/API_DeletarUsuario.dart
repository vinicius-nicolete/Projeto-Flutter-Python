import 'dart:convert';
import 'package:aqd_projeto/Services/Usuarios/MessagemUsuario.dart';
import 'package:http/http.dart' as http;

class DeletarUsuario {
  
  static Future<MessageUsuario>? deletarUsuario(int? id) async {
    var url = Uri.parse('http://192.168.10.5:5000/deleteuser/$id');



    var response = await http.get(url);
    var usuario;

    Map mapResponse = json.decode(response.body);


      usuario = MessageUsuario.fromJson(mapResponse);

    return usuario;
  }
}
