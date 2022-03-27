import 'package:blocprovider/screens/homescreen.dart';
import 'package:blocprovider/screens/registerscreen.dart';
import 'package:blocprovider/screens/verifyemail.dart';
import 'package:flutter/material.dart';

import '../service/auth/auth_exception.dart';
import '../service/auth/auth_service.dart';
import '../utils/constants.dart';
import '../utils/userentrytextfield.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  bool emailValid = true;
  bool passwordValid = true;

  @override
  void initState() {
    super.initState();
    emailEditingController;
    passwordEditingController;
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text(
          "Login",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              "BookStoreApp",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.withOpacity(0.8)),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 100,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: UserEntryTextField(
                obscureText: false,
                checkValidation: (value) {
                  if (emailRegExp.hasMatch(value)) {
                    emailValid = true;
                  } else {
                    emailValid = false;
                  }
                  setState(() {});
                },
                controller: emailEditingController,
                labelText: 'Email',
                isValid: emailValid,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 100,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: UserEntryTextField(
                obscureText: true,
                checkValidation: (value) {
                  if (passwordRegExp.hasMatch(value)) {
                    passwordValid = true;
                  } else {
                    passwordValid = false;
                  }
                  setState(() {});
                },
                controller: passwordEditingController,
                labelText: 'Password',
                isValid: passwordValid,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.transparent,
                  child: const Text('Login',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  onPressed: () async {
                    try {
                      await AuthService.firebase().logIn(
                        email: emailEditingController.text,
                        password: passwordEditingController.text,
                      );
                      final user = AuthService.firebase().currentUser;
                      if (user?.isEmailVerified ?? false) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            HomeScreen.routeName, (route) => false);
                      } else {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            VerifyEmailScreen.routeName, (route) => false);
                      }
                    } on UserNotFoundException {}
                  }
                  //loginUser
                  ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Does not have account?',
              style: TextStyle(
                  fontSize: 15, color: Colors.orange.withOpacity(0.8)),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: FlatButton(
                  textColor: Colors.orange.withOpacity(0.8),
                  color: Colors.transparent,
                  child: const Text('Sign in',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  onPressed: () {
                    Navigator.of(context).pushNamed(RegisterScreen.routeName);
                  }
                  //loginUser
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
