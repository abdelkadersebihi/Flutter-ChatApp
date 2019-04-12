import 'package:chat_pfe/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'KColors.dart';

class EditBio extends StatefulWidget {
  @override
  EditBioState createState() {
    return EditBioState();
  }
}

class EditBioState extends State<EditBio> {
  final formKey = GlobalKey<FormState>();
  String bio;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: KColors.secondary,
      title: Text("Edit Bio",style: TextStyle(color: KColors.third),),
      content: Container(
                padding: EdgeInsets.all(8),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    onSaved: (input) {
                      bio = input;
                    },
                    validator: (input) {
                      if (input.isEmpty) {
                        return "type somthing";
                      }
                    },
                    cursorWidth: 1,
                    cursorColor: KColors.fourth,
                    style: TextStyle(
                      color: KColors.third,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      fillColor: KColors.primary,
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
              actions: <Widget>[
                FlatButton(
                  onPressed: ()=>Navigator.pop(context),
                  child: Text("Cancel",style: TextStyle(
                    color:KColors.fourth
                  ),
                ),
                ),
                FlatButton(
                  onPressed: edit,
                  child: Text("Edit",style: TextStyle(
                    color:KColors.popout
                  ),
                  ),
                )

              ],
    );
  }

  Future<void> edit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      firestore.runTransaction((trs) async {
        firestore
            .collection('User')
            .document(firebaseUser.uid)
            .get()
            .then((DocumentSnapshot snapshot) async {
          await firestore
              .collection("User")
              .document(firebaseUser.uid)
              .updateData({
            'ubio': bio,
          });
        });
      });
      Navigator.pop(context);
    }
  }
}

