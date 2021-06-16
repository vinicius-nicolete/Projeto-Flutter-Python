import 'package:aqd_projeto/Pages/TelaInicial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

alert(BuildContext context, String msg, String title) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ok"))
          ],
        );
      });
}

_listTile(BuildContext context, String title, IconData icon, String pagina) {
  return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.pushNamed(context, pagina);
      });
}

drawerMenu(BuildContext context) {
  return Drawer(
    semanticLabel: "Menu",
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('images/drawer_header_background.png'))),
            child: Stack(children: <Widget>[
              Positioned(
                  bottom: 12.0,
                  left: 16.0,
                  child: Text("$nome",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500))),
            ])),
        _listTile(
          context, "Inicio", Icons.home, '/TelaInicial'),
        _listTile(
            context, "Usuarios", Icons.account_circle_rounded, '/TelaUsuario'),
        _listTile(context, "Quadras", Icons.sports_basketball_rounded,
            '/TelaQuadra'),
        _listTile(
            context, "Pessoas", Icons.people_alt_rounded, '/TelaPessoa'),
        _listTile(
            context, "Agendamento", Icons.schedule_rounded, '/TelaAgendamento'),
         Container( alignment: Alignment.bottomCenter, child: _listTile(
            context, "Logout", Icons.logout_rounded, '/TelaLogin'),
         )
      ],
    ),
  );
}
