import 'package:aqd_projeto/Services/Quadras/ListarQuadra.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';


class ListarQuadrasAPI {
  static Future<List<ListarQuadras>> listarQuadras() async {
    var url = Uri.parse('http://192.168.10.5:5000/listquadra');

    var response = await http.get(url);

    List listaResponse = json.decode(response.body);

    final quadras = new List<ListarQuadras>.empty(growable: true);
     
     for(Map map in listaResponse){
       ListarQuadras u = ListarQuadras.fromJson(map);
       quadras.add(u);
     }
    
    return quadras;
  }

}
