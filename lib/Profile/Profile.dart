import 'Constant/Constant.dart';

import 'Screens/ProfilePage.dart';
import 'package:flutter/material.dart';

main() {
  runApp(new MaterialApp(
    title: 'Bintang Pelajar',
    debugShowCheckedModeBanner: false,
    theme: new ThemeData(
        primaryColor: Color(0xff0082CD),

        primaryColorDark: Color(0xff0082CD)),
    routes: <String, WidgetBuilder>{
      //SPLASH_SCREEN: (BuildContext context) => new MapScreen(),
      PROFILE: (BuildContext context) => new ProfilePage(),
    },
  ));
}