import 'package:chat_pfe/main.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:chat_pfe/Util/KColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatefulWidget {
  final DocumentSnapshot doc;

  const Chat({Key key, this.doc}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController _controller;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController();
    _scrollController = new ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        backgroundColor: KColors.primary,
        body: Container(
            child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 8, right: 4),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: KColors.popout,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 12, top: 4, bottom: 4),
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [KColors.lightPopout, KColors.popout],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(35)),
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: firestore
                            .collection("Chat")
                            .document(widget.doc.documentID)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircleAvatar(
                              backgroundColor: KColors.secondary,
                              maxRadius: 30,
                            );
                          } else {
                            return CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapshot.data["cimg"]),
                              maxRadius: 32,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            child: StreamBuilder<DocumentSnapshot>(
                          stream: firestore
                              .collection("Chat")
                              .document(widget.doc.documentID)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              print("LOOOOOOOOOL");
                              return Icon(
                                Icons.more_horiz,
                                color: KColors.third,
                                size: 28,
                              );
                            } else {
                              return Text(
                                snapshot.data["cname"],
                                style: TextStyle(
                                    color: KColors.third, fontSize: 18),
                              );
                            }
                          },
                        )),
                        Container(
                            child: StreamBuilder<QuerySnapshot>(
                          stream: firestore
                              .collection("Chat")
                              .document(widget.doc.documentID)
                              .collection("Message")
                              .orderBy("mdate", descending: true)
                              .limit(1)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Icon(
                                Icons.more_horiz,
                                color: KColors.fourth,
                                size: 22,
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
                                        " Hours ago"
                                    : (DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch - snapshot.data.documents[0].data["mdate"])
                                                .minute >
                                            1)
                                        ? DateTime.fromMillisecondsSinceEpoch(
                                                    DateTime.now().millisecondsSinceEpoch -
                                                        snapshot
                                                            .data
                                                            .documents[0]
                                                            .data["mdate"])
                                                .minute
                                                .toString() +
                                            " Minutes ago"
                                        : "Active",
                                // TimeOfDay.fromDateTime(snapshot.data.documents[0].data["mdate"]).toString(),
                                //       DateFormat('dd MMM kk:mm')
                                // .format(DateTime.fromMillisecondsSinceEpoch(int.parse(
                                //       snapshot.data.documents[0].data["mdate"]))),
                                style: TextStyle(color: KColors.fourth),
                              );
                            }
                          },
                        )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: IconButton(
                      icon: Icon(
                        Icons.info_outline,
                        color: KColors.popout,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection("Chat")
                    .document(widget.doc.documentID)
                    .collection("Message")
                    .orderBy("mdate", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      reverse: true,
                      controller: _scrollController,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, position) {
                        if (snapshot.data.documents[position].data["mfrom"] ==
                            firebaseUser.uid) {
                          return _msgSent(
                              snapshot.data.documents[position].data["mctn"]);
                        } else {
                          return _msgRecived(
                              snapshot.data.documents[position].data["mctn"],
                              snapshot.data.documents[position].data["mctn"]);
                        }
                      },
                    );
                  }
                },
              )),
            ),
            Container(
              height: 60,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 8, right: 8),
                    child: IconButton(
                      icon: Icon(
                        OMIcons.addAPhoto,
                        color: KColors.popout,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: TextField(
                        controller: _controller,
                        cursorWidth: 1,
                        cursorColor: KColors.popout,
                        style: TextStyle(color: KColors.third
                            // fontFamily: 'product'
                            ),
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            contentPadding: EdgeInsets.all(
                                10), //--------------------------------------------
                            hintText: 'Aa',
                            hintStyle: TextStyle(
                              color: KColors.fourth,
                              // fontFamily: 'product'
                            ),
                            fillColor: KColors.secondary,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: KColors.popout, width: 1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: KColors.popout, width: 1),
                              borderRadius: BorderRadius.circular(30),
                            )),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8, right: 8),
                    child: IconButton(
                      icon: Icon(
                        OMIcons.send,
                        color: KColors.popout,
                      ),
                      onPressed: () {
                        // scrolljump+=50;
                        // _scrollController.jumpTo(scrolljump);
                        String msg = _controller.text;
                        _controller.clear();

                        firestore.runTransaction((transactionHandler) async {
                          await firestore
                              .collection("Chat")
                              .document(widget.doc.documentID)
                              .collection("Message")
                              .add({
                            "mfrom": firebaseUser.uid,
                            "mctn": msg,
                            "mdate": DateTime.now().millisecondsSinceEpoch
                          });
                        });
                        _scrollController.animateTo(0.0,
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.bounceInOut);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  Widget _msgRecived(String mctn, String cimg) {
    return Container(
        margin: EdgeInsets.only(right: 100, left: 20),
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 5,
                    color: Color.fromRGBO(20, 20, 20, 1),
                    offset: Offset(0, 2)),
              ],
              color: KColors.secondary,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(4))),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(4),
          child:
              Text(mctn, style: TextStyle(color: KColors.third, fontSize: 16)),
        ));
  }

  Widget _msgSent(String mctn) {
    return Container(
        margin: EdgeInsets.only(left: 100, right: 20),
        alignment: Alignment.centerRight,
        child: Container(
          decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 5,
                    color: Color.fromRGBO(20, 20, 20, 1),
                    offset: Offset(0, 2)),
              ],
              color: KColors.popout,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(4))),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(4),
          child:
              Text(mctn, style: TextStyle(color: KColors.third, fontSize: 16)),
        ));
  }
}
