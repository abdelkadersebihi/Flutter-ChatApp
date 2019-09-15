import 'package:chat_pfe/Util/KColors.dart';
import 'package:chat_pfe/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math';

class User extends StatefulWidget {
  final DocumentSnapshot doc;

  const User({Key key, this.doc}) : super(key: key);

  @override
  UserState createState() {
    return UserState();
  }
}

class UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    // Random rnd = new Random();
    return Container(
      padding: EdgeInsets.only(top: 2,bottom: 2,left: 4),
      decoration: BoxDecoration(
        // border: Border(
        //     right: BorderSide(
        //         color: Color.fromRGBO(rnd.nextInt(130) + 100,
        //             rnd.nextInt(100) + 100, rnd.nextInt(100) + 100, 1),
        //         width: 10)),
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //       blurRadius: 5,
        //       color: Color.fromRGBO(10, 10, 10, 1),
        //       offset: Offset(0, 2)),
        // ],
      ),
      margin: EdgeInsets.only(top: 6, left: 4, right: 4),
      child: Material(
        color: KColors.primary,
        child: InkWell(
          onTap: _dialog,
          child: Row(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    // boxShadow: <BoxShadow>[
                    //   BoxShadow(
                    //       blurRadius: 5,
                    //       color: Color.fromRGBO(20, 20, 20, 1),
                    //       offset: Offset(0, 2)),
                    // ],
                    // gradient: LinearGradient(
                    //   colors: [KColors.popout, KColors.popout],
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    // ),
                    // color: KColors.primary,
                    // borderRadius: BorderRadius.circular(40)
                  ),
                  // padding: EdgeInsets.all(1),
                  margin: EdgeInsets.only(right: 8),
                  child:
                      // StreamBuilder<DocumentSnapshot>(
                      //   stream: firestore.collection("User").document(widget.doc.documentID).snapshots(),
                      //   builder: (context, snapshot) {
                      //     if (!snapshot.hasData) {
                      //       return CircleAvatar(
                      //         backgroundColor: KColors.secondary,
                      //         maxRadius: 35,
                      //       );
                      //     } else {
                      // return
                     Container(
                       padding: EdgeInsets.all(2),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.all(Radius.circular(40))
                       ),
                       child: CircleAvatar(
                         maxRadius: 35,
                         backgroundImage: CachedNetworkImageProvider(
                                widget.doc.data["uimg"]
                                ),
                       ),
                     )
                  //     }
                  //   },
                  // )
                  ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child:
                          //  StreamBuilder<DocumentSnapshot>(
                          //   stream: firestore.collection("User").document(widget.doc.documentID).snapshots(),
                          //   builder: (context, snapshot) {
                          //     if (!snapshot.hasData) {
                          //       return Icon(
                          //         Icons.more_horiz,
                          //         size: 28,
                          //         color: KColors.third,
                          //       );
                          //     } else {
                          //       return
                          Text(
                        widget.doc.data["uname"] +
                            " " +
                            widget.doc.data["ulastname"],
                        style: TextStyle(color: KColors.third, fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                        //     );
                        //   }
                        // },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child:
                          // StreamBuilder<DocumentSnapshot>(
                          //   stream: firestore.collection("User").document(widget.doc.documentID).snapshots(),
                          //   builder: (context, snapshot) {
                          //     if (!snapshot.hasData) {
                          //       return Icon(
                          //         Icons.more_horiz,
                          //         size: 20,
                          //         color: KColors.fourth,
                          //       );
                          //     } else {
                          //       return
                          Text(
                        widget.doc.data["uemail"],
                        style: TextStyle(color: KColors.fourth, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        //     );
                        //   }
                        // },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 18),
                child:
                    //  StreamBuilder<DocumentSnapshot>(
                    //   stream: firestore.collection("User").document(widget.doc.documentID).snapshots(),
                    //   builder: (context, snapshot){
                    //     if(!snapshot.hasData){
                    //       return Text("...",
                    //     style: TextStyle(color: KColors.popout, fontSize: 18));
                    //     }else{
                    //       return
                    Text(widget.doc.data["utag"] ? "Active" : "",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: KColors.popout, fontSize: 14)),
                //   }
                // },
                // )
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _dialog() {
    final formKey = GlobalKey<FormState>();
    String msg;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: KColors.primary,
            title: Text("New message", style: TextStyle(color: KColors.third)),
            content: Container(
              padding: EdgeInsets.all(8),
              child: Form(
                key: formKey,
                child: TextFormField(
                  onSaved: (input) {
                    msg = input;
                  },
                  validator: (input) {
                    if (input.isEmpty) {
                      return "type somthing";
                    }
                  },
                  cursorWidth: 1,
                  cursorColor: KColors.fourth,
                  style: TextStyle(color: KColors.third),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    fillColor: KColors.secondary,
                    filled: true,
                    hintText: 'Aa',
                    hintStyle: TextStyle(
                      color: KColors.fourth,
                    ),
                    // enabledBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(50),
                    //   borderSide: BorderSide(color: KColors.secondary),
                    // ),
                    // focusedBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(50),
                    //   borderSide: BorderSide(color: KColors.secondary),
                    // ),
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: KColors.fourth),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text(
                  "Send",
                  style: TextStyle(color: KColors.popout),
                ),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    
                    firestore.runTransaction((trs) async {
                      await firestore.collection('Chat').add({
                        "cname": widget.doc.data["uname"] +
                            " and " +
                            userDocument.data["uname"],
                        "cparts": [firebaseUser.uid, widget.doc.documentID],
                        "cnames": [
                          widget.doc.data["uname"],
                          userDocument.data["uname"]
                        ],
                        "clastdate": DateTime.now().millisecondsSinceEpoch,
                        "cimg":
                            "https://firebasestorage.googleapis.com/v0/b/firestore-74deb.appspot.com/o/conv.png?alt=media&token=51c51e26-d527-4f90-97c3-d708d5d90374"
                      }).then((onValue) async {
                        await onValue.collection("Message").add({
                          "mfrom": firebaseUser.uid,
                          "mctn": msg,
                          "mdate": DateTime.now().millisecondsSinceEpoch
                        });
                      });
                    }
                        );
                    Navigator.pop(context);
                  }
                },
              )
            ],
          );
        });
  }

}
