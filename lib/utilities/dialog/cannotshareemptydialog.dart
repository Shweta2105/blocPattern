import 'package:blocprovider/utilities/dialog/generic_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<void> showCannotShareEmptyDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: 'Sharing',
      content: 'You cannot share empty note..!',
      optionBuider: () => {
            'OK': null,
          });
}
