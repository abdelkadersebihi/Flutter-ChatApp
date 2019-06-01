import 'package:chat_pfe/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_pfe/Pages/Chat.dart';
import 'package:chat_pfe/Util/KColors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Msg extends StatelessWidget {
  final DocumentSnapshot doc;

  const Msg({Key key, this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Material(
        color: KColors.primary,
        child: InkWell(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => Chat(doc: doc))),
          onLongPress: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: KColors.secondary,
                    title: Text(
                      "Delete conversation",
                      style: TextStyle(color: KColors.third),
                    ),
                    content: Text(
                      "Delete every message?",
                      style: TextStyle(color: KColors.fourth),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: KColors.popout),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      FlatButton(
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            color: KColors.lightPopout,
                          ),
                        ),
                        onPressed: () {
                          firestore.runTransaction((transactionHandler) async {
                            await firestore
                                .collection("Chat")
                                .document(doc.documentID)
                                .delete()
                                .then((onValue) {
                              Navigator.pop(context);
                            });
                          });
                        },
                      ),
                    ],
                  );
                });
          },
          child: Row(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[
                            Color.fromRGBO(76, 184, 196, 1),
                            Color.fromRGBO(60, 211, 173, 1)
                          ]),
                      // gradient: LinearGradient(
                      //   colors: [KColors.popout, KColors.popout],
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      // ),
                      borderRadius: BorderRadius.circular(40)),
                  padding: EdgeInsets.all(1),
                  margin:
                      EdgeInsets.only(left: 12, right: 8, top: 4, bottom: 4),
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: firestore
                        .collection("Chat")
                        .document(doc.documentID)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircleAvatar(
                          backgroundColor: KColors.secondary,
                          maxRadius: 28,
                        );
                      } else {
                        return CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            snapshot.data["cimg"],
                          ),
                          // backgroundColor: KColors.primary,
                          maxRadius: 32,
                        );
                      }
                    },
                  )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 8, bottom: 2),
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: firestore
                            .collection("Chat")
                            .document(doc.documentID)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Icon(
                              Icons.more_horiz,
                              size: 28,
                              color: KColors.third,
                            );
                          } else {
                            return Text(
                              snapshot.data["cname"],
                              style:
                                  TextStyle(color: KColors.third, fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8, top: 2),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: firestore
                            .collection("Chat")
                            .document(doc.documentID)
                            .collection("Message")
                            .orderBy("mdate", descending: true)
                            .limit(1)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Icon(
                              Icons.more_horiz,
                              size: 20,
                              color: KColors.fourth,
                            );
                          } else {
                            return Text(
                              snapshot.data.documents[0].data["mctn"],
                              style: TextStyle(
                                  color: KColors.fourth, fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 18),
                child: StreamBuilder<QuerySnapshot>(
                  stream: firestore
                      .collection("Chat")
                      .document(doc.documentID)
                      .collection("Message")
                      .orderBy("mdate", descending: true)
                      .limit(1)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Icon(
                        Icons.more_horiz,
                        size: 16,
                        color: KColors.popout,
                      );
                    } else {
                      return Text(
                          DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch - snapshot.data.documents[0].data["mdate"]).hour > 1
                              ? DateTime.fromMillisecondsSinceEpoch(
                                          DateTime.now().millisecondsSinceEpoch -
                                              snapshot.data.documents[0]
                                                  .data["mdate"])
                                      .hour
                                      .toString() +
                                  " h"
                              : (DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch - snapshot.data.documents[0].data["mdate"]).minute > 1)
                                  ? DateTime.fromMillisecondsSinceEpoch(
                                              DateTime.now()
                                                      .millisecondsSinceEpoch -
                                                  snapshot.data.documents[0]
                                                      .data["mdate"])
                                          .minute
                                          .toString() +
                                      " mins ago"
                                  : "Just now",
                          style: TextStyle(color: KColors.popout, fontSize: 12));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
