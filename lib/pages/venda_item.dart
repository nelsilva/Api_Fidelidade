class Venda_Item {
  String id;
  String fk_venda;
  String cnpj_emitente;
  String codigo_produto;
  String produto;
  String unidade;
  String desconto;
  String quantidade;
  String preco_unitario;
  String subtotal;
  String anp;
  String ncm;
  String identificador;
  String gtin;

  Venda_Item({
    this.id,
    this.fk_venda,
    this.cnpj_emitente,
    this.codigo_produto,
    this.produto,
    this.unidade,
    this.desconto,
    this.quantidade,
    this.preco_unitario,
    this.subtotal,
    this.anp,
    this.ncm,
    this.identificador,
    this.gtin,
  });

  factory Venda_Item.fromJson(Map<String, dynamic> json) {
    print(json['id']);

    return Venda_Item(
      id: json['id'],
      cnpj_emitente: json['cnpj_emitente'],
      codigo_produto: json['codigo_produto'],
      produto: json['produto'],
      unidade: json['unidade'],
      desconto: json['desconto'],
      quantidade: json['quantidade'],
      preco_unitario: json['preco_unitario'],
      subtotal: json['subtotal'],
      anp: json['anp'],
      ncm: json['ncm'],
      identificador: json['identificador'],
      gtin: json['gtin'],
    );
  }
}
