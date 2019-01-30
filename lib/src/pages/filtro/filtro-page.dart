


import 'package:brumadinho/src/models/Filtro.dart';
import 'package:flutter/material.dart';

class FiltroPage extends StatefulWidget {
  Filtro filtro;
  FiltroPage({Key key, this.filtro}) : super(key: key);

  @override
  _FiltroPageState createState() => _FiltroPageState();
}

class _FiltroPageState extends State<FiltroPage> {

  var value_status;
  var value_categoria;

  @override
  void initState() {
    value_status = widget.filtro.status;
    value_categoria = widget.filtro.categoria;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtros'),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context, widget.filtro),),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Status', style: TextStyle(fontSize: 16),),
                DropdownButton(
                  onChanged: (value) {
                    widget.filtro = Filtro(status: value, categoria: widget.filtro.categoria);
                    setState(() => value_status = value);
                  },
                  value: value_status,
                  items: [
                    DropdownMenuItem(child: Text('Ambos'),value: 'Ambos',),
                    DropdownMenuItem(child: Text('Sem Contato'),value: 'Sem Contato',),
                    DropdownMenuItem(child: Text('Localizado'), value: 'Localizado',),
                    DropdownMenuItem(child: Text('Óbito confirmado pelo IML'), value: 'Óbito confirmado pelo IML',)
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Categoria', style: TextStyle(fontSize: 16),),
                DropdownButton(
                  onChanged: (value) {
                    widget.filtro = Filtro(status: widget.filtro.status, categoria: value);
                    setState(() => value_categoria = value);
                  },
                  value: value_categoria,
                  items: [
                    DropdownMenuItem(child: Text('Ambos'),value: 'Ambos',),
                    DropdownMenuItem(child: Text('Próprios'), value: 'Próprios',),
                    DropdownMenuItem(child: Text('Terceiro/Comunidade'), value: 'Terceiro/Comunidade',)
                  ],
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}