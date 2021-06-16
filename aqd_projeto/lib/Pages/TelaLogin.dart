import 'package:aqd_projeto/Pages/Func.dart';
import 'package:aqd_projeto/Services/Usuarios/API_LoginApi.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  var formkey = GlobalKey<FormState>();
  var usuario;

  var txtUsuario = TextEditingController();
  var txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rola Bola'),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 25, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Acessar sua conta ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                campoUsuario(txtUsuario),
                campoSenha(txtSenha),
                botaoSubmit(),
                botaoSobre()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget campoUsuario(variavelcontrole) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: variavelcontrole,
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          labelText: 'Usuário',
        ),
        validator: _validaUsuario,
      ),
    );
  }

  Widget campoSenha(variavelcontrole) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: TextFormField(
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        controller: variavelcontrole,
        keyboardType: TextInputType.visiblePassword,
        validator: _validaSenha,
        decoration:
            InputDecoration(icon: Icon(Icons.lock), labelText: 'Senha '),
      ),
    );
  }

  Widget botaoSubmit() {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 100, 30, 0),
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () {
          _sendForm(context);
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.grey[600], minimumSize: Size(double.infinity, 40)),
        child: Text("Entrar"),
      ),
    );
  }

  Widget botaoSobre() {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () {
        Navigator.pushNamed(context, '/Sobre');
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.grey[600], minimumSize: Size(double.infinity, 40)),
        child: Text("Sobre"),
      ),
    );
  }

  String? _validaUsuario(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe o usúario";
    }

    return null;
  }

  String? _validaSenha(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe a senha";
    }
    return null;
  }

  _sendForm(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      String login = txtUsuario.text;
      String senha = txtSenha.text;

      usuario = await Login.login(login, senha);

      if (usuario.message != false) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('nome', usuario.name);
        prefs.setString('email', usuario.email);
        Navigator.pushNamed(context, '/TelaInicial');
      } else {
        alert(context, "Login Inválido!", "Login");
      }
    }
  }
}
