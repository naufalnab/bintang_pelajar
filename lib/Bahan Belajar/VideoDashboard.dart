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

class VideoDashboard extends StatefulWidget {
  final String token, nis;
  final int kelas, jurusan;
  VideoDashboard(this.token, this.nis, this.kelas, this.jurusan);

  @override
  _VideoDashboardState createState() =>
      _VideoDashboardState(token, nis, kelas, jurusan);
}

class _VideoDashboardState extends State<VideoDashboard> {
  Map data;
  List userData;

  final String token, nis;
  final int kelas, jurusan;
  _VideoDashboardState(this.token, this.nis, this.kelas, this.jurusan);

  Future getData() async {
    var url = Constant.urlApi;
    var fullUrl =
        "https://api.bintangpelajar.com/api/siswakbm/?q=$token";
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
          String VideoName1 = "${userData[index]["bds_id1"]}";
          String VideoName2 = "${userData[index]["bds_id2"]}";
          String VideoName3 = "${userData[index]["bds_id3"]}";
          String VideoName4 = "${userData[index]["bds_id4"]}";
          String VideoName5 = "${userData[index]["bds_id5"]}";
          String VideoName6 = "${userData[index]["bds_id6"]}";
          String VideoName7 = "${userData[index]["bds_id7"]}";
          String VideoName8 = "${userData[index]["bds_id8"]}";
          String VideoName9 = "${userData[index]["bds_id9"]}";
          String VideoName10 = "${userData[index]["bds_id10"]}";
          String videoket1 = "${userData[index]["bds_ket1"]}";
          String videoket2 = "${userData[index]["bds_ket2"]}";
          String videoket3 = "${userData[index]["bds_ket3"]}";
          String videoket4 = "${userData[index]["bds_ket4"]}";
          String videoket5 = "${userData[index]["bds_ket5"]}";
          String videoket6 = "${userData[index]["bds_ket6"]}";
          String videoket7 = "${userData[index]["bds_ket7"]}";
          String videoket8 = "${userData[index]["bds_ket8"]}";
          String videoket9 = "${userData[index]["bds_ket9"]}";
          String videoket10 = "${userData[index]["bds_ket10"]}";
          return ButtonTheme(
            child: ButtonBar(
              mainAxisSize: MainAxisSize.min,
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {},
                  padding: EdgeInsets.only(left: 40, right: 40),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10)),
                  textColor: Colors.white,
                  child: Text(videoket1, style: TextStyle(fontSize: 20)),
                  color: Colors.green,
                  elevation: 7,
                ),
                RaisedButton(
                  onPressed: () {},
                  padding: EdgeInsets.only(left: 40, right: 40),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10)),
                  textColor: Colors.white,
                  color: Colors.green,
                  elevation: 7,
                  child: Text(videoket2, style: TextStyle(fontSize: 20)),
                ),
                RaisedButton(
                  onPressed: () {},
                  padding: EdgeInsets.only(left: 40, right: 40),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10)),
                  textColor: Colors.white,
                  color: Colors.green,
                  elevation: 7,
                  child: Text(videoket3, style: TextStyle(fontSize: 20)),
                ),
                RaisedButton(
                  onPressed: () {},
                  padding: EdgeInsets.only(left: 40, right: 40),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10)),
                  textColor: Colors.white,
                  color: Colors.green,
                  elevation: 7,
                  child: Text(videoket4, style: TextStyle(fontSize: 20)),
                ),
                RaisedButton(
                  onPressed: () {},
                  padding: EdgeInsets.only(left: 40, right: 40),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10)),
                  textColor: Colors.white,
                  color: Colors.green,
                  elevation: 7,
                  child: Text(videoket5, style: TextStyle(fontSize: 20)),
                ),
                RaisedButton(
                  onPressed: () {},
                  padding: EdgeInsets.only(left: 40, right: 40),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10)),
                  textColor: Colors.white,
                  color: Colors.green,
                  elevation: 7,
                  child: Text(videoket6, style: TextStyle(fontSize: 20)),
                ),
                RaisedButton(
                  onPressed: () {},
                  padding: EdgeInsets.only(left: 40, right: 40),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10)),
                  textColor: Colors.white,
                  color: Colors.green,
                  elevation: 7,
                  child: Text(videoket7, style: TextStyle(fontSize: 20)),
                ),
                RaisedButton(
                  onPressed: () {},
                  padding: EdgeInsets.only(left: 40, right: 40),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10)),
                  textColor: Colors.white,
                  color: Colors.green,
                  elevation: 7,
                  child: Text(videoket8, style: TextStyle(fontSize: 20)),
                ),
                RaisedButton(
                  onPressed: () {},
                  padding: EdgeInsets.only(left: 40, right: 40),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10)),
                  textColor: Colors.white,
                  color: Colors.green,
                  elevation: 7,
                  child: Text(videoket9, style: TextStyle(fontSize: 20)),
                ),
                RaisedButton(
                  onPressed: () {},
                  padding: EdgeInsets.only(left: 40, right: 40),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10)),
                  textColor: Colors.white,
                  color: Colors.green,
                  elevation: 7,
                  child: Text(videoket10, style: TextStyle(fontSize: 20)),
                ),

              ],
            ),
          );
        },

      ),
    );
  }
}