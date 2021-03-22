import 'package:app_fidelidade/pages/services.dart';
import 'package:app_fidelidade/pages/client.dart';
import 'package:app_fidelidade/pages/global.dart';
import 'package:app_fidelidade/pages/hexcolor.dart';
import 'package:app_fidelidade/pages/venda.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:avatar_view/avatar_view.dart';

// http://www.macoratti.net/19/10/flut_drawer1.htm

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Venda> _lista_original;
  List<Venda> _historico;
  List<Venda> _compras;
  List<Venda> _usos;

  int _selectedIndex = 0;
  bool isLandscape;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final imageUri = Uri.parse('http://www.nelconsult.eti.br/images/logo.gif');

  @override
  void initState() {
    super.initState();

    _getVendas();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<bool> _getVendas() async {
    // _showProgress('Carregando Clientes...');
    // showLoaderDialog(context);
    // ignore: non_constant_identifier_names
    await Services().getVendas(cliente.Cpf, token).then((vendas) {
      setState(() {
        print("Length ${vendas.length}");
        // ignore: deprecated_member_use
        _lista_original = vendas;
        _historico = filtraHistorico() as List<Venda>; //.cast<Venda>();
        _compras = filtraVendas();
        _usos = filtraUsos();
      });
      //  _showProgress(widget.title); // Reset the title...
      //  Navigator.pop(context);
    });
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    // Retorna true se estiver com orientação landscape
    isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 150.0,
          // automaticallyImplyLeading: false, // hides leading widget
          flexibleSpace: Container(
            color: HexColor('#0D47A1'),
            //height: 150.0,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 30.00,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    child: Container(
                      height: 20.0,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Saldo Total',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    child: Container(
                      //height: 40.0,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "R" + "\$" + " 8,10",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 25.0,
                  // ),
                  Container(
                    // height: 15.0,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Esse é o seu saldo para usar em nossas conveniências',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.add),
            //   onPressed: () {
            //     _createTable();
            //   },
            // ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                // showLoaderDialog(context);
                _getVendas();
                // Navigator.pop(context);
              },
            )
          ],
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                isScrollable: true,
                labelColor: Colors.black87,
                indicatorColor: Colors.black87,
                // unselectedLabelColor: Colors.white,
                tabs: <Widget>[
                  Tab(text: "Histórico"),
                  Tab(text: "Suas Compras"),
                  Tab(text: "Seus Usos"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    tabHistorico(),
                    tabSuasCompras(),
                    tabSeusUsos(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: HexColor('#0D47A1'),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white60,
          onTap: _onItemTapped,
        ),
        floatingActionButton: FloatingActionButton(
          //Botão +
          onPressed: () {
            _addQRCode();
          },
          child: Image.asset('images/icons8-qr-code-48.png'), //Icon(Icons.add),
        ),
      ),
    );
  }

  _addQRCode() {
    Navigator.of(context).pushNamed("/novoqrcode");
  }

  Image _pegaImagem(var tipo) {
    Image img;
    if (tipo == null) {
      img = Image.asset('images/nao_processado.png');
    } else if (tipo == 'C') {
      img = Image.asset('images/dinheiro.png');
    } else if (tipo == 'D') {
      img = Image.asset('images/carrinho.png');
    }
    return img;
  }

  tabHistorico() {
    if (_historico == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
        //  Center(
        // child: Text("NENHUM REGISTRO ENCONTRADO !"),
        // ),
      );
    } else if (_historico.length > 0) {
      return Container(
        child: RefreshIndicator(
          onRefresh: () {
            if (_lista_original == null) {
              // ignore: unrelated_type_equality_checks
              _getVendas();
            } else {
              filtraHistorico();
            }
            //  return Future.value(filtraVendas());
            return Future.value((_historico != null));
          },
          child: Expanded(
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _historico != null ? _historico.length : 0,
              itemBuilder: (BuildContext context, int index) {
                if (_historico.length != 0) {
                  return Container(
                    height: 125.0,
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 3.0,
                          color: Colors.cyan,
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Row(
                              children: [
                                Container(
                                  child: _pegaImagem(
                                      _historico[index].pontuacao.tipo),
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Container(
                                  width: 100.0,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Data',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            )),
                                        Text(
                                          _historico[index]
                                              .dataEmissao_formatada,
                                          style: TextStyle(
                                            fontSize: 17.0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text('Valor',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            )),
                                        Text(
                                          _historico[index]
                                              .valor_total__formatado,
                                          style: TextStyle(
                                            fontSize: 17.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Local da Compra',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          )),
                                      Text(
                                        _historico[index].empresa.nome,
                                        style: TextStyle(
                                          fontSize: 17.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text('Cashback',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          )),
                                      Text(
                                        _historico[index]
                                            .pontuacao
                                            .formataValor(),
                                        style: TextStyle(
                                          fontSize: 17.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Icon(Icons.arrow_forward_ios_outlined,
                                      size: 45.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        //Client _detCli =
                        //    await _detailClient(_clients[index].CodClient);
                        //if (_detCli != null) {
                        //  Navigator.of(context).pushNamed('/detalhe',
                        //      arguments: _detCli); //_clients[index]);
                        //}
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container();
              },
            ),
          ),
        ),
      );
    } else {
      return Container(
        child:
            //CircularProgressIndicator(),
            Center(
          child: Text("NENHUM REGISTRO ENCONTRADO !"),
        ),
      );
    }
  }

  List<Venda> filtraVendas() {
    // return List.from(
    //     _lista_original.where((element) => element.pontuacao.tipo == 'C'));
    List<Venda> lst;
    lst = List<Venda>();
    lst.clear();
    _lista_original.forEach((element) {
      if (element.pontuacao.tipo == 'C') {
        // if (element != null) {
        lst.add(element);
        // }
      }
    });

    return lst;
  }

  List<Venda> filtraUsos() {
    // return List.from(
    //     _lista_original.where((element) => element.pontuacao.tipo == 'D'));

    List<Venda> lst;
    lst = List<Venda>();
    lst.clear();
    _lista_original.forEach((element) {
      if (element.pontuacao.tipo == 'D') {
        // if (element != null) {
        lst.add(element);
        // }
      }
    });

    return lst;
  }

  List<Venda> filtraHistorico() {
    List<Venda> lst;

    // lst = List.from(_lista_original.where((element) =>
    //     (element.pontuacao.tipo == 'C' || element.pontuacao.tipo == 'D')));
    //
    // lst = _lista_original
    //     .where((element) =>
    //         (element.pontuacao.tipo == 'C' || element.pontuacao.tipo == 'D'))
    //     .toList();
    //

    // Iterable _it = _lista_original.where((element) =>
    //     (element.pontuacao.tipo == 'C' || element.pontuacao.tipo == 'D'));

    // lst = _it.toList(growable: true);
    lst = List<Venda>();
    lst.clear();
    _lista_original.forEach((element) {
      if (element.pontuacao.tipo == null ||
          element.pontuacao.tipo == 'C' ||
          element.pontuacao.tipo == 'D') {
        // if (element != null) {
        lst.add(element);
        // }
      }
    });

    return lst;
  }

  tabSuasCompras() {
    if (_compras == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
        //     Center(
        //   child: Text("NENHUM REGISTRO ENCONTRADO !"),
        // ),
      );
    } else if (_compras.length > 0) {
      return Container(
        child: RefreshIndicator(
          onRefresh: () {
            if (_lista_original == null) {
              // ignore: unrelated_type_equality_checks
              _getVendas();
            } else {
              filtraVendas();
            }
            //  return Future.value(filtraVendas());
            return Future.value((_compras != null));
          },
          child: Expanded(
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _compras != null ? _compras.length : 0,
              itemBuilder: (BuildContext context, int index) {
                if (_compras.length != 0) {
                  return Container(
                    height: 125.0,
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 3.0,
                          color: Colors.cyan,
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Row(
                              children: [
                                Container(
                                  child: _pegaImagem(
                                      _compras[index].pontuacao.tipo),
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Container(
                                  width: 100.0,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Data',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            )),
                                        Text(
                                          _compras[index].dataEmissao_formatada,
                                          style: TextStyle(
                                            fontSize: 17.0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text('Valor',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            )),
                                        Text(
                                          _compras[index]
                                              .valor_total__formatado,
                                          style: TextStyle(
                                            fontSize: 17.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Local da Compra',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          )),
                                      Text(
                                        _compras[index].empresa.nome,
                                        style: TextStyle(
                                          fontSize: 17.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text('Cashback',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          )),
                                      Text(
                                        _compras[index]
                                            .pontuacao
                                            .formataValor(),
                                        style: TextStyle(
                                          fontSize: 17.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Icon(Icons.arrow_forward_ios_outlined,
                                      size: 45.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        //Client _detCli =
                        //    await _detailClient(_clients[index].CodClient);
                        //if (_detCli != null) {
                        //  Navigator.of(context).pushNamed('/detalhe',
                        //      arguments: _detCli); //_clients[index]);
                        //}
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container();
              },
            ),
          ),
        ),
      );
    } else {
      return Container(
        child:
            //CircularProgressIndicator(),
            Center(
          child: Text("NENHUM REGISTRO ENCONTRADO !"),
        ),
      );
    }
  }

  tabSeusUsos() {
    if (_usos == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
        //     Center(
        //   child: Text("NENHUM REGISTRO ENCONTRADO !"),
        // ),
      );
    } else if (_usos.length > 0) {
      return Container(
        child: RefreshIndicator(
          onRefresh: () {
            if (_lista_original == null) {
              // ignore: unrelated_type_equality_checks
              _getVendas();
            } else {
              filtraUsos();
            }
            //  return Future.value(filtraUsos());
            return Future.value((_usos != null));
          },
          child: Expanded(
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _usos != null ? _usos.length : 0,
              itemBuilder: (BuildContext context, int index) {
                if (_usos.length != 0) {
                  return Container(
                    height: 125.0,
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 3.0,
                          color: Colors.cyan,
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Row(
                              children: [
                                Container(
                                  child:
                                      _pegaImagem(_usos[index].pontuacao.tipo),
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Container(
                                  width: 100.0,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Data',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            )),
                                        Text(
                                          _usos[index].dataEmissao_formatada,
                                          style: TextStyle(
                                            fontSize: 17.0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text('Valor',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            )),
                                        Text(
                                          _usos[index].valor_total__formatado,
                                          style: TextStyle(
                                            fontSize: 17.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Local de Consumo',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          )),
                                      Text(
                                        _usos[index].empresa.nome,
                                        style: TextStyle(
                                          fontSize: 17.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text('Cashback',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          )),
                                      Text(
                                        _usos[index].pontuacao.formataValor(),
                                        style: TextStyle(
                                          fontSize: 17.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Icon(Icons.arrow_forward_ios_outlined,
                                      size: 45.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        //Client _detCli =
                        //    await _detailClient(_clients[index].CodClient);
                        //if (_detCli != null) {
                        //  Navigator.of(context).pushNamed('/detalhe',
                        //      arguments: _detCli); //_clients[index]);
                        //}
                      },
                    ),
                  );
                }
                // } else {
                //   return Container(
                //     child:
                //         //CircularProgressIndicator(),
                //         Center(
                //       child: Text("NENHUM REGISTRO ENCONTRADO !"),
                //     ),
                //   );
                // }
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container();
              },
            ),
          ),
        ),
      );
    } else {
      return Container(
        child:
            //CircularProgressIndicator(),
            Center(
          child: Text("NENHUM REGISTRO ENCONTRADO !"),
        ),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _onClickClientes(BuildContext context) {
    //Navigator.of(context).pushNamed('/clientes');
  }
}
