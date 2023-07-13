import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:groupie/firebase_options.dart';
import 'package:groupie/helper/helper_function.dart';
import 'package:groupie/pages/home.dart';
import 'package:groupie/pages/login.dart';
import 'package:groupie/shared/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedINStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Constants.primaryColor,
          colorScheme: ColorScheme.fromSeed(seedColor: Constants.primaryColor),
          useMaterial3: true,
        ),
        home: _isSignedIn ? const HomePage() : const LoginPage());
  }
}
