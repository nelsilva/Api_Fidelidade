import 'package:app_fidelidade/pages/venda_pontuacao.dart';
import 'package:app_fidelidade/pages/venda_empresa.dart';
import 'package:intl/intl.dart';

class Venda {
  String id;
  String cnpj_emitente;
  String cpf_destinatario;
  String nome_destinatario;
  String documento;
  String data_emissao;
  String chave;
  String qrcode;
  dynamic valor_total;
  String lancamento;
  String processado;
  dynamic nfce_serie;
  dynamic nfce_numero;
  Venda_Empresa empresa;
  Venda_Pontuacao pontuacao;

  Venda({
    this.id,
    this.cnpj_emitente,
    this.cpf_destinatario,
    this.nome_destinatario,
    this.documento,
    this.data_emissao,
    this.chave,
    this.qrcode,
    this.valor_total,
    this.lancamento,
    this.processado,
    this.nfce_serie,
    this.nfce_numero,
    this.empresa,
    this.pontuacao,
  });

  String get dataEmissao_formatada =>
      DateFormat("dd/MM/yyyy").format(DateTime.parse(this.data_emissao));

  String get valor_total__formatado =>
      NumberFormat.currency(name: 'REAL', symbol: 'R\$', decimalDigits: 2)
          .format(this.valor_total);

  factory Venda.fromJson(Map<String, dynamic> json) {
    print(json['id']);

    Map<String, dynamic> jsonPontuacao;

    try {
      var lstPontuacao = json['pontuacao'];

      if ((lstPontuacao as List).length > 0) {
        jsonPontuacao = json['pontuacao'][0];
      } else {
        jsonPontuacao = null;
      }
      //} on Exception catch (e) {
    } catch (e) {
      print(e.toString());

      // return Venda(
      //   id: "",
      //   cnpj_emitente: "",
      //   cpf_destinatario: "",
      //   nome_destinatario: "",
      //   documento: "",
      //   data_emissao: "",
      //   chave: "",
      //   qrcode: "",
      //   valor_total: "",
      //   lancamento: "",
      //   processado: "",
      //   nfce_serie: "",
      //   nfce_numero: "",
      //   empresa: Venda_Empresa(),
      //   pontuacao: Venda_Pontuacao(),
      // );
    }

    print("jsonPontuacao= " + jsonPontuacao.toString());
    return Venda(
      id: json['id'],
      cnpj_emitente: json['cnpj_emitente'],
      cpf_destinatario: json['cpf_destinatario'],
      nome_destinatario: json['nome_destinatario'],
      documento: json['documento'],
      data_emissao: json['data_emissao'],
      chave: json['chave'],
      qrcode: json['qrcode'],
      valor_total: json['valor_total'],
      lancamento: json['lancamento'],
      processado: json['processado'],
      nfce_serie: json['nfce_serie'],
      nfce_numero: json['nfce_numero'],
      empresa: Venda_Empresa.fromJson(json['empresa']),
      pontuacao: jsonPontuacao != null
          ? Venda_Pontuacao.fromJson(jsonPontuacao)
          : Venda_Pontuacao.fromJson(null),
    );
  }
}
