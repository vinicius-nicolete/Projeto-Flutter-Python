import 'dart:convert';
import 'package:aqd_projeto/Services/Quadras/MessageQuadra.dart';

import 'package:http/http.dart' as http;

class AdicionarQuadra {
  
  static Future<MessageQuadra> adicionarQuadra(String descricao, String tipo,String largura, String comprimento) async {
    var url = Uri.parse('http://192.168.10.5:5000/createquadra');

    var header = {"Content-Type": "application/json"};

    Map params = {"descricao": descricao,"tipo": tipo,"comprimento": comprimento ,"largura": largura};

    var _body = json.encode(params);

    var response = await http.post(url, headers: header, body: _body);
    var quadra;

    Map mapResponse = json.decode(response.body);


      quadra = MessageQuadra.fromJson(mapResponse);

    return quadra;
  }
}
