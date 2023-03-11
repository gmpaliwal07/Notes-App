import 'package:flutter/material.dart';
import 'package:notes/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password Reset',
    content: 'We have sent Password Reset Link on your email.',
    optionsBuilder: () => {'OK': null},
  );
}
