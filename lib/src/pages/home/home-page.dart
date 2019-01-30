

import 'package:brumadinho/src/models/PessoaSemContato.dart';
import 'package:brumadinho/src/pages/filtro/filtro-page.dart';
import 'package:brumadinho/src/pages/home/home-bloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = HomeBloc();
    bloc.atualizarPessoasDesaparecidas();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brumadinho MG'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: () => bloc.atualizarPessoasDesaparecidas()),
          IconButton(icon: Icon(Icons.filter_list), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FiltroPage(filtro: bloc.filtro)))
              .then((value) => bloc.updateFiltro(value)); 
          })
        ],
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 40),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.grey[200],
              filled: true,
            ),
            onChanged: bloc.pesquisar,
          )
        ),
      ),
      body: StreamBuilder<List<PessoaSemContato>>(
        stream: bloc.outPessoasDesaparecidas,
        builder: (BuildContext context, AsyncSnapshot<List<PessoaSemContato>> snapshot) {
          if(snapshot.hasData) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('Resultados encontrados: ${snapshot.data.length}'),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(snapshot.data[index].nome, style: TextStyle(fontSize: 20, color: Colors.grey[600], fontWeight: FontWeight.w600),),
                              Container(height: 10,),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0, bottom: 2),
                                child: Text('Status: ${snapshot.data[index].status}'),
                              ),
                              snapshot.data[index].hospital != '' 
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 12.0, bottom: 2),
                                    child: Text('Hospital ${snapshot.data[index].hospital}')
                                 ) 
                                : Container(),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0, bottom: 5),
                                child: Text(snapshot.data[index].categoria),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          else if(snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}