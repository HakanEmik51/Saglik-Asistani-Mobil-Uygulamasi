import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NobetciEczane extends StatefulWidget {
  @override
  State<NobetciEczane> createState() => _NobetciEczaneState();
}

class _NobetciEczaneState extends State<NobetciEczane> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[100],
        title: Text('Nöbetçi Eczaneler'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: 'https://www.konyanobetcieczaneleri.com/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
