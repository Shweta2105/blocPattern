import 'package:blocprovider/extensions/buildcontext/loc.dart';
import 'package:blocprovider/utilities/dialog/generic_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: context.loc.password_reset,
    content: context.loc.password_reset_dialog_prompt,
    optionBuider: () => {context.loc.ok: null},
  );
}
