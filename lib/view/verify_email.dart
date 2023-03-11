import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/services/auth/bloc/auth_bloc.dart';
import 'package:notes/services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 149, 179, 244),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Verify you Email",
              style: GoogleFonts.robotoSlab(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Center(
              child: SvgPicture.asset(
                "assets/images/verifyEmail.svg",
                height: 300,
                width: 300,
              ),
            ),
            const SizedBox(height: 16),
            Text("We've sent a verification email. Please Check your Email.",
                style: GoogleFonts.robotoSlab(
                    fontSize: 17,
                    color: const Color.fromARGB(255, 36, 36, 36))),
            const SizedBox(height: 16),
            Text(
                "If you haven't recieve verification link? try to resend email",
                style: GoogleFonts.robotoSlab(
                    fontSize: 17,
                    color: const Color.fromARGB(255, 36, 36, 36))),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(327, 50),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  shadowColor: const Color.fromARGB(255, 179, 200, 247),
                  elevation: 10,
                  backgroundColor: Colors.deepPurpleAccent.shade200),
              onPressed: () {
                context
                    .read<AuthBloc>()
                    .add(const AuthEventSendEmailVerification());
              },
              child: Text("Resend Email",
                  style: GoogleFonts.robotoSlab(
                      fontSize: 20, fontWeight: FontWeight.normal)),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(327, 50),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    shadowColor: const Color.fromARGB(255, 179, 200, 247),
                    elevation: 10,
                    backgroundColor: Colors.deepPurpleAccent.shade200),
                onPressed: () async {
                  context.read<AuthBloc>().add(const AuthEventLogOut());
                },
                child: Text("Back to Login",
                    style: GoogleFonts.robotoSlab(
                        fontSize: 20, fontWeight: FontWeight.normal)))
          ],
        ),
      ),
    );
  }
}
