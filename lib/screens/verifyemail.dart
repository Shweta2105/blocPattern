import 'package:blocprovider/screens/registerscreen.dart';
import 'package:blocprovider/service/auth/auth_service.dart';
import 'package:blocprovider/service/auth/bloc/auth_bloc.dart';
import 'package:blocprovider/service/auth/bloc/auth_events.dart';
import 'package:blocprovider/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailScreen extends StatefulWidget {
  static const String routeName = '/verifyEmail';

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Column(children: [
        const Text(
            'We have sent email verification. Please open it to verify your account'),
        const Text(
            'If you have not received  a verification email yet, press the button'),
        TextButton(
          onPressed: () {
            context
                .read<AuthBloc>()
                .add(const AuthEventSendEMailVerification());
          },
          child: const Text(
            'Send Email Verification',
            style: TextStyle(color: blackColor),
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<AuthBloc>().add(const AuthEventLogOut());
          },
          child: const Text('ReStart'),
        )
      ]),
    );
  }
}
