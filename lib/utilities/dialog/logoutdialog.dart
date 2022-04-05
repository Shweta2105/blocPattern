import 'package:blocprovider/extensions/buildcontext/loc.dart';

import 'generic_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog<bool>(
      context: context,
      title: context.loc.logout_button,
      content: context.loc.logout_dialog_prompt,
      optionBuider: () => {
            context.loc.cancel: false,
            context.loc.logout_button: true,
          }).then((value) => value ?? false);
}
