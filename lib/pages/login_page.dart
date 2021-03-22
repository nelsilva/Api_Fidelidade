import 'dart:convert';
import 'package:app_fidelidade/pages/client.dart';
import 'package:app_fidelidade/pages/global.dart';
import 'package:app_fidelidade/pages/hexcolor.dart';
import 'package:app_fidelidade/pages/services.dart';
import 'package:app_fidelidade/pages/venda.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
// http://www.macoratti.net/19/10/flut_loginapi1.htm
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const _url = 'http://161.35.227.175/fidelidadeapp/';
  static const _LOGIN_ACTION = 'auth';

  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isHidden = true;

  @override
  void initState() {
    super.initState();
    if (isRelease) {
      _tLogin.text = "";
      _tSenha.text = "";
    } else {
      _tLogin.text = "suporte@apisystems.com.br";
      _tSenha.text = "guess";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Login"),
      // ),
      body: _body(context),
    );
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Informe o Login";
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

  _body(BuildContext context) {
    final node = FocusScope.of(context);
    bool _pressed = false;

    return Container(
      color: HexColor('#0D47A1'),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
                child: Image.asset(
              'images/logo_cutuba.png',
              scale: 1.5,
            )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        controller: _tLogin,
                        validator: _validateLogin,
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: true,
                        style: TextStyle(color: Colors.white),
                        // style: TextStyle(
                        //   color: Color(0XFFFFCC00),
                        //   decorationColor:
                        //       Color(0XFFFFCC00), //Font color change
                        //   backgroundColor: Color(
                        //       0XFFFFCC00), //TextFormField title background color change
                        // ),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        decoration: InputDecoration(
                            // fillColor: Colors.black.withOpacity(0.6),
                            // filled: true,
                            // border: new OutlineInputBorder(
                            //   borderRadius: const BorderRadius.all(
                            //     const Radius.circular(8.0),
                            //   ),
                            //   borderSide: new BorderSide(
                            //     color: Colors.transparent,
                            //     width: 1.0,
                            //   ),
                            // ),
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
                            labelText: "Login",
                            labelStyle:
                                TextStyle(fontSize: 25.0, color: Colors.white),
                            hintText: "Informe o Login"),
                      ),

                      //textFormFieldSenha(),
                      TextFormField(
                        controller: _tSenha,
                        validator: _validateSenha,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.white),
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => {
                          node.unfocus(),
                          // new Center(
                          //   child: SizedBox(
                          //     height: 50.0,
                          //     width: 50.0,
                          //     child: new CircularProgressIndicator(
                          //       value: null,
                          //       strokeWidth: 7.0,
                          //     ),
                          //   ),
                          // ),
                          _onClickLogin(context),
                        },
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
                          labelStyle:
                              TextStyle(fontSize: 25.0, color: Colors.white),
                          hintText: "Informe a Senha",
                          suffix: InkWell(
                            onTap: _toggle,
                            child: Icon(
                              _isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 15.0,
                      ),
                      containerButton(context)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text.rich(
                  //   TextSpan(
                  //     text: 'Ainda não tem conta? ',
                  //     style: TextStyle(
                  //       fontSize: 16.0,
                  //       color: Colors.white,
                  //     ),
                  //     children: <TextSpan>[
                  //       TextSpan(
                  //           text: 'Cadastre-se aqui !',
                  //           style: TextStyle(
                  //             decoration: TextDecoration.underline,
                  //           )),
                  //       // can add more TextSpans here...
                  //     ],
                  //   ),
                  // ),

                  Expanded(
                    child: Material(
                      color: _pressed ? Colors.white70 : Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Ainda não tem conta? ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                )),
                            InkWell(
                              onTap: _novoCadastro,
                              child: Text(
                                ' Cadastre-se aqui !',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _novoCadastro() {
    Navigator.of(context).pushNamed('/novocad');
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
                  title: Text("Verificando login !"),
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

  containerButton(BuildContext context) {
    return Container(
      height: 40.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 10.0),
      child: RaisedButton(
        color: HexColor('#002171'),
        child: Text("ENTRAR",
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
        onPressed: () {
          // new Center(
          //   child: SizedBox(
          //     height: 50.0,
          //     width: 50.0,
          //     child: new CircularProgressIndicator(
          //       value: null,
          //       strokeWidth: 7.0,
          //     ),
          //   ),
          // );

          _onClickLogin(context);
        },
      ),
    );
  }

  Future<bool> _loginOK(String _login, String _senha) async {
    bool _retorno = false;
    try {
      var map = Map<String, dynamic>();

      // {
      // "grupo":1,
      // "email":"suporte@apisystems.com.br",
      // "senha":"guess"
      // }

      //  map['action'] = LoginPage._LOGIN_ACTION;
      map['grupo'] = codEmpresa.toString();
      map['email'] = _login;
      map['senha'] = _senha;

      token = '';

      final response =
          await http.post(Uri.parse(_url + _LOGIN_ACTION), body: map);
      print('loginOK Response: ${response.body}');

      Map<String, dynamic> _resultado = await parseResponseLogin(response.body);

      if (_resultado["status"] == true) {
        cliente = Client.fromJson(_resultado['cliente']);

        //     HTTP/1.1 200 OK
        // {
        //   "status": true,
        //   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNTk4NjMzODI0LCJleHAiOjE1OTg2NjI2MjR9.c0UGpDC_FMr7X07sA2awN-HBVUMjxHe-dLIJaVF4PWk"
        // }
        if (200 == response.statusCode) {
          if (_resultado['status'] == true) {
            token = _resultado['token'];
            _retorno = true;
          }
        } else {
          //HTTP/1.1 404 Not Acceptable
          // {
          //   "status": false,
          //   "message": "Faltando parametro"
          // }
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

  // {"status":true,"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF9jbGllbnRlIjoiMSIsImlhdCI6MTYxNTg0MDQ2NywiZXhwIjoxNjE1ODY5MjY3fQ.-VzZ5Kzj3TgUmU5EkmJiDebjZ5Zhb-FRmqjf6r004Vg","cliente":{"grupo":1,"id":"1","nome":"Eric","cpf":"111","email":"suporte@apisystems.com.br","telefone":null,"ativo":"S"}}

  Future<Map<String, dynamic>> parseResponseLogin(String responseBody) async {
    try {
      Map<String, dynamic> parsed =
          jsonDecode(responseBody); // json.decode(responseBody);
      return parsed;
    } catch (e) {
      print(e.toString());
    }
  }

  _onClickLogin(BuildContext context) async {
    final login = _tLogin.text;
    final senha = _tSenha.text;
    print("Login: $login , Senha: $senha ");
    if (!_formKey.currentState.validate()) {
      return;
    }

    showLoaderDialog(context);

    bool _Ok = await _loginOK(login, senha);

    if (!_Ok) {
      Navigator.pop(context);
      return;
    }

    Navigator.pop(context);
    // Navigator.of(context).pushReplacementNamed('/home');
    Navigator.of(context).pushNamed('/home');

    // if(login.isEmpty || senha.isEmpty) {
    //   showDialog(context: context,
    //     builder: (context){
    //       return AlertDialog(
    //         title:Text("Erro"),
    //         content: Text("Login e/ou Senha inválido(s)"),
    //         actions : <Widget>[
    //             FlatButton(
    //                child: Text("OK"),
    //                   onPressed: () {
    //                     Navigator.pop(context);
    //             }
    //            )
    //         ]
    //        );
    //   },
    //   );
    // }
  }
}
