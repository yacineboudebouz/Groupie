import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:groupie/pages/home.dart';

import '../helper/helper_function.dart';
import '../service/auth_service.dart';
import '../widgets/profile/drawer_profile.dart';
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
      drawer: DrawerProfile(userName: _userName, authService: authService),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 170),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.account_circle,
              size: 200,
              color: Colors.grey[900],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Full Name',
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  _userName,
                  style: const TextStyle(fontSize: 17),
                )
              ],
            ),
            const Divider(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Email',
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  _email,
                  style: const TextStyle(fontSize: 17),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
