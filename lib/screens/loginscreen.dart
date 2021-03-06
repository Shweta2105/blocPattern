import 'package:blocprovider/extensions/buildcontext/loc.dart';
import 'package:blocprovider/service/auth/bloc/auth_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/auth/auth_exception.dart';

import '../service/auth/bloc/auth_bloc.dart';
import '../service/auth/bloc/auth_state.dart';
import '../utilities/dialog/errordialog.dart';
import '../utilities/constants.dart';
import '../utilities/userentrytextfield.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundException) {
            await showErrorDialog(
                context, context.loc.login_error_cannot_find_user);
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(
                context, context.loc.login_error_wrong_credentials);
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, context.loc.login_error_auth_error);
          }
        }
      },
      child: Scaffold(
        backgroundColor: homeColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: Text(
            context.loc.login,
            style: TextStyle(fontSize: 25, color: Colors.orange),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
              const SizedBox(
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
              const SizedBox(
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
                      final email = emailEditingController.text;
                      final password = passwordEditingController.text;

                      context
                          .read<AuthBloc>()
                          .add(AuthEventLogin(email, password));
                    }
                    //loginUser
                    ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                context.loc.login_view_not_registered_yet,
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
                    child: Text(context.loc.register,
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(const AuthEventShouldRegister());
                    }
                    //loginUser
                    ),
              ),
              TextButton(
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventForgotPassword());
                  },
                  child: Text(
                    context.loc.forgot_password,
                    style: TextStyle(color: Colors.orange),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
