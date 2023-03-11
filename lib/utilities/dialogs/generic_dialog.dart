import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();
Future<T?> showGenericDialog<T>(
    {required BuildContext context,
    required String title,
    required String content,
    required DialogOptionBuilder optionsBuilder}) {
  final options = optionsBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style:
              GoogleFonts.robotoSlab(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        content: Text(content, style: GoogleFonts.robotoSlab(fontSize: 17)),
        actions: options.keys.map((optionTitle) {
          final value = options[optionTitle];
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent.shade200,
            ),
            onPressed: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(
              optionTitle,
              style: GoogleFonts.robotoSlab(fontSize: 15),
            ),
          );
        }).toList(),
      );
    },
  );
}
