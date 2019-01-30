


class PessoaSemContato {
  String nome;
  String status;
  String categoria;
  String hospital;

  PessoaSemContato(this.nome, this.categoria, this.status, this.hospital);

  PessoaSemContato.fromJson(json) {
    this.nome = json[0];
    this.status = json[1].substring(1);
    this.categoria = json[2];
    this.hospital = json.length > 3 ? json[3].substring(1) : '';
  }

}