import 'package:bintang_pelajar/Login/login.dart';

import 'package:flutter/material.dart';

import 'Bahan Belajar/Constant.dart';

void main() {
  runApp(MyApp(),);
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LMS Bintang Pelajar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}