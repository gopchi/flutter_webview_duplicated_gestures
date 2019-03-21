import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() async {

  var html = base64Encode(
    const Utf8Encoder().convert(
        await rootBundle.loadString('assets/index.html'),
  ),
  );

  runApp(MyApp(html: html));
}

class MyApp extends StatefulWidget {

  const MyApp({Key key, this.html}) : super(key: key);

  final String html;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(html: widget.html,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.html}) : super(key: key);

  final String html;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebViewController _c;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Init with html: ${widget.html}");
  }

  void _initController(WebViewController c) {
    _c = c;
  }

  void _setPosition() async {
    await _c.evaluateJavascript('setPosition(42.6809701, 23.3083007);');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('WebView Example'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: WebView(
              initialUrl: 'data:text/html;base64,${widget.html}',
              onWebViewCreated: _initController,
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
          Positioned(
            bottom: 50.0,
            right: 50.0,
            child: GestureDetector(
              onTap: _setPosition,
              behavior: HitTestBehavior.opaque,
              child: Material(
                color: Colors.white,
                elevation: 3.0,
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  alignment: Alignment.center,
                  width: 100.0,
                  height: 100.0,
                  child: Icon(
                    Icons.my_location,
                    size: 50.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
