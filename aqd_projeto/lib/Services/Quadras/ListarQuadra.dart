class ListarQuadras {
  String? comprimento;
  String? descricao;
  String? largura;
  int? seqquadra;
  String? tipo;

  ListarQuadras(
      {this.comprimento,
      this.descricao,
      this.largura,
      this.seqquadra,
      this.tipo});

  ListarQuadras.fromJson(Map<dynamic, dynamic> json) {
    comprimento = json['comprimento'];
    descricao = json['descricao'];
    largura = json['largura'];
    seqquadra = json['seqquadra'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comprimento'] = this.comprimento;
    data['descricao'] = this.descricao;
    data['largura'] = this.largura;
    data['seqquadra'] = this.seqquadra;
    data['tipo'] = this.tipo;
    return data;
  }
}
