import 'package:aqd_projeto/Pages/Func.dart';
import 'package:aqd_projeto/Services/Usuarios/API_AdicionarUsuario.dart';
import 'package:flutter/material.dart';


class TelaNovoUsuario extends StatefulWidget {
  const TelaNovoUsuario({Key? key}) : super(key: key);

  @override
  _TelaNovoUsuarioState createState() => _TelaNovoUsuarioState();
}

class _TelaNovoUsuarioState extends State<TelaNovoUsuario> {
  final _formKey = GlobalKey<FormState>();

  var criacaousuario;

  var txtNome = TextEditingController();
  var txtSobrenome = TextEditingController();
  var txtUsuario = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  var txtRepeteSenha = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar novo usuário"),
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
      body: Column(
          children: [ Padding(
            padding: const EdgeInsets.all(10.0),
            child: _formNovoUsuario(),
          ),
            Container(
      padding: EdgeInsets.all(10),
      child: _buttonSend(),
            ),
          ],
        ),
      drawer: drawerMenu(context),
    );
  }

  Widget _formNovoUsuario() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            _textfield(txtNome,100, TextInputType.name, "Nome", _validaNome),
            _textfield(txtSobrenome,100, TextInputType.name, "Sobrenome", _validaSobrenome),
            _textfield(txtEmail,
                100, TextInputType.emailAddress, "E-mail", _validarEmail),
            _textfieldPassword(txtSenha,100, TextInputType.visiblePassword, "Senha",
                _validaPassword),
            _textfieldPassword(txtRepeteSenha,100, TextInputType.visiblePassword,
                "Digite novamente o senha", _validaPasswordRepete),
          ],
        ));
  }

  Widget _textfield(variavelcontrole,int maxLength, TextInputType tipoTexto, String hintText,
      String? Function(String?) f) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        controller:variavelcontrole ,
        decoration: InputDecoration(
            labelText: hintText,
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
            )),
        keyboardType: tipoTexto,
        validator: f,
      ),
    );
  }

  Widget _textfieldPassword(variavelcontrole,int maxLength, TextInputType tipoTexto,
      String hintText, String? Function(String?) f) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        controller: variavelcontrole,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
            hintText: hintText,
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
            )),
        keyboardType: tipoTexto,
        validator: f,
      ),
    );
  }

  String? _validaNome(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe o Nome";
    } else if (value.length < 3) {
      return "Nome com caracteres insuficientes, informe o nome completo";
    } else if (value.length > 100) {
      return "Nome muito grande, tente abreviar";
    }
    return null;
  }
  String? _validaSobrenome(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe o Sobrenome";
    } else if (value.length < 3) {
      return "Sobrenome com caracteres insuficientes, informe o nome completo";
    } else if (value.length > 100) {
      return "Sobrenome muito grande, tente abreviar";
    }
    return null;
  }



  String? _validarEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "Informe o Email";
    } else if (value.length > 100) {
      return "Email muito grande";
    } else if (!regExp.hasMatch(value)) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  String? _validaPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe a senha";
    } else if (value.length <= 5) {
      return "Senha com caracteres insuficientes, informe uma senha maior";
    } else if (value.length > 100) {
      return "Senha muito grande";
    }
    return null;
  }
    String? _validaPasswordRepete(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe a senha";
    } else if (value.length <= 5) {
      return "Senha com caracteres insuficientes, informe uma senha maior";
    } else if (value.length > 100) {
      return "Senha muito grande";
    }else if(value != txtSenha.text){
      return "As senhas não batem";
    }
    return null;
  }
    Widget _buttonSend() {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 100, 30, 0),
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () {
          _sendForm(context);
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.grey[600], minimumSize: Size(double.infinity, 40)),
        child: Text("Enviar"),
      ),
    );
  }

    _sendForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String senha = txtSenha.text;
      String nome = txtNome.text;
      String email = txtEmail.text;
      String sobrenome = txtSobrenome.text;
      criacaousuario = await AdicionarUsuario.adicionarUsuario(email,nome,sobrenome,senha);

      if (criacaousuario.message != false) { 
    Navigator.pushNamed(context, '/TelaUsuario');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Usuário adicionado com sucesso!")));
       
      } else {
        alert(context, "Email já existe na base de usuarios!", "Erro");
      }
    }
  }
}
