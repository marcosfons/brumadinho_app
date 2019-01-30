


import 'dart:async';

import 'package:brumadinho/src/models/Filtro.dart';
import 'package:brumadinho/src/models/PessoaSemContato.dart';
import 'package:brumadinho/src/services/SemContato.dart';

import 'package:rxdart/rxdart.dart';

class HomeBloc {

  SemContatoData data = SemContatoData();
  
  List<PessoaSemContato> lista_pesquisa = [];
  Filtro filtro = Filtro(status: 'Ambos', categoria: 'Ambos');

  var _controllerPessoas = BehaviorSubject<List<PessoaSemContato>>();
  Stream get outPessoasDesaparecidas => _controllerPessoas.stream;

  void atualizarPessoasDesaparecidas() {
    _controllerPessoas.add(null);
    data.atualizarDados()
      .then((value) { value.sort((a,b) => a.nome.compareTo(b.nome)); _controllerPessoas.add(value); lista_pesquisa = value; })
      .catchError((error) => _controllerPessoas.addError(error));
  }

  void pesquisar(String query) {
    _controllerPessoas.add(lista_pesquisa.where((pessoa) {
      if(this.filtro.filtrar(pessoa))
        return pessoa.nome.toLowerCase().contains(query.toLowerCase());
      return false;
    }).toList());
  }

  void updateFiltro(Filtro filtro_p) {
    this.filtro = filtro_p;
    _controllerPessoas.add(lista_pesquisa.where((pessoa) {
      return filtro.filtrar(pessoa);
    }).toList());
  }

  void dispose() {
    _controllerPessoas.close();
  }

}