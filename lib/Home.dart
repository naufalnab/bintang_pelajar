import 'Bahan Belajar//BookDashboard.dart';
import 'Jadwal%20Belajar/Jadwal.dart';
import 'Login/login.dart';
import 'Profile/Screens/ProfilePage.dart';
import 'Video%20Pembelajaran/Video.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    // to get size
    var size = MediaQuery.of(context).size;

    // style
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .3,
            decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage('assets/images/top_header.png')),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 64,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(
                              'https://media-exp1.licdn.com/dms/image/C510BAQGEeeql8qucVg/company-logo_200_200/0?e=2159024400&v=beta&t=7yQGHdnFgYg_UqJNJBeW4xKQRUTGDkLEJVnnxJHnlQ0'),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Text(
                            //   'Naufal Nabila',
                            //   style: TextStyle(
                            //       fontFamily: "Montserrat Medium",
                            //       color: Colors.white,
                            //       fontSize: 13),
                            // ),
                            ButtonTheme(
                              minWidth: 15.0,
                              height: 15.0,
                              child: RaisedButton(
                              onPressed: () async {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.remove('token');
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              },
                              child: Text(
                                "Logout", style: TextStyle(fontSize: 10, color: Colors.white),
                              ),
                            ),
                            )
                            
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      primary: false,
                      crossAxisCount: 2,
                      children: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.network(
                                'https://www.flaticon.com/svg/static/icons/svg/3135/3135715.svg',
                                height: 75,
                              ),
                              Text(
                                  "Profile",
                              ),
                            ],
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.network(
                                'https://www.flaticon.com/svg/static/icons/svg/3652/3652191.svg',
                                height: 75,
                              ),
                              Text(
                                  "Jadwal Belajar",
                                ),
                            ],
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.network(
                                'https://www.flaticon.com/svg/static/icons/svg/3048/3048425.svg',
                                height: 75,
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BookDashboard()),
                                  );
                                },
                                child: Text(
                                  "Bahan Belajar",
                                ),
                              )
                            ],
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.network(
                                'https://www.flaticon.com/svg/static/icons/svg/327/327010.svg',
                                height: 75,
                              ),
                              Text(
                                'Ujian Online',
                                style: cardTextStyle,
                              )
                            ],
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.network(
                                'https://www.flaticon.com/svg/static/icons/svg/3576/3576313.svg',
                                height: 75,
                              ),
                              Text(
                                'Psikotes Online',
                                style: cardTextStyle,
                              )
                            ],
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.network(
                                'https://www.flaticon.com/svg/static/icons/svg/889/889061.svg',
                                height: 75,
                              ),
                              Text(
                                'Konsultasi Online',
                                style: cardTextStyle,
                              )
                            ],
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.network(
                                'https://www.flaticon.com/svg/static/icons/svg/3003/3003180.svg',
                                height: 75,
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Video()),
                                  );
                                },
                                child: Text(
                                  "Video Pembelajaran",
                                ),
                              )
                            ],
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.network(
                                'https://www.flaticon.com/svg/static/icons/svg/3380/3380975.svg',
                                height: 75,
                              ),
                              Text(
                                'Prediksi PTN 2020',
                                style: cardTextStyle,
                              )
                            ],
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.network(
                                'https://www.flaticon.com/svg/static/icons/svg/564/564576.svg',
                                height: 75,
                              ),
                              Text(
                                'Simulasi PTN',
                                style: cardTextStyle,
                              )
                            ],
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.network(
                                'https://www.flaticon.com/svg/static/icons/svg/3750/3750027.svg',
                                height: 75,
                              ),
                              Text(
                                'Info Perkembangan',
                                style: cardTextStyle,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
