import 'package:blocprovider/utilities/dialog/generic_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password reset',
    content:
        'We have sent you password reset link. Please check you email for more informaton',
    optionBuider: () => {'OK': null},
  );
}
