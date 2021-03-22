import 'package:app_fidelidade/pages/venda_empresa.dart';
import 'package:intl/intl.dart';

class Venda_Pontuacao {
  String id;
  dynamic fk_campanha;
  dynamic fk_venda;
  dynamic nfce_serie;
  dynamic nfce_numero;
  String cnpj_emitente;
  String cpf_destinatario;
  String nome_destinatario;
  dynamic valor_venda;
  dynamic fracao;
  dynamic valor;
  String tipo;
  String lancamento;
  String documento_pdv;
  String pontuacao_tipo = 'C';

  Venda_Pontuacao({
    this.id,
    this.fk_campanha,
    this.fk_venda,
    this.nfce_serie,
    this.nfce_numero,
    this.cnpj_emitente,
    this.cpf_destinatario,
    this.nome_destinatario,
    this.valor_venda,
    this.fracao,
    this.valor,
    this.tipo,
    this.lancamento,
    this.documento_pdv,
    this.pontuacao_tipo,
  });

  String get lancamento_formatado =>
      DateFormat("dd/MM/yyyy").format(DateTime.parse(this.lancamento));

  String get valor_venda__formatado =>
      NumberFormat.currency(name: 'REAL', symbol: 'R\$', decimalDigits: 2)
          .format(this.valor_venda);

  String get valor_formatado => this.pontuacao_tipo == 'V'
      ? NumberFormat.currency(name: 'REAL', symbol: 'R\$ ', decimalDigits: 2)
          .format(this.valor)
      : NumberFormat.currency(name: 'PONTOS', decimalDigits: 0)
          .format(this.valor);

  String formataValor() {
    String _valor;
    if (this.pontuacao_tipo == null) {
      _valor = "";
    } else if (this.pontuacao_tipo == 'V') {
      _valor =
          NumberFormat.currency(name: 'REAL', symbol: 'R\$ ', decimalDigits: 2)
              .format(this.valor);
    } else {
      _valor = NumberFormat.currency(name: 'PONTOS', decimalDigits: 0)
          .format(this.valor);
    }
    return _valor;
  }

  factory Venda_Pontuacao.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      print(json['id']);

      return Venda_Pontuacao(
        id: json['id'],
        fk_campanha: json['fk_campanha'],
        fk_venda: json['fk_venda'],
        nfce_serie: json['nfce_serie'],
        nfce_numero: json['nfce_numero'],
        cnpj_emitente: json['cnpj_emitente'],
        cpf_destinatario: json['cpf_destinatario'],
        nome_destinatario: json['nome_destinatario'],
        valor_venda: json['valor_venda'],
        fracao: json['fracao'],
        valor: json['valor'],
        tipo: json['tipo'],
        lancamento: json['lancamento'],
        documento_pdv: json['documento_pdv'],
        pontuacao_tipo: json['pontuacao_tipo'],
      );
    } else {
      return Venda_Pontuacao();
      //   id: "",
      //   fk_campanha: "",
      //   fk_venda: "",
      //   nfce_serie: "",
      //   nfce_numero: "",
      //   cnpj_emitente: "",
      //   cpf_destinatario: "",
      //   nome_destinatario: "",
      //   valor_venda: "",
      //   fracao: "",
      //   valor: "",
      //   tipo: "",
      //   lancamento: "",
      //   documento_pdv: "",
      //   pontuacao_tipo: "",
      // );
    }
  }
}
