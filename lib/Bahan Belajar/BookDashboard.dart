import 'package:flutter/material.dart';
import 'Books.dart';
import 'CustomAppBar.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'BookDetails.dart';

class BookDashboard extends StatefulWidget {
  BookDashboard({Key key}) : super(key: key);

  _BookDashboardState createState() => _BookDashboardState();
}

class _BookDashboardState extends State<BookDashboard> {
  List<Books> bookDetails = [];
  Future<List<Books>> _bookDetails() async {
    var data = await http.get("https://naufalnabila.com/bintangpelajar/contoh.json");
    var jsonData = json.decode(data.body);
    for (var bookVal in jsonData) {
      Books books = Books(bookVal['bookname'], bookVal['bookauthor'],
          bookVal['bookcover'], bookVal['bookpdf']);
      bookDetails.add(books);
    }
    return bookDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomAppBar(),
            FutureBuilder(
              future: _bookDetails(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    color: Color(0xfffF7F7F7),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BookDetails(
                          snapshot.data[index],
                          snapshot.data[index].bookName,
                          snapshot.data[index].bookAuthor,
                          snapshot.data[index].bookCover,
                          snapshot.data[index].bookPdf
                        );
                      },
                    ),
                  );
                } else {
                  return Container(
                    child: Center(
                      child: Text("Loading"),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}