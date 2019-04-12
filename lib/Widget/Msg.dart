import 'package:chat_pfe/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_pfe/Pages/Chat.dart';
import 'package:chat_pfe/Util/KColors.dart';

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
              context,
              MaterialPageRoute(
                  builder: (ctx) => Chat(
                        doc: doc
                      ))),
          onLongPress: (){
            showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  backgroundColor: KColors.secondary,
                  title: Text("Delete conversation",style: TextStyle(color: KColors.third),),
                  content: Text("delete ever message?",style: TextStyle(color: KColors.third),),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Cancel",style: TextStyle(color: KColors.popout),),
                      onPressed: ()=>Navigator.pop(context),
                    ),
                    FlatButton(
                      child: Text("Delete",style: TextStyle(color: KColors.lightPopout),),
                      onPressed: (){
                        firestore.runTransaction((transactionHandler)async{
                          await firestore.collection("Chat").document(doc.documentID).delete().then((onValue){
                            Navigator.pop(context);
                          });
                        });
                      },
                    ),
                  ],

                );
              }
            );
          },
          child: Row(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            blurRadius: 5,
                            color: Color.fromRGBO(20, 20, 20, 1),
                            offset: Offset(0, 2)),
                      ],
                      gradient: LinearGradient(
                        colors: [KColors.lightPopout, KColors.popout],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
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
                          maxRadius: 35,
                        );
                      } else {
                        return CircleAvatar(
                          
                          backgroundImage: NetworkImage(snapshot.data["cimg"]),
                          // backgroundColor: KColors.primary, 
                          maxRadius: 35,
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
                      margin: EdgeInsets.only(left: 8),
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
                                  TextStyle(color: KColors.third, fontSize: 20),
                              overflow: TextOverflow.ellipsis,
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
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
                                  color: KColors.fourth, fontSize: 16),
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
                child: Text("3h",
                    style: TextStyle(color: KColors.popout, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
