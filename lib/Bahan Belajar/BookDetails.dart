import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'Books.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class BookDetails extends StatelessWidget {
  Books index;
  String bookName;
  String bookAuthor;
  String bookCover;
  String bookPdf;

  BookDetails(this.index,this.bookName,this.bookAuthor,this.bookCover,this.bookPdf);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
          children: <Widget>[
            Container(
              width: 250.0,
              height: 270.0,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                image: DecorationImage(
                  image: new NetworkImage(bookCover),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              left: 140.0,
              top: 70.0,
              child: Material(
                  color: Colors.white,
                  elevation: 14.0,
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Color(0x802196F3),
                  child: Container(
                    width: 230.0,
                    height: 150.0,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Container(
                            child: Center(
                                child: Text(bookName,
                                    style: TextStyle(
                                        color: Color(0xff07128a),
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: Center(
                              child: Text(bookAuthor,
                                  style: TextStyle(
                                      color: Color(0xff2da9ef),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold))),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Baca",
                                    style: TextStyle(
                                        color: Color(0xffff6f00), fontSize: 16.0)),
                                IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.angleRight,
                                      color: Color(0xffff6f00),
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PDFScreen(bookName, bookPdf)));
                                    }),
                              ],
                            )),
                      ],
                    ),
                  )
              ),
            ),
          ]
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
    return pathPDF == "" ? Scaffold(
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