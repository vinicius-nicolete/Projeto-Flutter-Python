import 'package:aqd_projeto/Services/Usuarios/ListarUsuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class UsuariosAPI {
  static Future<List<ListarUsuario>> listarUsuarios() async {
    var url = Uri.parse('http://192.168.10.5:5000/listuser');

    var response = await http.get(url);

    List listaResponse = json.decode(response.body);

    final usuarios = new List<ListarUsuario>.empty(growable: true);
     
     for(Map map in listaResponse){
       ListarUsuario u = ListarUsuario.fromJson(map);
       usuarios.add(u);
     }
    
    return usuarios;
  }

}
