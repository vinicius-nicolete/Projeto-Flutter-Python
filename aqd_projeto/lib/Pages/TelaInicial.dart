
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aqd_projeto/Pages/Func.dart';


class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

String? nome;
String? email;

class _TelaInicialState extends State<TelaInicial> {
  @override
  void initState() {
    _recuperaNome();
    super.initState();
  }

  _recuperaNome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nome = prefs.getString('nome') ?? '';
      email = prefs.getString('email') ?? '';
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela Inicial"),
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
      body: Center(
        child: Text("Tela de inicio"),
      ),
      drawer:  drawerMenu(context),
    );
  }

  
}
