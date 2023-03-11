import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef CloseDialog = void Function();
CloseDialog showLoadingDialog({
  required BuildContext context,
  required String text,
}) {
  final dialog = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(
          color: Colors.deepPurpleAccent.shade200,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(text,
            style: GoogleFonts.robotoSlab(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.deepPurpleAccent.shade200)),
      ],
    ),
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => dialog,
  );

  return () => Navigator.of(context).pop();
}
