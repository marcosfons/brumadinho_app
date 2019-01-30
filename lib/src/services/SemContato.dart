


import 'package:brumadinho/src/models/PessoaSemContato.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode, utf8;

class SemContatoData {
  
  static String url = 'http://brumadinho.vale.com/listagem-pessoas-sem-contato.html';
  static String urlFirebase = 'https://brumadinho-5d26e.firebaseio.com/.json';
  /*
  Future<List<PessoaSemContato>> atualizarDados() async {
    var response = await http.get(url);
    if(response.statusCode == 200) {
      //print(response.body);
      var dom = parse(response.body);
      String ultAtt = dom.getElementsByClassName('corponew')[0].getElementsByTagName('p')[3].text;
      ultAtt = 'Última atualização ' + ultAtt.substring(22+45-21, 32+45-21) + '  às  ' + ultAtt.substring(36+45-21, 42+45-21);
      return dom.getElementsByClassName('corponew')[0].getElementsByTagName('ul')[0].children 
        .map((li) => PessoaSemContato(li.text, ultAtt, StatusPessoa.Desaparecido)).toList().cast<PessoaSemContato>();
    } else {
      throw('Erro ao fazer o request: ${response.statusCode}');
    }
  }
  */

  Future<List<PessoaSemContato>> atualizarDados() async {
    var response = await http.get(urlFirebase);
    if(response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json[json.keys.toList()[0]].map((pessoa) => PessoaSemContato.fromJson(pessoa)).toList().cast<PessoaSemContato>();
    } else{
      throw('Erro ao fazer o request: ${response.statusCode}');
    }
  }

}