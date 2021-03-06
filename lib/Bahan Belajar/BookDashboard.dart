import 'dart:io';

import 'package:bintang_pelajar/Bahan%20Belajar/Constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookDashboard extends StatefulWidget {
  final String token, nis;
  final int kelas, jurusan;
  BookDashboard(this.token, this.nis, this.kelas, this.jurusan);

  @override
  _BookDashboardState createState() =>
      _BookDashboardState(token, nis, kelas, jurusan);
}

class _BookDashboardState extends State<BookDashboard> {
  Map data;
  List userData;

  final String token, nis;
  final int kelas, jurusan;
  _BookDashboardState(this.token, this.nis, this.kelas, this.jurusan);

  Future getData() async {
    var url = Constant.urlApi;
    var fullUrl =
        "https://api.bintangpelajar.com/api/bidangstudimateri?q=$token&k=$kelas&j=$jurusan";
    print(fullUrl);
    http.Response response = await http.get(fullUrl);
    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bismillah"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: userData == null ? 0 : userData.length,
        itemBuilder: (BuildContext context, int index) {
          String bookName = "${userData[index]["bds_ket"]}";
          String bookPdf = Constant.urlSimteg +
              "/assets/fileuser/c0b4d1b4c4/" +
              "${userData[index]["materi_url"]}";
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      bookName,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        FontAwesomeIcons.angleRight,
                        color: Color(0xffff6f00),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PDFScreen(bookName, bookPdf)));
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PDFScreen extends StatefulWidget {
  String bookName, bookPdf;
  PDFScreen(this.bookName, this.bookPdf);

  @override
  State<StatefulWidget> createState() {
    return new _MyAppState(bookName, bookPdf);
  }
}

class _MyAppState extends State<PDFScreen> {
  String pathPDF = "";
  String bookName, bookPdf;
  _MyAppState(this.bookName, this.bookPdf);

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl(bookPdf).then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });
  }

  Future<File> createFileOfPdfUrl(filePDF) async {
    final url = filePDF;
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return pathPDF == ""
        ? Scaffold(
            appBar: AppBar(
              title: Text(bookName),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : PDFViewerScaffold(
            appBar: AppBar(
              title: Text(bookName),
            ),
            path: pathPDF,
          );
  }
}
