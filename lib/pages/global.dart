import 'package:app_fidelidade/pages/client.dart';
import 'package:app_fidelidade/pages/venda.dart';
import 'package:app_fidelidade/pages/venda_item.dart';
import 'package:flutter/foundation.dart';

bool isRelease = kReleaseMode;

final intQuantMaxVendas = 100;
final codEmpresa = 1;
final empresa = 'CUTUBA Auto Posto';
final empresaemail = 'cutuba@email.com.br';
String token = '';

String apptitle = 'Programa de Fidelidade';

Client cliente;

Venda venda;

Venda_Item vendas_itens;
