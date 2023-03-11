import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      appBar: AppBar(
        title: const Text("Verify Email"),
      ),
      body: Column(
        children: [
          const Text("We've sent a verification email."),
          const Text("If you haven't recieve verifcation? try to resend"),
          TextButton(
            onPressed: () {
              context
                  .read<AuthBloc>()
                  .add(const AuthEventSendEmailVerification());
            },
            child: const Text("Resend Email"),
          ),
          TextButton(
              onPressed: () async {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
              child: const Text("Restart"))
        ],
      ),
    );
  }
}
