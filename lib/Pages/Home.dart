import 'package:chat_pfe/Pages/Friends.dart';
import 'package:chat_pfe/main.dart';
import 'package:flutter/material.dart';
import 'package:chat_pfe/Pages/Messages.dart';
import 'package:chat_pfe/Pages/Profile.dart';
import 'package:chat_pfe/Util/KColors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3, initialIndex: 1);
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
                  "Messaging",
                  style: TextStyle(color: KColors.third, fontSize: 22),
                ),
                actions: <Widget>[
                  PopupMenuButton(
                    icon: Icon(Icons.more_vert, color: KColors.third),
                    onSelected: (index) {},
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: Text("Settings"),
                        ),
                        PopupMenuItem(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Dark"),
                              Switch(
                                value: false,
                                activeColor: Colors.green,
                                activeTrackColor: Colors.grey,
                                inactiveThumbColor: Colors.black,
                                inactiveTrackColor: Colors.grey,
                                onChanged: (index) {},
                              )
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          child: Text("About"),
                        ),
                      ];
                    },
                  )
                ],
              ),
              body: TabBarView(
                controller: controller,
                children: <Widget>[
                  Profile(firebaseUserId: firebaseUser.uid,),
                  Messages(),
                  Friends(),
                ],
              ),
              bottomNavigationBar: Container(
                color: KColors.primary,
                child: TabBar(
                  controller: controller,
                  indicatorColor: KColors.primary,
                  tabs: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 40),
                      child: Tab(
                        icon: Icon(
                          Icons.person,
                          color: KColors.fourth,
                          size: 30,
                        ),
                      ),
                    ),
                    Container(
                      child: Tab(
                        icon: Icon(Icons.home, color: KColors.fourth, size: 30),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 40),
                      child: Tab(
                        icon: Icon(Icons.group, color: KColors.fourth, size: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}



