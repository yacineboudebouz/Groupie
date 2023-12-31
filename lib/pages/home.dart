import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:groupie/helper/helper_function.dart';

import 'package:groupie/pages/search_page.dart';
import 'package:groupie/service/auth_service.dart';
import 'package:groupie/service/database_service.dart';
import 'package:groupie/widgets/home/no_groups.dart';
import 'package:groupie/widgets/widgets.dart';

import '../widgets/home/drawer_home.dart';
import '../widgets/home/group_list_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  String _userName = '';
  String _email = '';
  Stream? groups;
  bool _isLoading = false;
  String groupName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmail().then((value) {
      setState(() {
        _email = value!;
      });
    });
    await HelperFunctions.getUserName().then((value) {
      setState(() {
        _userName = value!;
      });
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                nextScreenNotReplace(context, const SearchPage());
              },
              icon: const Icon(
                Icons.search,
              ))
        ],
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        elevation: 1.0,
        title: const Text(
          'Groups',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 27),
        ),
      ),
      drawer: DrawerHome(userName: _userName, authService: authService),
      body: GroupListBuilder(groups: groups),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) => AlertDialog(
                  title: const Text(
                    'Create a group',
                    textAlign: TextAlign.left,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          : TextField(
                              onChanged: (value) {
                                groupName = value;
                              },
                              decoration: textInputDecoration,
                            ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor),
                        onPressed: () async {
                          if (groupName != "") {
                            setState(() {
                              _isLoading = true;
                            });
                            DatabaseService(
                                    uid: FirebaseAuth.instance.currentUser!.uid)
                                .createGroup(
                                    _userName,
                                    FirebaseAuth.instance.currentUser!.uid,
                                    groupName)
                                .whenComplete(() {
                              setState(() {
                                _isLoading = false;
                              });
                            });
                            Navigator.of(context).pop();
                            showSnackBar(context, Colors.green,
                                "Group created successfully !");
                          }
                        },
                        child: const Text(
                          'Create',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
