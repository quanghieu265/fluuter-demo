import 'package:demo1/notifier/authenicate_notifer.dart';
import 'package:demo1/provider/counter.dart';
import 'package:demo1/services/auth_service.dart';
import 'package:demo1/widgets/input_custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  String _emailValue = "";
  String _passwordValue = "";

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> login(BuildContext context) async {
      try {
        if (_emailValue.isEmpty || _passwordValue.isEmpty) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'Oke',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
              backgroundColor: Colors.white,
              title: const Text("Vui lòng nhập Email và Password"),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
          );
          return;
        }
        final UserCredential credential =
            await _auth.handleLogin(_emailValue, _passwordValue);

        final name = credential.user!.displayName;
        final emailAddress = credential.user!.email;
        final uuid = credential.user!.uid;
        ref
            .read(authenticateNotifier.notifier)
            .handleSetUser(name, emailAddress, uuid);
        ref.read(routerProvider.notifier).state = 0;
      } catch (e) {
        if (!context.mounted) {
          return;
        }
        ;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Oke',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            backgroundColor: Colors.white,
            title: Text(e.toString()),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
        );
      }
      return;
    }

    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.message),
        const SizedBox(
          height: 16,
        ),
        const Text("Welcome back"),
        const SizedBox(
          height: 16,
        ),
        InputCustom(
            placeholder: "Email",
            hideText: false,
            onChanged: (value) => {_emailValue = value}),
        const SizedBox(
          height: 16,
        ),
        InputCustom(
            placeholder: "Password",
            hideText: true,
            onChanged: (value) => {_passwordValue = value}),
        const SizedBox(
          height: 16,
        ),
        FilledButton.tonal(
          onPressed: () {
            login(context);
          },
          child: const Text("Login"),
        ),
        const SizedBox(
          height: 16,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Not a member? "),
            Text(
              "Register now",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline),
            )
          ],
        )
      ]),
    );
  }
}
