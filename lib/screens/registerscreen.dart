import 'package:blocprovider/service/auth/bloc/auth_events.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/auth/bloc/auth_bloc.dart';
import '../service/auth/bloc/auth_state.dart';
import '../utilities/dialog/errordialog.dart';
import '../service/auth/auth_exception.dart';
import '../service/auth/auth_service.dart';
import '../utilities/constants.dart';
import '../utilities/userentrytextfield.dart';
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(context, 'Weak Password');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, 'Email is already used');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Invalid Email');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Failed to register');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Note App",
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
                      child: const Text('Sign In',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      onPressed: () {
                        final email = emailEditingController.text;
                        final password = passwordEditingController.text;

                        context
                            .read<AuthBloc>()
                            .add(AuthEventRegister(email, password));
                      }
                      //loginUser
                      //loginUser
                      ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: FlatButton(
                      textColor: Colors.orange.withOpacity(0.8),
                      color: Colors.transparent,
                      child: const Text('Already registered? LogIn Here!',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      onPressed: () {
                        context.read<AuthBloc>().add(const AuthEventLogOut());
                      }
                      //loginUser
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
