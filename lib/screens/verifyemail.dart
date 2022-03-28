import 'package:blocprovider/service/auth/auth_service.dart';
import 'package:blocprovider/utilities/constants.dart';
import 'package:flutter/material.dart';

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
          onPressed: () async {
            await AuthService.firebase().sendEmailVerification();
          },
          child: const Text('Send Email Verification',style: TextStyle(color: blackColor),),
        ),
      ]),
    );
  }
}
