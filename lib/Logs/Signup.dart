import 'package:chat_pfe/Logs/Login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin:
                    EdgeInsets.only(top: 18, left: 35, right: 35, bottom: 20),
                child: Card(
                  color: Colors.white,
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
                                    _uname = input.trim();
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
                                    _ulastname = input.trim();
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
                                    _uemail = input.trim();
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
                            top: 40, bottom: 40, left: 8, right: 8),
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
                  margin: EdgeInsets.only(top: 8),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () => pagecontroller.animateToPage(0,
                          curve: Curves.ease,
                          duration: Duration(milliseconds: 500)))),
            ],
          ),
        ));
  }

  Future<void> validate() async {
    BuildContext dialogCtx;
    if (key.currentState.validate()) {
      key.currentState.save();
      showDialog(
          context: context,
          builder: (dcontext) {
            dialogCtx = dcontext;
            return SimpleDialog(
              title: Text("Loading.."),
              titlePadding: EdgeInsets.all(8),
              contentPadding: EdgeInsets.all(12),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              ],
            );
          });
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: this._uemail, password: this._upassword)
          .then((user) {
        Navigator.of(dialogCtx).pop(true);
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
      }).catchError((onError) {
        Navigator.of(dialogCtx).pop(true);
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                title: Text(
                  "Ops! Something went wrong..",
                ),
                content: Text(
                  "Having Trubble signing up with this email or password..!",
                  maxLines: 3,
                ),
                //  Text(onError.toString(),maxLines: 3,overflow: TextOverflow.ellipsis,),
                actions: <Widget>[
                  FlatButton(
                      child: Text("Retry"),
                      onPressed: () => Navigator.pop(context))
                ],
              );
            });
      });
    }
  }
}
