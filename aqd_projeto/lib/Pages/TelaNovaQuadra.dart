import 'package:aqd_projeto/Pages/Func.dart';
import 'package:aqd_projeto/Services/Quadras/API_NovaQuadra.dart';

import 'package:flutter/material.dart';

class TelaNovaQuadra extends StatefulWidget {
  const TelaNovaQuadra({Key? key}) : super(key: key);

  @override
  _TelaNovaQuadraState createState() => _TelaNovaQuadraState();
}

class _TelaNovaQuadraState extends State<TelaNovaQuadra> {
  final _formKey = GlobalKey<FormState>();

  var criacaoquadra;

  var txtDescricao = TextEditingController();
  var txtTipo = TextEditingController();
  var txtComprimento = TextEditingController();
  var txtLargura = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar nova quadra"),
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
        children: [
          Padding(
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
            _textfield(txtDescricao, 100, TextInputType.text, "Descrição",
                _validaDescricao),
            _textfield(txtTipo, 100, TextInputType.text, "Tipo de Quadra",
                _validarQuadra),
            _textfield(
                txtComprimento,
                100,
                TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false,
                ),
                "Comprimento",
                _validarComprimento),
            _textfield(
                txtLargura,
                100,
                TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false,
                ),
                "Largura",
                _validarLargura),
          ],
        ));
  }

  Widget _textfield(variavelcontrole, int maxLength, TextInputType tipoTexto,
      String hintText, String? Function(String?) f) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        controller: variavelcontrole,
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

  String? _validaDescricao(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe a descricão";
    } else if (value.length <= 5) {
      return "Descrição com caracteres insuficientes";
    } else if (value.length > 100) {
      return "Descrição muito grande";
    }
    return null;
  }

  String? _validarQuadra(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe o tipo de quadra";
    } else if (value.length <= 5) {
      return "Tipo de quadra com caracteres insuficientes";
    } else if (value.length > 100) {
      return "Tipo de quadra muito grande";
    }
    return null;
  }

  String? _validarComprimento(String? value) {
    String patttern = r'(^[0-9.]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value == null || value.isEmpty) {
      return "Informe a largura";
    } else if (!regExp.hasMatch(value)) {
      return "A largura deve conter apenas dígitos e ponto";
    }
    return null;
  }

  String? _validarLargura(String? value) {
    String patttern = r'(^[0-9.]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value == null || value.isEmpty) {
      return "Informe o comprimento";
    } else if (!regExp.hasMatch(value)) {
      return "O comprimento  deve conter apenas dígitos e ponto";
    }
    return null;
  }

  Widget _buttonSend() {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
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
      String comprimento = txtComprimento.text;
      String descricao = txtDescricao.text;
      String tipo = txtTipo.text;
      String largura = txtLargura.text;

      criacaoquadra = await AdicionarQuadra.adicionarQuadra(
          descricao, tipo, comprimento, largura);

      if (criacaoquadra.message != false) {
        Navigator.pushNamed(context, "/TelaQuadra");
      } else {
        alert(context, "Descrição já existe na base!", "Erro");
      }
    }
  }
}
