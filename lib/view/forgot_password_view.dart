import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/services/auth/bloc/auth.state.dart';
import 'package:notes/services/auth/bloc/auth_bloc.dart';
import 'package:notes/services/auth/bloc/auth_event.dart';
import 'package:notes/utilities/dialogs/error_dialog.dart';
import 'package:notes/utilities/dialogs/password_reset_email_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null) {
            // ignore: use_build_context_synchronously
            await showErrorDialog(context,
                "We could not process request at this time Try again later.");
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 149, 179, 244),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Forgot",
                style: GoogleFonts.robotoSlab(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Password?",
                style: GoogleFonts.robotoSlab(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              if (!isKeyboard)
                SvgPicture.asset(
                  "assets/images/forgotPassword.svg",
                  height: 300,
                  width: 300,
                ),
              const SizedBox(height: 16),
              Text(
                  "If you forgot your password, enter your email and we will send you a password reset link.",
                  style: GoogleFonts.robotoSlab(
                      fontSize: 17,
                      color: const Color.fromARGB(255, 36, 36, 36))),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autofocus: true,
                controller: _controller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.alternate_email_rounded),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  contentPadding: const EdgeInsets.all(20.0),
                  fillColor: Colors.white,
                  hintText: "Enter email",
                  filled: true,
                  focusColor: Colors.deepPurpleAccent.shade200,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(327, 50),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        shadowColor: const Color.fromARGB(255, 179, 200, 247),
                        elevation: 10,
                        backgroundColor: Colors.deepPurpleAccent.shade200),
                    onPressed: () {
                      final email = _controller.text;
                      context.read<AuthBloc>().add(
                            AuthEventForgotPassword(email: email),
                          );
                    },
                    child: Text("Send Link",
                        style: GoogleFonts.robotoSlab(
                            fontSize: 20, fontWeight: FontWeight.normal))),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(327, 50),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        shadowColor: const Color.fromARGB(255, 179, 200, 247),
                        elevation: 10,
                        backgroundColor: Colors.deepPurpleAccent.shade200),
                    onPressed: () {
                      context.read<AuthBloc>().add(const AuthEventLogOut());
                    },
                    child: Text("Back to login",
                        style: GoogleFonts.robotoSlab(
                            fontSize: 20, fontWeight: FontWeight.normal))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
