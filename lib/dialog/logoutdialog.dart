import 'package:blocprovider/dialog/generic_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog<bool>(
      context: context,
      title: 'Logout',
      content: 'Are you sure you want to Logout?',
      optionBuider: () => {
            'Cancel': false,
            'LogOut': true,
          }).then((value) => value ?? false);
}
