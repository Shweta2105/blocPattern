import 'package:flutter/material.dart';

import '../service/auth/auth_exception.dart';
import '../service/auth/auth_service.dart';
import '../utils/constants.dart';
import '../utils/userentrytextfield.dart';
import 'loginscreen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/signup';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();

  bool emailValid = true;
  bool passwordValid = true;
  bool nameValid = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
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
                checkValidation: (String value) {
                  nameValid = value.length <= 15;
                },
                controller: nameEditingController,
                labelText: 'Name',
                isValid: nameValid,
              ),
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
                  child: const Text('Sign In',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  onPressed: () async {
                    try {
                      await AuthService.firebase().createUser(
                        email: emailEditingController.text,
                        password: passwordEditingController.text,
                      );
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    } on WeakPasswordAuthException catch (e) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Text('Weak Password');
                          });
                    } on EmailAlreadyInUseAuthException catch (e) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Text('This Email is Already in use. ');
                          });
                    } on InvalidEmailAuthException catch (e) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Text('Invalid Email Id');
                          });
                    } on GenericAuthException catch (e) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Text('Failed to register');
                          });
                    }
                  }
                  //loginUser
                  //loginUser
                  ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Or',
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
                  child: const Text('Sign Up with Google',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
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
