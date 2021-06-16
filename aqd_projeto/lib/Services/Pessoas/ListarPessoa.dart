class ListarPessoas {
  String? cpf;
  String? email;
  String? nome;
  int? seqpessoa;
  String? sobrenome;

  ListarPessoas(
      {this.cpf, this.email, this.nome, this.seqpessoa, this.sobrenome});

  ListarPessoas.fromJson(Map<dynamic, dynamic> json) {
    cpf = json['cpf'];
    email = json['email'];
    nome = json['nome'];
    seqpessoa = json['seqpessoa'];
    sobrenome = json['sobrenome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cpf'] = this.cpf;
    data['email'] = this.email;
    data['nome'] = this.nome;
    data['seqpessoa'] = this.seqpessoa;
    data['sobrenome'] = this.sobrenome;
    return data;
  }
}
