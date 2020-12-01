import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Bahan Belajar/Constant.dart';
import '../Home.dart';
import '../Main.dart';

//test untuk push

class Login extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Login> {
  Map data;
  var userData, token, nis, kelas, jurusan;
  var cobaToken;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  TextEditingController _siswaUsernameController = TextEditingController();
  TextEditingController _siswaPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _hidePass = true;

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
                    _loadToken();
                    print("HEH: $cobaToken");
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

  _saveData(String kirimToken, kirimNis, kirimKelas, kirimJurusan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', kirimToken);
    prefs.setString('nis', kirimNis);
    prefs.setString('kelas', kirimKelas);
    prefs.setString('jurusan', kirimJurusan);
  }

  _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cobaToken = (prefs.getString('token'));
    });
    return cobaToken;
  }

  void _passwordTampil() {
    setState(() {
      _hidePass = !_hidePass;
    });
  }

  // fungsi untuk ke API server
  void signIn(String siswa_username, String siswa_password) async {
    Map body = {
      "siswa username": siswa_username,
      "siswa password": siswa_password,
    };
    var jsonResponse;
    var res = await http.post(Constant.urlApi + "/login", body: body);
    // periksa status API
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      List list = jsonResponse["data"];
      token = list[0]['token'];
      print("userData: $token");
      print("Respon status: ${res.statusCode}");
      print("Respon body: ${res.body}");

      _saveData(token, nis, kelas, jurusan);
      _loadToken();

      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (context) => HomeScreen(token, nis, kelas,
                    jurusan))); // Lanjutin disini yaaaaa@!@@@@@!!!
      }
    } else {
      setState(() {
        _isLoading == false;
      });
      print("Respon status: ${res.body}");
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Error"),
        content: Text("username atau password salah"),
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
}
