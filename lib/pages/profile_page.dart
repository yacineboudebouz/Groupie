import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:groupie/pages/home.dart';

import '../helper/helper_function.dart';
import '../service/auth_service.dart';
import '../widgets/widgets.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  String _userName = '';
  String _email = '';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        elevation: 1.0,
        title: const Text(
          'Profile Page',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 27),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 60),
          children: [
            const Icon(
              Icons.account_circle,
              size: 150,
            ),
            Text(
              _userName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {
                nextScreen(context, const HomePage());
              },
              selectedColor: Theme.of(context).primaryColor,
              selected: false,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                'Groups',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                nextScreen(context, const ProfilePage());
              },
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.account_circle),
              title: const Text(
                'Profile',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Logout'),
                        content:
                            const Text('Are you sure you want to logout ?'),
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              )),
                          IconButton(
                              onPressed: () async {
                                await authService.signOut().whenComplete(() {
                                  Navigator.maybeOf(context)!
                                      .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()),
                                          (route) => false);
                                });
                              },
                              icon: const Icon(
                                Icons.done,
                                color: Colors.green,
                              )),
                        ],
                      );
                    });
              },
              selectedColor: Theme.of(context).primaryColor,
              selected: false,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
