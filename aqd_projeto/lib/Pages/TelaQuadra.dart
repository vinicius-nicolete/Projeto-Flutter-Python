import 'package:aqd_projeto/Pages/Func.dart';
import 'package:aqd_projeto/Services/Quadras/API_DeletarQuadra.dart';

import 'package:aqd_projeto/Services/Quadras/ListarQuadra.dart';
import 'package:aqd_projeto/Services/Quadras/API_ListarQuadra.dart';




import 'package:flutter/material.dart';

class TelaQuadra extends StatelessWidget {
  const TelaQuadra({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visualizar Quadras"),
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
    Future<List<ListarQuadras>> quadras = ListarQuadrasAPI.listarQuadras();
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
                    TextButton(onPressed: () {Navigator.pushNamed(context, '/TelaNovaQuadra');}, child: Text("Novo"))
                  ],
                ),
              )),
          FutureBuilder(
              future: quadras,
              builder: (context, snapshot) {
                Object? quadras = snapshot.data;
                if (snapshot.hasError) {
                  return Center(child: Text("Erro ao acessar os dados!"));
                }
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return _listasQuadra(quadras);
              }),
        ],
      ),
    );
  }

  _listasQuadra(quadras) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: quadras.length,
        itemBuilder: (context, index) {
          ListarQuadras q = quadras[index];
          return Container(
            padding: EdgeInsets.all(15),
            child: Card(
              child: ListTile(
                title: RichText(
                  text: TextSpan(
                      text: q.descricao, style: TextStyle(fontSize: 24,color: Colors.black)),
                ),
                subtitle: RichText(
                    text: TextSpan(
                        text: q.tipo, style: TextStyle(fontSize: 12,color: Colors.black))),
                leading: Icon(
                  Icons.sports_basketball_rounded,
                  size: 30,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: 30,
                  ),
                  onPressed: () async {
                   var deletarQuadra;
                     deletarQuadra = await DeletarQuadra.deletarQuadra(q.seqquadra);
                     Navigator.pushNamed(context, '/TelaQuadra');
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Quadra deletada com sucesso!")));
              
                    if(deletarQuadra.message == false){
                       alert(context, "Não foi possível deletar a quadra, entrar em contato com o administrador do sistema", "Erro");
                    }
                    }
                  ,
                ),
              ),
            ),
          );
        });
  }
}
