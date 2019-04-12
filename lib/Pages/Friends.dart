import 'package:chat_pfe/Widget/User.dart';
import 'package:chat_pfe/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_pfe/Util/KColors.dart';

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: KColors.primary,
        body: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection("User").snapshots(),
          builder: (context,snapshot){
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );              
            } else {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context,position){
                  print(snapshot.data.documents.length);
                  return User(
                    doc: snapshot.data.documents[position],
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 2,
          backgroundColor: KColors.secondary,
          child: Icon(
            Icons.search,
            color: KColors.popout,
          ),
          onPressed: () {
            firebaseAuth.signOut();
          },
        ),
      ),
    );
  }
}


