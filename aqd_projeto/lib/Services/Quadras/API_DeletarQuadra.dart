import 'dart:convert';
import 'package:aqd_projeto/Services/Quadras/MessageQuadra.dart';

import 'package:http/http.dart' as http;

class DeletarQuadra {
  
  static Future<MessageQuadra>? deletarQuadra(int? id) async {
    var url = Uri.parse('http://192.168.10.5:5000/deletequadra/$id');



    var response = await http.get(url);
    var quadra;

    Map mapResponse = json.decode(response.body);


      quadra = MessageQuadra.fromJson(mapResponse);

    return quadra;
  }
}
