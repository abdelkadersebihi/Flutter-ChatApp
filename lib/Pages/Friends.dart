import 'package:chat_pfe/Widget/User.dart';
import 'package:chat_pfe/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_pfe/Util/KColors.dart';
import 'package:line_icons/line_icons.dart';

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
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
                  if(snapshot.data.documents[position].documentID==firebaseUser.uid)
                  return Container();
                  else
                  return User(
                    doc: snapshot.data.documents[position],
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: KColors.popout,
          child: Icon(LineIcons.pencil,
        ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   elevation: 2,
        //   backgroundColor: KColors.secondary,
        //   child: Icon(
        //     Icons.share,
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



// class Share extends StatefulWidget {
//   @override
//   ShareState createState() {
//     return ShareState();
//   }
// }

// class ShareState extends State<Share> {
//   final formKey = GlobalKey<FormState>();
//   String bio;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: KColors.secondary,
//       title: Text("Share",style: TextStyle(color: KColors.third),),
//       content: Container(
//                 padding: EdgeInsets.all(8),
//                 child: Form(
//                   key: formKey,
//                   child: TextFormField(
//                     onSaved: (input) {
//                       bio = input;
//                     },
//                     validator: (input) {
//                       if (input.isEmpty) {
//                         return "type somthing";
//                       }
//                     },
//                     cursorWidth: 1,
//                     cursorColor: KColors.fourth,
//                     style: TextStyle(
//                       color: KColors.third,
//                     ),
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.all(12),
//                       fillColor: KColors.primary,
//                       filled: true,
//                       hintText: 'Aa',
//                       hintStyle: TextStyle(
//                         color: KColors.fourth,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide: BorderSide(color: KColors.secondary),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide: BorderSide(color: KColors.secondary),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               actions: <Widget>[
//                 FlatButton(
//                   onPressed: ()=>Navigator.pop(context),
//                   child: Text("Cancel",style: TextStyle(
//                     color:KColors.fourth
//                   ),
//                 ),
//                 ),
//                 FlatButton(
//                   onPressed: _share,
//                   child: Text("Send",style: TextStyle(
//                     color:KColors.popout
//                   ),
//                   ),
//                 )

//               ],
//     );
//   }

//   Future<void> _share() async {
//     if (formKey.currentState.validate()) {
//       formKey.currentState.save();

//       firestore.runTransaction((trs) async {
//         QuerySnapshot users=firestore.collection("User").snapshots();
//         firestore.collection("Chat").add({"cimg": "url","cparts":firestore.collection("User").snapshots()});



//         // firestore
//         //     .collection('User')
//         //     .document(firebaseUser.uid)
//         //     .get()
//         //     .then((DocumentSnapshot snapshot) async {
//         //   await firestore
//         //       .collection("User")
//         //       .document(firebaseUser.uid)
//         //       .updateData({
//         //     'ubio': bio,
//         //   });
//         // });
//       });
//       Navigator.pop(context);
//     }
//   }
// }




