import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermosView extends StatefulWidget {
  String title;
  String selectedUrl = 'http://www.apisystems.com.br';

  TermosView({
    @required this.title,
    @required this.selectedUrl,
  });

  @override
  _TermosViewState createState() => _TermosViewState();
}

class _TermosViewState extends State<TermosView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: WebView(
          initialUrl: widget.selectedUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onPageFinished: (String url) {
            if (url == widget.selectedUrl) {
              //_redirectToStripe(widget.sessionId);
            }
          },
          navigationDelegate: (NavigationRequest request) {
            print(request);
            print(request.url);
            if (request.url.startsWith('http://localhost:5000/success.html')) {
              Navigator.of(context).pop();
              //Navigator.of(context).pushReplacementNamed('/success');
            } else if (request.url.startsWith('http://mykinderpass/cancel')) {
              Navigator.of(context).pop();
              //Navigator.of(context).pushReplacementNamed('/cancel');
            }
            return NavigationDecision.navigate;
          },
        ));
  }
}
