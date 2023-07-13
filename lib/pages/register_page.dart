import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:groupie/pages/login.dart';
import 'package:groupie/widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            nextScreen(context, LoginPage());
          },
          child: Text('Go back')),
    );
  }
}
