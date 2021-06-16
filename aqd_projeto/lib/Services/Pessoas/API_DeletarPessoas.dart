import 'dart:convert';
import 'package:aqd_projeto/Services/Pessoas/MessagePessoa.dart';

import 'package:http/http.dart' as http;

class DeletarPessoa {
  
  static Future<MessagePessoa>? deletarPessoa(int? id) async {
    var url = Uri.parse('http://192.168.10.5:5000/deletepessoa/$id');



    var response = await http.get(url);
    var quadra;

    Map mapResponse = json.decode(response.body);


      quadra = MessagePessoa.fromJson(mapResponse);

    return quadra;
  }
}
