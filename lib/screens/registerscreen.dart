import 'package:blocprovider/extensions/buildcontext/loc.dart';
import 'package:blocprovider/service/auth/bloc/auth_events.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/auth/bloc/auth_bloc.dart';
import '../service/auth/bloc/auth_state.dart';
import '../utilities/dialog/errordialog.dart';
import '../service/auth/auth_exception.dart';
import '../utilities/constants.dart';
import '../utilities/userentrytextfield.dart';

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
            await showErrorDialog(
                context, context.loc.register_error_weak_password);
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(
                context, context.loc.register_error_email_already_in_use);
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(
                context, context.loc.register_error_invalid_email);
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, context.loc.register_error_generic);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.loc.register),
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
                  "Check Notes",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.withOpacity(0.8)),
                ),
                const SizedBox(
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
                      child: Text(context.loc.register,
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
                      child: Text(context.loc.register_view_already_registered,
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
