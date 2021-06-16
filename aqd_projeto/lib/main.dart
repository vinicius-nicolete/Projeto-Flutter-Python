import 'package:aqd_projeto/Pages/TelaInicial.dart';
import 'package:aqd_projeto/Pages/TelaNovaPessoa.dart';
import 'package:aqd_projeto/Pages/TelaNovaQuadra.dart';
import 'package:aqd_projeto/Pages/TelaNovoUsuario.dart';
import 'package:aqd_projeto/Pages/TelaPessoa.dart';
import 'package:aqd_projeto/Pages/TelaQuadra.dart';
import 'package:aqd_projeto/Pages/TelaUsuario.dart';



import 'package:flutter/material.dart';



import 'Pages/Sobre.dart';
import 'Pages/TelaLogin.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AQD - ERP em Gerenciamento de Quadras",
      theme: ThemeData(
        primaryColor: Colors.grey[600],
        backgroundColor: Colors.grey[100],
        fontFamily: 'Arial',
      ),
      initialRoute: '/HomePage',
      routes: {
        '/HomePage': (context) => HomePage(),
        '/TelaLogin': (context) => TelaLogin(),
        '/TelaInicial': (context) => TelaInicial(),
        '/TelaUsuario': (context) => TelaUsuario(),
        '/TelaNovoUsuario': (context) => TelaNovoUsuario(),
        '/TelaQuadra': (context) => TelaQuadra(),
        '/TelaNovaQuadra': (context) => TelaNovaQuadra(),
        '/TelaPessoa': (context) => TelaPessoa(),
        '/TelaNovaPessoa': (context) => TelaNovaPessoa(),
        '/Sobre': (context) => Sobre()
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tela de inicio'),
        ),
        body: Column(
          children: [
            Image.asset(
              'images/logo.png',
              alignment: Alignment.topCenter,
            ),
            Expanded(
                child: RichText(
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        text:
                            "\n\nSeja bem-vindo ao ERP de Gestão de Quadras.\nClique em proximo para realizar o login.",
                        style: TextStyle(fontSize: 16, color: Colors.black)))),
            Container(
              padding: EdgeInsets.all(50),
              child: SingleChildScrollView(
                child: ButtonTheme(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/TelaLogin');
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey[600],
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(20)),
                        minimumSize: Size(double.infinity, 40)),
                    child: Text("Proximo",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        )),
                  ),
                ),
              ),
              alignment: Alignment.bottomCenter,
            ),
          ],
        ));
  }
}



