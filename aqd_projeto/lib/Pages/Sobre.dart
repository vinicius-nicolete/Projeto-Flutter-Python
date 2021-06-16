import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        appBar: AppBar(
          centerTitle: true,
          title: Text('Sobre'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: RichText(
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text: 'O tema do projeto é um ERP.\n',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: "Arial"),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      'O objetivo do projeto é gerenciar de Alguel de Quadras desportivas.\n\n'),
                              TextSpan(
                                  text:
                                      'Os desenvolvedores do projeto do são : Joice Meriele Silva dos Reis RA: 2840481723039,'),
                              TextSpan(
                                  text:
                                      'Vinicius Assunção Nicolete RA: 2840481913028.\n\n'),
                              TextSpan(
                                  text:
                                      'Cursando Análise e Desenvolvimento de Sistema.\n\n'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Voltar"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey[600],
                      minimumSize: Size(double.infinity, 40)),
                )
              ],
            ),
          ),
        ));
  }
}
