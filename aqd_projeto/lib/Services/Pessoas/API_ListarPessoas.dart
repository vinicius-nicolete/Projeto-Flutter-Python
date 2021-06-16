import 'package:aqd_projeto/Services/Pessoas/ListarPessoa.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';


class ListarPessoasAPI {
  static Future<List<ListarPessoas>> listarPessoas() async {
    var url = Uri.parse('http://192.168.10.5:5000/listpessoa');

    var response = await http.get(url);

    List listaResponse = json.decode(response.body);

    final pessoas = new List<ListarPessoas>.empty(growable: true);
     
     for(Map map in listaResponse){
       ListarPessoas u = ListarPessoas.fromJson(map);
       pessoas.add(u);
     }
    
    return pessoas;
  }

}
