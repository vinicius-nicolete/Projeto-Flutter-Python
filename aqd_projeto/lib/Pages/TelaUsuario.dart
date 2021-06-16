

import 'package:aqd_projeto/Pages/Func.dart';
import 'package:aqd_projeto/Pages/TelaInicial.dart';
import 'package:aqd_projeto/Services/Usuarios/API_DeletarUsuario.dart';


import 'package:aqd_projeto/Services/Usuarios/ListarUsuario.dart';
import 'package:aqd_projeto/Services/Usuarios/API_ListarUsuario.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:permission_handler/permission_handler.dart';

final exportUrl = "http://192.168.10.5:5000/sendfile/export.zip";

bool downloading = false;
var progressString = "";


class TelaUsuario extends StatefulWidget {
  const TelaUsuario({Key? key}) : super(key: key);

  @override
  _TelaUsuarioState createState() => _TelaUsuarioState();
}

class _TelaUsuarioState extends State<TelaUsuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visualizar Usuários"),
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
    Future<List<ListarUsuario>> usuarios = UsuariosAPI.listarUsuarios();
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
                    
                    TextButton(
                        onPressed: () async {
                          downloadFile();
                        },
                        child: Text("Exportar")),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/TelaNovoUsuario');
                        },
                        child: Text("Novo"))
                  ],
                ),
              )),
          FutureBuilder(
              future: usuarios,
              builder: (context, snapshot) {
                Object? usuarios = snapshot.data;
                if (snapshot.hasError) {
                  return Center(child: Text("Erro ao acessar os dados!"));
                }
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return _listasUsuarios(usuarios);
              }),
        ],
      ),
    );
  }

  _listasUsuarios(usuarios) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          ListarUsuario u = usuarios[index];
          return Container(
            padding: EdgeInsets.all(15),
            child: Card(
              child: ListTile(
                title: RichText(
                  text: TextSpan(
                      text: "${u.name} ${u.lastname}",
                      style: TextStyle(fontSize: 24, color: Colors.black)),
                ),
                subtitle: RichText(
                    text: TextSpan(
                        text: u.email,
                        style: TextStyle(fontSize: 12, color: Colors.black))),
                leading: Icon(
                  Icons.person,
                  size: 30,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.person_remove_rounded,
                    size: 30,
                  ),
                  onPressed: () async {
                    var deletarUsuario;

                    if (email != u.email) {
                      deletarUsuario =
                          await DeletarUsuario.deletarUsuario(u.userid);
                      Navigator.pushNamed(context, '/TelaUsuario');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Usuário deletado com sucesso!")));
                    } else if (email == u.email) {
                      alert(
                          context, "Não é possível deletar a si mesmo", "Erro");
                    } else if (deletarUsuario.message == false) {
                      alert(
                          context,
                          "Não foi possível deletar o usuário, entrar em contato com o administrador do sistema",
                          "Erro");
                    }
                  },
                ),
              ),
            ),
          );
        });
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();

    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      await dio.download(exportUrl, "/storage/emulated/0/Download/export.zip",
          onReceiveProgress: (rec, total) {
        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
        });
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    print("Download completo");
  }

 
}