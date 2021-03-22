import 'dart:async';
import 'dart:convert';
import 'package:app_fidelidade/pages/termos_view.dart';
import 'package:flutter/foundation.dart' show Factory, kIsWeb;
import 'package:app_fidelidade/pages/CPF_Validator.dart';
import 'package:app_fidelidade/pages/global.dart';
import 'package:app_fidelidade/pages/hexcolor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart'; // add the http plugin in pubspec.yaml file.

class NovoCadastro extends StatefulWidget {
  @override
  _NovoCadastroState createState() => _NovoCadastroState();
}

class _NovoCadastroState extends State<NovoCadastro> {
  // WebViewController _controller;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  static const _url = 'http://161.35.227.175/fidelidadeapp/';
  static const _LOGIN_ACTION = 'cliente';

  final GlobalKey<FormState> _formCadKey = GlobalKey<FormState>();
  bool _isHidden = true;
  FocusScopeNode node;

  final _tNome = TextEditingController();
  final _tCPF = TextEditingController();
  final _tEmail = TextEditingController();
  final _tTelefone = TextEditingController();
  final _tSenha = TextEditingController();
  final _tSenhaRepetida = TextEditingController();

  final cTermo = "Declaro que li e concordo com os Termos de Uso";

  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    node = FocusScope.of(context);

    return Container(
      color: HexColor('#0D47A1'),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 150.0,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 25.0,
                    ),
                    child: Text(
                      "Programa de\n   Fidelidade",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Image.asset(
                    'images/logo_cutuba_menor.png',
                    scale: 0.80,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formCadKey,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        containerFields(),
                        SizedBox(
                          height: 10.0,
                        ),
                        containerButtonCadastrar(context),
                        SizedBox(
                          height: 10.0,
                        ),
                        containerButtonVoltar(context)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _validateNome(String text) {
    if (text.isEmpty) {
      return "Informe o Nome Completo";
    }
    return null;
  }

  String _validateCPF(String text) {
    if (text.isEmpty) {
      return "Informe o CPF";
    }

    if (!CPFValidator.isValid(text, true)) {
      return "CPF incorreto !";
    }

    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Informe a Senha";
    }
    return null;
  }

  void _toggle() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  containerFields() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _tNome,
            validator: _validateNome,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.characters,
            enableSuggestions: true,
            style: TextStyle(color: Colors.white),
            textInputAction: TextInputAction.next,
            onEditingComplete: () => node.nextFocus(),
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
              labelText: "Nome Completo",
              labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
              hintText: "Informe o seu Nome Completo",
              hintStyle: TextStyle(fontSize: 15.0, color: Colors.white54),
            ),
          ),
          TextFormField(
            controller: _tCPF,
            validator: _validateCPF,
            keyboardType: TextInputType.number,
            enableSuggestions: true,
            style: TextStyle(color: Colors.white),
            textInputAction: TextInputAction.next,
            onEditingComplete: () => node.nextFocus(),
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
              labelText: "CPF",
              labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
              hintText: "Informe o seu CPF",
              hintStyle: TextStyle(fontSize: 15.0, color: Colors.white54),
            ),
          ),
          TextFormField(
            controller: _tEmail,
            // validator: _validateLogin,
            keyboardType: TextInputType.emailAddress,
            enableSuggestions: true,
            style: TextStyle(color: Colors.white),
            textInputAction: TextInputAction.next,
            onEditingComplete: () => node.nextFocus(),
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
              labelText: "E-Mail",
              labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
              hintText: "Informe o seu E-Mail",
              hintStyle: TextStyle(fontSize: 15.0, color: Colors.white54),
            ),
          ),
          TextFormField(
            controller: _tTelefone,
            // validator: _validateLogin,
            keyboardType: TextInputType.number,
            enableSuggestions: true,
            style: TextStyle(color: Colors.white),
            textInputAction: TextInputAction.next,
            onEditingComplete: () => node.nextFocus(),
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
              labelText: "DDD + Telefone",
              labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
              hintText: "Informe o seu DDD + Telefone",
              hintStyle: TextStyle(fontSize: 15.0, color: Colors.white54),
            ),
          ),
          TextFormField(
            controller: _tSenha,
            validator: _validateSenha,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.white),
            textInputAction: TextInputAction.next,
            onEditingComplete: () => node.nextFocus(),
            obscureText: _isHidden,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
              labelText: "Senha",
              labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
              hintText: "Informe a Senha",
              suffix: InkWell(
                onTap: _toggle,
                child: Icon(
                  _isHidden ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          TextFormField(
            controller: _tSenhaRepetida,
            validator: _validateSenha,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.white),
            textInputAction: TextInputAction.next,
            onEditingComplete: () => node.nextFocus(),
            obscureText: _isHidden,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
              labelText: "Repetir Senha",
              labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
              hintText: "Repita a Senha",
              suffix: InkWell(
                onTap: _toggle,
                child: Icon(
                  _isHidden ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.all(0),
            value: checkboxValue,
            onChanged: (val) {
              setState(() => checkboxValue = val);
            },
            subtitle: !checkboxValue
                ? Text(
                    'Obrigatório',
                    style: TextStyle(color: Colors.yellow),
                  )
                : null,
            title: Text(
              cTermo,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.green,
          ),
          // ignore: deprecated_member_use
          // FlatButton(
          //   onPressed: _lerTermo(),
          //   child: Text(
          //     'Ler o Termo de Uso',
          //     style: TextStyle(
          //       fontSize: 16.0,
          //       color: Colors.white,
          //       decoration: TextDecoration.underline,
          //     ),
          //   ),
          // ),
          InkWell(
            onTap: _lerTermo(),
            child: Text(
              'Ler o Termo de Uso',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        //headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  _lerTermo() {
    _launchInBrowser("http://www.apisystems.com.br");

    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (BuildContext context) => TermosView(
    //           title: "Termos de Uso",
    //           selectedUrl: "http://www.apisystems.com.br",
    //         )));

    // WebView(
    //   initialUrl: 'http://www.apisystems.com.br',
    //   javascriptMode: JavascriptMode.unrestricted,
    //   onWebViewCreated: (WebViewController webViewController) {
    //     _controller.complete(webViewController);
    //   },
    // );

    // //  _controller.loadUrl('http://dartlang.org/&amp;#39;');

    // // Navigator.of(context).pushNamed('/termo');
    // // var verticalGestures = Factory<VerticalDragGestureRecognizer>(
    // //     () => VerticalDragGestureRecognizer());
    // // var gestureSet = Set.from([verticalGestures]);

    // // WebViewController _controller;
    // WebView(
    //   initialUrl: 'http://www.apisystems.com.br',
    //   //  gestureRecognizers: gestureSet,
    //   onWebViewCreated: (WebViewController webViewController) {
    //     _controller = webViewController;
    //   },
    // );
  }

  _onClickCadastrar(BuildContext context) async {
    final nome = _tNome.text;
    final cpf = _tCPF.text;
    final email = _tEmail.text;
    final tel = _tTelefone.text;
    final termo = checkboxValue;

    if (!_formCadKey.currentState.validate()) {
      return;
    }

    showLoaderDialog(context);

    bool _Ok = false;

    _Ok = await _novoCadastroOK();

    if (!_Ok) {
      Navigator.pop(context);
      return;
    }

    Navigator.pop(context);
    // Navigator.of(context).pushReplacementNamed('/home');
    Navigator.of(context).pushNamed('/home');
  }

  Future<bool> _novoCadastroOK() async {
    bool _retorno = false;
    try {
      var map = Map<String, dynamic>();

      // {
      // "grupo":1,
      // "email":"suporte@apisystems.com.br",
      // "senha":"guess"
      // }

      //  map['action'] = LoginPage._LOGIN_ACTION;
      map['fk_grupo'] = codEmpresa.toString();
      map['nome'] = _tNome.text;
      map['cpf'] = _tCPF.text;
      map['email'] = _tEmail.text;
      map['senha'] = _tSenha.text;
      map['tel'] = _tTelefone.text;
      map['termo'] = checkboxValue;

      Map<String, String> headers = {
        "auth": token,
        "Content-type": "application/json"
      };

      final response = await http.post(Uri.parse(_url + _LOGIN_ACTION),
          headers: headers, body: map);
      print('loginOK Response: ${response.body}');

      Map<String, dynamic> _resultado = await parseResponse(response.body);

      if (_resultado["status"] == true) {
        if (201 == response.statusCode) {
          if (_resultado['status'] == true) {
            // message = _resultado['message'];
            _retorno = true;
          }
        } else {
          Fluttertoast.showToast(
              msg: _resultado['message'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          // ignore: deprecated_member_use
          _retorno = false;
        }
      } else {
        Fluttertoast.showToast(
            msg: _resultado['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        _retorno = false;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "ERRO !" + e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // ignore: deprecated_member_use
      _retorno = false; // return an empty list on exception/error
    }
    return _retorno;
  }

  Future<Map<String, dynamic>> parseResponse(String responseBody) async {
    try {
      Map<String, dynamic> parsed =
          jsonDecode(responseBody); // json.decode(responseBody);
      return parsed;
    } catch (e) {
      print(e.toString());
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 7),
            child: SizedBox(
              height: 70.0,
              width: 150.0,
              child: Center(
                child: ListTile(
                  title: Text("Enviando dados !"),
                  subtitle: Text("Aguarde..."),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  containerButtonCadastrar(BuildContext context) {
    return Container(
      height: 40.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 10.0),
      child: RaisedButton(
        color: HexColor('#002171'),
        child: Text("CADASTRAR",
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
        onPressed: () {
          _onClickCadastrar(context);
        },
      ),
    );
  }

  containerButtonVoltar(BuildContext context) {
    return Container(
      height: 40.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 10.0),
      child: RaisedButton(
        color: HexColor('#002171'),
        child: Text("VOLTAR",
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
