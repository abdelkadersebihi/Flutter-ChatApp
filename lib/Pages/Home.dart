import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_pfe/Pages/Friends.dart';
import 'package:chat_pfe/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_pfe/Pages/Messages.dart';
import 'package:chat_pfe/Pages/Profile.dart';
import 'package:chat_pfe/Util/KColors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController controller;
  int selected = 0;
  String title = "Home";
  @override
  void initState() {
    super.initState();
    controller = new PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: KColors.primary,
        appBar: AppBar(
          backgroundColor: KColors.primary,
          elevation: 0,
          title: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 4, right: 8),
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: firestore
                        .collection("User")
                        .document(firebaseUser.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                            child: CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(snapshot.data["uimg"]),
                          maxRadius: 20,
                        ));
                      } else {
                        return Container(
                          child: CircleAvatar(
                            backgroundColor: KColors.secondary,
                            maxRadius: 20,
                          ),
                        );
                      }
                    },
                  ),
                ),
                Container(
                  child: Text(
                    title,
                    style: TextStyle(color: KColors.third, fontSize: 22),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            PopupMenuButton(
              icon: Icon(Icons.more_vert, color: KColors.third),
              onSelected: (index) {
                switch (index) {
                  case 0:
                    _showSettingsDialog();
                    break;
                  case 1:
                    _showAboutDialog();
                    break;
                  case 2:
                    _showHelpDialog();
                    break;

                  default:
                }
              },
              elevation: 3,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      value: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Account",
                            style: TextStyle(color: KColors.third),
                          ),
                          Icon(
                            LineIcons.refresh,
                            color: KColors.fourth,
                          )
                        ],
                      )),
                  PopupMenuItem(
                      value: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "About",
                            style: TextStyle(color: KColors.third),
                          ),
                          Icon(
                            LineIcons.info_circle,
                            color: KColors.fourth,
                            size: 22,
                          )
                        ],
                      )),
                  PopupMenuItem(
                      value: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Help",
                            style: TextStyle(color: KColors.third),
                          ),
                          Icon(
                            LineIcons.question_circle,
                            color: KColors.fourth,
                          )
                        ],
                      )),
                ];
              },
            )
          ],
        ),
        body: Container(
          color: KColors.primary,
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            children: <Widget>[
              Messages(),
              Friends(),
              Profile(
                firebaseUserId: firebaseUser.uid,
              ),
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: 54,
          backgroundColor: KColors.primary,
          buttonBackgroundColor: KColors.popout,
          color: KColors.secondary,
          items: <Widget>[
            Icon(
              LineIcons.home,
              size: 26,
              color: KColors.third,
            ),
            Icon(
              LineIcons.group,
              size: 26,
              color: KColors.third,
            ),
            Icon(
              LineIcons.user,
              size: 26,
              color: KColors.third,
            ),
          ],
          animationDuration: Duration(milliseconds: 400),
          animationCurve: Curves.linearToEaseOut,
          onTap: (index) {
            //Handle button tap
            // controller.jumpToPage(index);

            switch (index) {
              case 0:
                setState(() {
                  title = "Home";
                });
                break;
              case 1:
                setState(() {
                  title = "Friends";
                });
                break;
              case 2:
                setState(() {
                  title = "Profile";
                });
                break;
              default:
            }
            controller.animateToPage(index,
                duration: Duration(milliseconds: 400), curve: Curves.ease);
          },
        ),
      ),
    );
  }

  void _showSettingsDialog() {
    if (selected == 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              backgroundColor: KColors.primary,
              title: Text(
                "Settings",
                style: TextStyle(color: KColors.third),
              ),
              children: <Widget>[
                Center(
                  child: ListTile(
                    leading: Icon(
                      LineIcons.refresh,
                      color: KColors.popout,
                    ),
                    title: Text("Rest password",
                        style: TextStyle(color: KColors.fourth)),
                    onTap: () {
                      // Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              new EditPassword());
                    },
                  ),
                ),
                Center(
                  child: ListTile(
                    leading: Icon(
                      Icons.remove_circle_outline,
                      color: KColors.lightPopout,
                    ),
                    title: Text("Delete account",
                        style: TextStyle(color: KColors.fourth)),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: KColors.primary,
                              title: Text(
                                "Delete Account?",
                                style: TextStyle(color: KColors.third),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("cancel",
                                      style: TextStyle(color: KColors.fourth)),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                FlatButton(
                                  child: Text("Delete",
                                      style: TextStyle(
                                          color: KColors.lightPopout)),
                                  onPressed: () {
                                    firebaseUser.delete().then((onValue) async {
                                      await firestore
                                          .collection("User")
                                          .document(firebaseUser.uid)
                                          .delete();
                                    }).catchError((onError) {
                                      print(onError);
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                  ),
                ),
              ],
            );
          });
    }
  }

  void _showAboutDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: KColors.primary,
            title: Text("About Project: chat_App!",
                style: TextStyle(color: KColors.third)),
            content: Text(
              "Products used Flutter & Firebase by: Menaa Muhamed Elamine thank you",
              textAlign: TextAlign.center,
              style: TextStyle(color: KColors.fourth),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Ok",
                  style: TextStyle(color: KColors.popout),
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  void _showHelpDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: KColors.primary,
            title: Text("Help:", style: TextStyle(color: KColors.third)),
            content: Text(
              "You can now go to Contancts List then press on a Random contact to stat a conversation, Enjoy!",
              textAlign: TextAlign.center,
              style: TextStyle(color: KColors.fourth),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Great!",
                  style: TextStyle(color: KColors.popout),
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }
}

class EditPassword extends StatefulWidget {
  @override
  EditPasswordState createState() {
    return EditPasswordState();
  }
}

class EditPasswordState extends State<EditPassword> {
  final formKey = GlobalKey<FormState>();
  String _password;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: KColors.secondary,
      title: Text(
        "Reset password",
        style: TextStyle(color: KColors.third),
      ),
      content: Container(
        padding: EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: TextFormField(
            onSaved: (input) {
              _password = input;
            },
            validator: (input) {
              if (input.length < 6) {
                return "provide more than 6 characters";
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
            ),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(color: KColors.fourth),
          ),
        ),
        FlatButton(
          onPressed: edit,
          child: Text(
            "Reset",
            style: TextStyle(color: KColors.popout),
          ),
        )
      ],
    );
  }

  Future<void> edit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      await firebaseUser.updatePassword(_password).then((onValue) {
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
              'upassword': _password,
            });
          });
        });
        firebaseAuth.signOut();
      });
      Navigator.pop(context);
    }
  }
}
