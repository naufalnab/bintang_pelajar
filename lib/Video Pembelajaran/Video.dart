import 'dart:async';
import '../Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new Video());
}

class Video extends StatefulWidget {
  @override
  _MyVideoState createState() => new _MyVideoState();
}

class _MyVideoState extends State<Video> {
  InAppWebViewController _webViewController;
  String url = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Video Pembelajaran'),
        ),
        body: Container(
            child: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.all(10.0),
              child: progress < 1.0
                  ? LinearProgressIndicator(value: progress)
                  : Container()),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: InAppWebView(
                initialUrl:
                    "https://web.microsoftstream.com/video/06f0ff0a-e60f-4671-b88a-2f706371b049",
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                  debuggingEnabled: true,
                )),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
                onLoadStart: (InAppWebViewController controller, String url) {
                  setState(() {
                    this.url = url;
                  });
                },
                onLoadStop:
                    (InAppWebViewController controller, String url) async {
                  setState(() {
                    this.url = url;
                  });
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: <Widget>[
              ButtonTheme(
                minWidth: 1,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                  ),
                  elevation: 3.0,
                  color: Colors.blue,
                  child: Icon(Icons.arrow_back, color: Colors.white,),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ])),
      ),
    );
  }
}
