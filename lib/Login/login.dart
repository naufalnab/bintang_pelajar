import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Home.dart';
import '../Main.dart';

class Login extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Login> {
  TextEditingController _siswaUsernameController = TextEditingController();
  TextEditingController _siswaPasswordController = TextEditingController();

  bool _isLoading = false;
  String token;
  bool _hidePass = true;

// fungsi untuk ke API server
  void signIn(String siswa_username, String siswa_password) async {
    String url = "https://api.bintangpelajar.com/login";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {
      "siswa username": siswa_username,
      "siswa password": siswa_password
    };
    var jsonResponse;
    var res = await http.post(url, body: body);
    // periksa status API
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);

      print("Respon status: ${res.statusCode}");
      print("Respon status: ${res.body}");

      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });

        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.pushReplacement(
            context, new MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } else {
      setState(() {
        _isLoading == false;
      });
      print("Respon status: ${res.body}");
      // set up the button
      Widget okButton = FlatButton(
        child: Text("${res.body}"),
        onPressed: () {},
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Error"),
        content: Text("username atau password salah"),
        actions: [
          okButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  void dispose() {
    _siswaUsernameController.dispose();
    _siswaPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 48),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          controller: _siswaUsernameController,
                          decoration:
                          InputDecoration(hintText: "Siswa Username"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          controller: _siswaPasswordController,
                          obscureText: _hidePass,
                          decoration: InputDecoration(
                              hintText: "Siswa Password",
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _passwordTampil();
                                },
                                child: Icon(
                                  _hidePass
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: _hidePass ? Colors.grey : Colors.blue,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  color: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    "Sign In",
                    style: TextStyle(fontSize: 27, color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });

                    signIn(_siswaUsernameController.text,
                        _siswaPasswordController.text);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                child: Text("Lupa Password"),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _passwordTampil() {
    setState(() {
      _hidePass = !_hidePass;
    });
  }

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    print(token);
    runApp(new MaterialApp(
      title: "LMS Bintang Pelajar",
      home: token == null ? new MyApp() : HomeScreen(),
    ));
  }

  void initState() {
    super.initState();
    getToken();
  }

  Future<void> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      token = sharedPreferences.getString('token');
    });
  }
}