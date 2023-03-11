import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        appBar: AppBar(
          title: const Text("Register"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Register with your Email",
                  style: TextStyle(fontSize: 20)),
              TextField(
                controller: _email,
                enableSuggestions: false,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: const InputDecoration(hintText: "Enter email"),
                autofocus: true,
              ),
              TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: _password,
                decoration: const InputDecoration(hintText: "Enter Password"),
                autofocus: true,
              ),
              Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;
                        context.read<AuthBloc>().add(AuthEventRegister(
                              email,
                              password,
                            ));
                      },
                      child: const Text('Register'),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(const AuthEventLogOut());
                        },
                        child: const Text("Login"))
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
