class Venda_Empresa {
  String id;
  dynamic fk_grupo;
  String nome;
  String cnpj;
  String ativa;

  Venda_Empresa({
    this.id,
    this.fk_grupo,
    this.nome,
    this.cnpj,
    this.ativa,
  });

  factory Venda_Empresa.fromJson(Map<String, dynamic> json) {
    print(json['id']);

    return Venda_Empresa(
      id: json['id'],
      fk_grupo: json['fk_grupo'],
      nome: json['nome'],
      cnpj: json['cnpj'],
      ativa: json['ativa'],
    );
  }
}
