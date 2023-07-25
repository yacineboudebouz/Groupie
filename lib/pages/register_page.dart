
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:groupie/helper/helper_function.dart';
import 'package:groupie/pages/home.dart';
import 'package:groupie/pages/login.dart';
import 'package:groupie/service/auth_service.dart';
import 'package:groupie/widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String email = '';
  String password = '';
  String fullName = '';
  bool _isShowen = true;
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Groupie',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Create your acount now to chat and explore',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      Image.asset('assets/register.png'),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            fullName = value;
                          });
                        },
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Full Name',
                          floatingLabelStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Must enter your name !';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Email',
                          floatingLabelStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        validator: (value) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!)
                              ? null
                              : "Please enter a valid email";
                        },
                      ),
                     const  SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Password must be at least 6 characters';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        obscureText: _isShowen,
                        decoration: textInputDecoration.copyWith(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isShowen = !_isShowen;
                                });
                              },
                              icon:const  Icon(Icons.remove_red_eye)),
                          floatingLabelStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor),
                            onPressed: () {
                              register();
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text.rich(TextSpan(
                          text: "Have account ?",
                          style: const  TextStyle(color: Colors.black, fontSize: 14),
                          children: [
                            TextSpan(
                                text: "Login here",
                                style: const  TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    nextScreen(context, const LoginPage());
                                  }),
                          ]))
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerWithEmailAndPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);
          // ignore: use_build_context_synchronously
          nextScreen(context, const HomePage());
          // setting shared state
        } else {
          showSnackBar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
