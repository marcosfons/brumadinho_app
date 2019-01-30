

import 'package:brumadinho/src/models/PessoaSemContato.dart';

class Filtro{
  String status;
  String categoria;

  Filtro({this.status, this.categoria});

  bool filtrar(PessoaSemContato pessoa) {
    if(this.status == 'Ambos' && this.categoria == 'Ambos')
      return true;
    else if(this.status == 'Ambos')
      return pessoa.categoria == this.categoria;
    else if(this.categoria == 'Ambos')
      return pessoa.status == this.status;
    else
      return pessoa.status == this.status && pessoa.categoria == this.categoria;
  }

}