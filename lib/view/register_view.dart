import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:notes/services/auth/auth_exceptions.dart';

import 'package:notes/services/auth/bloc/auth.state.dart';
import 'package:notes/services/auth/bloc/auth_bloc.dart';
import 'package:notes/services/auth/bloc/auth_event.dart';
import 'package:notes/utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool isPasswordVisible = true;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistring) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(context, 'Weak Password');
          } else if (state.exception is EmailAlreadyUseAuthException) {
            await showErrorDialog(context, 'Email is Already in Use');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, "Invalid Email");
          } else if (state.exception is NetworkRequestFailAuthException) {
            await showErrorDialog(context, 'Connect to Internet');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(
              context,
              "Failed to Register",
            );
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
                "Sign Up",
                style: GoogleFonts.robotoSlab(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 9),
              Text(
                "Let's create a new account . . .",
                style: GoogleFonts.robotoSlab(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 16),
              if (!isKeyboard)
                SvgPicture.asset(
                  "assets/images/authScreen.svg",
                  height: 300,
                  width: 300,
                ),
              const SizedBox(height: 16),
              TextField(
                controller: _email,
                enableSuggestions: false,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.alternate_email_sharp),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  contentPadding: const EdgeInsets.all(20.0),
                  fillColor: Colors.white,
                  hintText: "Enter email",
                  filled: true,
                  focusColor: Colors.deepPurpleAccent.shade200,
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: isPasswordVisible,
                enableSuggestions: false,
                autocorrect: false,
                controller: _password,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    hintText: "Enter Password",
                    prefixIcon: const Icon(Icons.lock_rounded),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(
                              () => isPasswordVisible = !isPasswordVisible);
                        },
                        icon: isPasswordVisible
                            ? const Icon(Icons.visibility_off_rounded)
                            : const Icon(Icons.visibility_rounded)),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    fillColor: Colors.white,
                    filled: true),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(327, 50),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          shadowColor: const Color.fromARGB(255, 179, 200, 247),
                          elevation: 10,
                          backgroundColor: Colors.deepPurpleAccent.shade200),
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;
                        context.read<AuthBloc>().add(AuthEventRegister(
                              email,
                              password,
                            ));
                      },
                      child: Text(
                        'Register',
                        style: GoogleFonts.robotoSlab(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(327, 50),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            shadowColor:
                                const Color.fromARGB(255, 179, 200, 247),
                            elevation: 10,
                            backgroundColor: Colors.deepPurpleAccent.shade200),
                        onPressed: () {
                          context.read<AuthBloc>().add(const AuthEventLogOut());
                        },
                        child: Text(
                          "Back to Login",
                          style: GoogleFonts.robotoSlab(
                              fontSize: 20, fontWeight: FontWeight.normal),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
