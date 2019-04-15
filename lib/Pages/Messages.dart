import 'package:chat_pfe/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_pfe/Util/KColors.dart';
import 'package:chat_pfe/Widget/Msg.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    print(firebaseUser.uid);
    return Container(
      child: Scaffold(
        backgroundColor: KColors.primary,
        body: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection("Chat")
              .where("cparts", arrayContains: firebaseUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Text("No chats yet",
                      style: TextStyle(color: KColors.fourth)));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, position) {
                  return Msg(
                    doc: snapshot.data.documents[position],
                  );
                },
              );
            }
          },
        ),
        // floatingActionButton: FloatingActionButton(
        //   elevation: 2,
        //   backgroundColor: KColors.secondary,
        //   child: Icon(
        //     Icons.create,
        //     color: KColors.popout,
        //   ),
        //   onPressed: () {
        //     firebaseAuth.signOut();
        //   },
        // ),
      ),
    );
  }
}
