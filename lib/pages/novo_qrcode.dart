import 'dart:async';

import 'package:app_fidelidade/pages/hexcolor.dart';
import 'package:app_fidelidade/pages/qr_code.dart';
import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class NovoQrCode extends StatefulWidget {
  @override
  _NovoQrCodeState createState() => new _NovoQrCodeState();
}

class _NovoQrCodeState extends State<NovoQrCode> {
  String barcode = "";
  String erroBarCode = "";

  QR_Code _qrcode;

  @override
  initState() {
    super.initState();

    scan();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: new AppBar(
        //   title: new Text('QR Code Scanner'),
        // ),
        backgroundColor: HexColor('#0D47A1'),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              //   child: RaisedButton(
              //       color: Colors.blue,
              //       textColor: Colors.white,
              //       splashColor: Colors.blueGrey,
              //       onPressed: scan,
              //       child: const Text('START CAMERA SCAN')),
              // ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  barcode,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future scan() async {
    try {
      this.erroBarCode = "";
      String barcode = await BarcodeScanner.scan();
      print(barcode);

      //  _qrcode = await QR_Code((barcode) => QR_Code.fromURL(barcode));
      // _qrcode = QR_Code().getFromURL(barcode);

      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.erroBarCode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.erroBarCode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.erroBarCode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.erroBarCode = 'Unknown error: $e');
    }
  }
}
