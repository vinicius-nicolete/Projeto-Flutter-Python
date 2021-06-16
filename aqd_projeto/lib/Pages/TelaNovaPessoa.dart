import 'package:aqd_projeto/Pages/Func.dart';
import 'package:aqd_projeto/Services/Pessoas/API_NovaPessoa.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TelaNovaPessoa extends StatefulWidget {
  const TelaNovaPessoa({Key? key}) : super(key: key);

  @override
  _TelaNovaPessoaState createState() => _TelaNovaPessoaState();
}

class _TelaNovaPessoaState extends State<TelaNovaPessoa> {
  final _formKey = GlobalKey<FormState>();

  var criacaopessoa;

  var txtNome = TextEditingController();
  var txtSobrenome = TextEditingController();
  var txtCpf = TextEditingController();
  var txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar novo pessoa"),
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
            child: _formNovaPessoa(),
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

  Widget _formNovaPessoa() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            _textfield(txtNome, 100, TextInputType.text, "Nome", _validaNome),
            _textfield(txtSobrenome, 100, TextInputType.text, "Sobrenome",
                _validarSobrenome),
            _textfieldCPF(
                txtCpf, 100, TextInputType.number, "CPF", _validarCPF),
            _textfield(txtEmail, 100, TextInputType.emailAddress, "Email",
                _validarEmail),
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

  Widget _textfieldCPF(variavelcontrole, int maxLength, TextInputType tipoTexto,
      String hintText, String? Function(String?) f) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          CpfInputFormatter(),
        ],
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

  String? _validaNome(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe o Nome";
    } else if (value.length < 3) {
      return "Nome com caracteres insuficientes";
    } else if (value.length > 100) {
      return "Nome muito grande";
    }
    return null;
  }

  String? _validarSobrenome(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe o Sobrenome";
    } else if (value.length < 3) {
      return "Sobrenome com caracteres insuficientes";
    } else if (value.length > 100) {
      return "Sobrenome muito grande";
    }
    return null;
  }

  String? _validarCPF(String? value) {

    if (value == null || value.isEmpty) {
      return "Informe o CPF";
    } else if (!CPFValidator.isValid(value)) {
      return "CPF digitado inválido";
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
      String cpf = txtCpf.text;
      String nome = txtNome.text;
      String sobrenome = txtSobrenome.text;
      String email = txtEmail.text;

      criacaopessoa = await AdicionarPessoa.adicionarPessoa(
          nome, sobrenome, cpf, email);

      if (criacaopessoa.message != false) {
        Navigator.pushNamed(context, "/TelaPessoa");
      } else {
        alert(context, "CPF já existe na base!", "Erro");
      }
    }
  }
}
