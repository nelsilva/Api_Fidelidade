import 'dart:convert';
import 'package:app_fidelidade/pages/global.dart';
import 'package:app_fidelidade/pages/venda_empresa.dart';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'package:http/http.dart';
import 'venda.dart';
import 'venda_item.dart';

class Services {
  static const URL_SERVICO = 'http://161.35.227.175/fidelidadeapp/';
  static const _LISTA_VENDAS_ACTION = 'cliente/listar';
  static const _LISTA_VENDAS_COMPLET_ACTION =
      'http://161.35.227.175/fidelidadeapp/cliente/listar';

  // ignore: non_constant_identifier_names
  // var map = Map<String, dynamic>();

  Future<List<Venda>> getVendas(String _cod, String _token) async {
    //List<Venda> list;
    try {
      Uri uri = Uri.parse(_LISTA_VENDAS_COMPLET_ACTION);

      // venda_body['where'][0]["cpf"] = _cod;
      // Map venda_body = jsonDecode(jsonEncode({
      //   "where": [
      //     {"cpf": _cod}
      //   ],
      //   "join": [
      //     {
      //       "table": "venda",
      //       "join": [
      //         {"table": "empresa"},
      //         {"table": "venda_itens"},
      //         {"table": "pontuacao"}
      //       ]
      //     }
      //   ]
      // }));
      var venda_body = jsonEncode({
        "where": [
          {"cpf": _cod}
        ],
        "join": [
          {
            "table": "venda",
            "order": [
              ["data_emissao", "DESC"]
            ],
            "limit": intQuantMaxVendas,
            "join": [
              {"table": "empresa"},
              // {"table": "venda_itens"},
              {"table": "pontuacao"}
            ]
          }
        ]
      });

      Map<String, String> headers = {
        "auth": _token,
        "Content-type": "application/json"
      };

      // http
      //     .post(uri, headers: headers, body: venda_body)
      //     .then((http.Response response) async {
      //   print('getVendas Response: ${response.body}');
      //   if (201 == response.statusCode) {
      //     List<Venda> list = await parseResponse(response.body);
      //     return list;
      //   } else {
      //     // ignore: deprecated_member_use
      //     return List<Venda>(0);
      //   }
      // });

      var response = await http.post(uri, headers: headers, body: venda_body);
      print('getVendas Response: ${response.body}');
      if (201 == response.statusCode) {
        List<Venda> list = await parseResponse(response.body);

        return list;
      } else {
        // ignore: deprecated_member_use
        return List<Venda>(0);
      }

      // return http
      //     .post(uri, body: venda_body, headers: headers)
      //     .then((http.Response response) async {
      //   final int statusCode = response.statusCode;

      //   if (statusCode < 201 || statusCode > 400 || json == null) {
      //     return []; // List<Venda>(0);
      //   }
      //   List<Venda> list = await parseResponse(response.body);
      //   return list;
      // });

      // await http
      //     .post(uri, headers: headers, body: venda_body)
      //     .then((resultado) async {
      //   print('getVendas Response: ${resultado.body}');
      //   if (201 == resultado.statusCode) {
      //     list = await parseResponse(resultado.body);
      //     // return list;
      //   }
      //   // } else {
      //   //   // ignore: deprecated_member_use
      //   //   return list;
      // });
    } catch (e) {
      // ignore: deprecated_member_use
      //return list; //List<Venda>(); // return an empty list on exception/error
      print(e.toString());
    }
    return List<Venda>(0);
  }

  // QR_Code serializaQRCode() {}

  static Future<List<Venda>> parseResponse(String responseBody) async {
    final parsed =
        json.decode(responseBody)['data'].cast<Map<String, dynamic>>();

    var parsedVenda;

    try {
      parsedVenda = await parsed[0]['venda']
          .map<Venda>((json) => Venda.fromJson(json))
          .toList();
    } catch (e) {
      print(e.toString());
    }

    return parsedVenda;
  }

  static Future<Venda_Empresa> parseVendaEmpresa(String responseBody) async {
    final parsed =
        json.decode(responseBody)['empresa'].cast<Map<String, dynamic>>();

    final parsedVendaEmpresa =
        await parsed.map<Venda_Empresa>((json) => Venda_Empresa.fromJson(json));

    return parsedVendaEmpresa;
  }
}
