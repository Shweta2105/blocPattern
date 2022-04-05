import 'package:blocprovider/extensions/buildcontext/loc.dart';

import 'generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: context.loc.generic_error_prompt,
    content: text,
    optionBuider: () => {context.loc.ok: null},
  );
}
