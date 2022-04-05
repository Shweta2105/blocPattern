import 'package:blocprovider/extensions/buildcontext/loc.dart';
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
        title: Text(context.loc.verify_email),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            context.loc.verify_email_view_prompt,
          ),
        ),
        TextButton(
          onPressed: () {
            context
                .read<AuthBloc>()
                .add(const AuthEventSendEMailVerification());
          },
          child: Text(
            context.loc.verify_email_send_email_verification,
            style: TextStyle(color: blackColor),
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<AuthBloc>().add(const AuthEventLogOut());
          },
          child: Text(context.loc.restart),
        )
      ]),
    );
  }
}
