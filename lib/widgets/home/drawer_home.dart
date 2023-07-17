import 'package:flutter/material.dart';

import '../../pages/login.dart';
import '../../pages/profile_page.dart';
import '../../service/auth_service.dart';
import '../widgets.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({
    super.key,
    required String userName,
    required this.authService,
  }) : _userName = userName;

  final String _userName;
  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            onTap: () {},
            selectedColor: Theme.of(context).primaryColor,
            selected: true,
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
            selected: false,
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
                      content: const Text('Are you sure you want to logout ?'),
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
                                Navigator.maybeOf(context)!.pushAndRemoveUntil(
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
    );
  }
}
