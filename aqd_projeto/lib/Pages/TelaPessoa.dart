import 'dart:io';

import 'package:aqd_projeto/Pages/Func.dart';
import 'package:aqd_projeto/Services/Pessoas/API_DeletarPessoas.dart';
import 'package:aqd_projeto/Services/Pessoas/API_ListarPessoas.dart';
import 'package:aqd_projeto/Services/Pessoas/ListarPessoa.dart';
import 'package:dio/dio.dart';


import 'package:flutter/material.dart';
var file1 = File("/storage/emulated/0/Download/import.json");
class TelaPessoa extends StatelessWidget {
  const TelaPessoa({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visualizar Pessoas"),
        centerTitle: true,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: 'Menu',
          );
        }),
      ),
      body: _body(context),
      drawer: drawerMenu(context),
    );
  }

  _body(BuildContext context) {
    Future<List<ListarPessoas>> pessoas = ListarPessoasAPI.listarPessoas();
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              padding: EdgeInsets.all(15),
              child: ButtonTheme(
                child: ButtonBar(
                  children: <Widget>[
                    TextButton(onPressed: () async {_upload(file1);Navigator.pushNamed(context, '/TelaPessoa');}, child: Text("Importar")),
                    TextButton(onPressed: () {Navigator.pushNamed(context, '/TelaNovaPessoa');}, child: Text("Novo"))
                  ],
                ),
              )),
          FutureBuilder(
              future: pessoas,
              builder: (context, snapshot) {
                Object? pessoas = snapshot.data;
                if (snapshot.hasError) {
                  return Center(child: Text("Erro ao acessar os dados!"));
                }
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return _listasPessoas(pessoas);
              }),
        ],
      ),
    );
  }

  _listasPessoas(pessoas) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: pessoas.length,
        itemBuilder: (context, index) {
          ListarPessoas p = pessoas[index];
          return Container(
            padding: EdgeInsets.all(15),
            child: Card(
              child: ListTile(
                title: RichText(
                  text: TextSpan(
                      text: "${p.nome} ${p.sobrenome}", style: TextStyle(fontSize: 24,color: Colors.black)),
                ),
                subtitle: RichText(
                    text: TextSpan(
                        text: p.cpf, style: TextStyle(fontSize: 12,color: Colors.black))),
                leading: Icon(
                  Icons.people_alt_rounded,
                  size: 30,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: 30,
                  ),
                  onPressed: () async {
                   var deletarPessoa;
                     deletarPessoa = await DeletarPessoa.deletarPessoa(p.seqpessoa);
                     Navigator.pushNamed(context, '/TelaPessoa');
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pessoa deletada com sucesso!")));
              
                    if(deletarPessoa.message == false){
                       alert(context, "Não foi possível deletar a pessoa, entrar em contato com o administrador do sistema", "Erro");
                    }
                    }
                  ,
                ),
              ),
            ),
          );
        });
  }
   void _upload(File file1) async {
    String fileName = file1.path.split('/').last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file1.path,
        filename: fileName,
      ),
    });

    Dio dio = new Dio();

    dio
        .post("http://192.168.10.5:5000/importfile", data: data)
        .then((response) => print(response.statusMessage)  )
        .catchError((error) => print(error));
  }
}

