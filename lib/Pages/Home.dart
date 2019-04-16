import 'package:chat_pfe/Pages/Friends.dart';
import 'package:chat_pfe/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_pfe/Pages/Messages.dart';
import 'package:chat_pfe/Pages/Profile.dart';
import 'package:chat_pfe/Util/KColors.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  PageController controller;
  int selected = 0;
  String title = "Chating";
  @override
  void initState() {
    super.initState();
    controller = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebaseAuth.currentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Loading..",
                style: TextStyle(color: KColors.third, fontSize: 22),
              ),
              elevation: 0,
              backgroundColor: KColors.primary,
            ),
            body: Container(
              color: KColors.primary,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            ),
          ));
        } else {
          return Container(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: KColors.primary,
                elevation: 0,
                title: Text(
                  title,
                  style: TextStyle(color: KColors.third, fontSize: 22),
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
                        case 3:
                          _showGithubDialog();
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
                        PopupMenuItem(
                            value: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Github",
                                  style: TextStyle(color: KColors.third),
                                ),
                                Icon(LineIcons.share, color: KColors.fourth)
                              ],
                            )),
                      ];
                    },
                  )
                ],
              ),
              body: PageView(
                physics: NeverScrollableScrollPhysics(),
                // onPageChanged: (index) {
                //   setState(() {
                //    switch (index) {
                //     case 0:
                //      title="Profile";
                //       break;
                //     case 1:
                //      title="Chats";
                //       break;
                //     case 2:
                //      title="Search";
                //       break;
                //     case 3:
                //      title="Contacts";
                //       break;
                //     default:
                //   }
                //   });
                // },
                controller: controller,
                children: <Widget>[
                  Messages(),
                  Container(
                    color: KColors.primary,
                  ),
                  Friends(),
                  Profile(
                    firebaseUserId: firebaseUser.uid,
                  ),
                ],
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
                    LineIcons.search,
                    size: 24,
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
                animationDuration: Duration(milliseconds: 1000),
                animationCurve: Curves.linearToEaseOut,
                onTap: (index) {
                  //Handle button tap
                  // controller.jumpToPage(index);
                  controller.animateToPage(index,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.ease);
                },
              ),
            ),
          );
        }
      },
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
                      // Navigator.pop(context);
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
              "Products used Flutter & Firebase Paticipants: Sebihi Abdelkader & Merouani Abdenour thank you",
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

  void _showGithubDialog() async {
    const url = 'https://github.com/aymensbh/Flutter-ChatApp';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: KColors.secondary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: KColors.secondary),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: KColors.lightPopout),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: KColors.secondary),
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
        await firebaseUser.updatePassword(_password).then((onValue) {
          firebaseAuth.signOut();
        });
      });
      Navigator.pop(context);
    }
  }
}
