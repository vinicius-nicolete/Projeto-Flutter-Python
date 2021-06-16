import 'dart:convert';
import 'package:aqd_projeto/Services/Pessoas/MessagePessoa.dart';
import 'package:http/http.dart' as http;

class AdicionarPessoa {
  static Future<MessagePessoa> adicionarPessoa(
      String nome, String sobrenome, String cpf, String email) async {
    var url = Uri.parse('http://192.168.10.5:5000/createpessoa');

    var header = {"Content-Type": "application/json"};

    Map params = {
      "nome": nome,
      "sobrenome": sobrenome,
      "cpf": cpf,
      "email": email
    };

    var _body = json.encode(params);

    var response = await http.post(url, headers: header, body: _body);
    var pessoa;

    Map mapResponse = json.decode(response.body);
    pessoa = MessagePessoa.fromJson(mapResponse);

    return pessoa;
  }
}
