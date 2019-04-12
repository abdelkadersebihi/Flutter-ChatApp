import 'package:chat_pfe/Util/KColors.dart';
import 'package:chat_pfe/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Material(
        color: KColors.primary,
        child: InkWell(
          onTap: _dialog,
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
                      colors: [KColors.popout, KColors.popout],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(40)),
                padding: EdgeInsets.all(1),
                margin: EdgeInsets.only(left: 12, right: 8, top: 4, bottom: 4),
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
                    CircleAvatar(
                  backgroundImage: NetworkImage(widget.doc.data["uimg"]),
                  maxRadius: 35,
                ),
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
                        style: TextStyle(color: KColors.third, fontSize: 20),
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
                        style: TextStyle(color: KColors.fourth, fontSize: 16),
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
          return Container(
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.only(left: 30, right: 30, top: 70, bottom: 350),
            decoration: BoxDecoration(color: KColors.secondary),
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                resizeToAvoidBottomPadding: false,
                backgroundColor: KColors.primary,
                body: ListView(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 10, bottom: 8),
                      child: Text(
                        "New message:",
                        style: TextStyle(color: KColors.popout, fontSize: 16),
                      ),
                    ),
                    Container(
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
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: KColors.secondary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: KColors.secondary),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 100, right: 10, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: KColors.fourth, fontSize: 16),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();

                                Firestore.instance.runTransaction((trs) async {
                                  await firestore.collection('Chat').add({
                                    "cname": widget.doc.data["uname"] +
                                        " and " +
                                        userDocument.data["uname"],
                                    "cparts": [
                                      firebaseUser.uid,
                                      widget.doc.documentID
                                    ],
                                    "cnames": [
                                      widget.doc.data["uname"],
                                      userDocument.data["uname"]
                                    ],
                                    "cimg": "https://firebasestorage.googleapis.com/v0/b/firestore-74deb.appspot.com/o/conv.png?alt=media&token=51c51e26-d527-4f90-97c3-d708d5d90374"
                                  }).then((onValue) async {
                                    await onValue.collection("Message").add({
                                      "mfrom": firebaseUser.uid,
                                      "mctn": msg,
                                      "mdate":
                                          DateTime.now().millisecondsSinceEpoch
                                    });
                                  });
                                }
                                // ).catchError((onError){
                                //   showBottomSheet(
                                //     context: context,
                                //     builder: (BuildContext context){
                                //       return Text(onError);
                                //     }
                                //   );  
                                // }
                                );
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                    color: KColors.popout, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          );
        });
  }

  // Future<void> edit(GlobalKey<FormState> formKey) async {}
}
