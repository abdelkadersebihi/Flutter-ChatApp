import 'package:chat_pfe/Logs/Login.dart';
import 'package:chat_pfe/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String _uemail,
      _upassword,
      _uname,
      _ulastname,
      _uimg =
          "https://firebasestorage.googleapis.com/v0/b/firestore-74deb.appspot.com/o/profile.png?alt=media&token=a6c0682f-72ad-4a56-b9c7-7d5488f00c1c",
      _ubio = "bio";
  bool _obs = true;
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/bg4.jpeg",
                  ),
                  fit: BoxFit.cover)),
          child: ListView(
            children: <Widget>[
              Container(
                margin:
                    EdgeInsets.only(top: 18, left: 35, right: 35, bottom: 20),
                child: Card(
                  elevation: 6,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 15, left: 22, bottom: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              fontSize: 50,
                              fontFamily: 'poiret',
                              color: Color.fromRGBO(150, 150, 150, 1)),
                        ),
                      ),
                      Container(
                        child: Form(
                          key: key,
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 15, right: 15),
                                child: TextFormField(
                                  cursorWidth: 1,
                                  cursorColor: Colors.black,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'product'),
                                  decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      contentPadding: EdgeInsets.all(
                                          10), //--------------------------------------------
                                      suffixIcon: Icon(Icons
                                          .account_circle), //----------------------------------------
                                      hintText: 'First Name',
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'product'),
                                      errorStyle:
                                          TextStyle(color: Colors.redAccent),
                                      fillColor:
                                          Color.fromRGBO(240, 240, 250, 1),
                                      errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.redAccent),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(30),
                                      )),
                                  onSaved: (input) {
                                    _uname = input;
                                  },
                                  validator: (input) {
                                    if (input.isEmpty) return 'provide a name!';
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 4),
                                child: TextFormField(
                                  cursorWidth: 1,
                                  cursorColor: Colors.black,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'product'),
                                  decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      contentPadding: EdgeInsets.all(
                                          10), //--------------------------------------------
                                      suffixIcon: Icon(Icons
                                          .account_circle), //----------------------------------------
                                      hintText: 'Last name',
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'product'),
                                      errorStyle:
                                          TextStyle(color: Colors.redAccent),
                                      fillColor:
                                          Color.fromRGBO(240, 240, 250, 1),
                                      errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.redAccent),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(30),
                                      )),
                                  onSaved: (input) {
                                    _ulastname = input;
                                  },
                                  validator: (input) {
                                    if (input.isEmpty)
                                      return 'provide an lastname!';
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 4),
                                child: TextFormField(
                                  cursorWidth: 1,
                                  cursorColor: Colors.black,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'product'),
                                  decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      contentPadding: EdgeInsets.all(
                                          10), //--------------------------------------------
                                      suffixIcon: Icon(Icons
                                          .account_circle), //----------------------------------------
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'product'),
                                      errorStyle:
                                          TextStyle(color: Colors.redAccent),
                                      fillColor:
                                          Color.fromRGBO(240, 240, 250, 1),
                                      errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.redAccent),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(30),
                                      )),
                                  onSaved: (input) {
                                    _uemail = input;
                                  },
                                  validator: (input) {
                                    if (input.isEmpty)
                                      return 'provide an email!';
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 4),
                                child: TextFormField(
                                  cursorWidth: 1,
                                  cursorColor: Colors.black,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'product'),
                                  obscureText:
                                      _obs, //--------------------------------------------
                                  decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      contentPadding: EdgeInsets.all(
                                          10), //--------------------------------------------
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _obs = !_obs;
                                          });
                                        },
                                        child: Icon(Icons.remove_red_eye),
                                      ), //----------------------------------------
                                      // prefixIcon: Icon(Icons.vpn_key), //----------------------------------------
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'product'),
                                      errorStyle:
                                          TextStyle(color: Colors.redAccent),
                                      fillColor:
                                          Color.fromRGBO(240, 240, 250, 1),
                                      errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.redAccent),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(30),
                                      )),

                                  onSaved: (input) {
                                    _upassword = input;
                                  },

                                  validator: (input) {
                                    if (input.length < 6)
                                      return 'provide 6 characters!';
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 8, bottom: 20, left: 8, right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: <Color>[
                                Color.fromRGBO(76, 184, 196, 1),
                                Color.fromRGBO(60, 211, 173, 1)
                              ]),
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: validate,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                                padding: EdgeInsets.only(
                                    left: 74, right: 74, top: 8, bottom: 8),
                                child: Text(
                                  "Get started",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'product',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Or",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'product',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 28, left: 40, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.white, width: 2)),
                      child: CircleAvatar(
                        maxRadius: 28,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          GroovinMaterialIcons.facebook,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.white, width: 2)),
                      child: CircleAvatar(
                        maxRadius: 28,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          GroovinMaterialIcons.google,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.white, width: 2)),
                      child: CircleAvatar(
                        maxRadius: 28,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          GroovinMaterialIcons.twitter,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 8),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () => Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login())))),
            ],
          ),
        ));
  }

  Future<void> validate() async {
    if (key.currentState.validate()) {
      key.currentState.save();
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: this._uemail, password: this._upassword)
          .then((user) {
        //user.sendEmailVerification();
        Firestore.instance.runTransaction((tx) async {
          await tx
              .set(Firestore.instance.collection("User").document(user.uid), {
            "uname": this._uname,
            "ulastname": this._ulastname,
            "uimg": this._uimg,
            "utag": true,
            "uemail": this._uemail,
            "password": this._upassword,
            "ubio": this._ubio
          });
        });
        Navigator.pop(context);
      }).catchError((error) {
        print(error);
      });
    }
  }
}
