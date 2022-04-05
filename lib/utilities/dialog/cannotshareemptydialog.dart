import 'package:blocprovider/extensions/buildcontext/loc.dart';
import 'package:blocprovider/utilities/dialog/generic_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<void> showCannotShareEmptyDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: context.loc.sharing,
      content: context.loc.cannot_share_empty_note_prompt,
      optionBuider: () => {
            context.loc.ok: null,
          });
}
