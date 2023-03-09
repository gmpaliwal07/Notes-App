import 'package:flutter/material.dart';
import 'package:notes/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) async {
  return showGenericDialog<void>(
    context: context,
    title: 'Sharing',
    content: "Can't Share an empty Note !!",
    optionsBuilder: () => {'OK': null},
  );
}
