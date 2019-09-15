import 'package:chat_pfe/Logs/Login.dart';
import 'package:flutter/material.dart';
import 'package:chat_pfe/Pages/Home.dart';
import 'package:flutter/services.dart';
import 'package:chat_pfe/Util/KColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final baseStorage = FirebaseStorage.instance.ref();
final StorageReference storage_users = baseStorage.child("User");

FirebaseUser firebaseUser;
DocumentSnapshot userDocument;
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final Firestore firestore = Firestore.instance;

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: KColors.primary,
  ));
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Router(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'product',
          cardColor: KColors.secondary,
          primaryColor: KColors.secondary,
          accentColor: KColors.primary,
          backgroundColor: KColors.secondary),
    );
  }
}

class Router extends StatefulWidget {
  @override
  RouterState createState() {
    return RouterState();
  }
}

class RouterState extends State<Router> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: firebaseAuth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          firebaseUser = snapshot.data;
          print(firebaseUser.uid);
          firestore.runTransaction((transactionHandler) async {
            userDocument = await firestore
                .collection("User")
                .document(firebaseUser.uid)
                .get();
          });
          return Home();
        } else {
          return Login();
        }
      },
    );
  }
}
