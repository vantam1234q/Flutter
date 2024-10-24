import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_end/utilities/utilities.dart';
import 'package:flutter_end/widgets/app_bar.dart';
import 'package:flutter_end/widgets/divider.dart';
import 'package:flutter_end/widgets/info_dialog.dart';
import 'package:flutter_end/widgets/input.dart';
import 'package:flutter_end/widgets/primary_button.dart';
import 'package:flutter_end/widgets/progess_dialog.dart';
import 'package:flutter_end/widgets/teriarybuton.dart';

import '../../data/data_sources/remote/firebase/auth_service.dart';


class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _email = '';

  String? _password = '';

  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _hideKeyboard();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PrimaryAppBar(
          title: '',
          onBack: () {
            Navigator.of(context).pop();
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 64,
                  ),
                  const Text(
                    textAlign: TextAlign.center,
                    'Sign In',
                    style: TextStyle(
                      
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                 const Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  InputField(
                    initialValue: _email,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Enter your email",
                    maxLines: 1,
                    prefixIcon: const Icon(Icons.email),
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                 const Text(
                    'Password',
                    style: TextStyle(
                      color:Colors.black,
                      fontSize: 18,
                       fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  InputField(
                    hintText: "Enter your password",
                    initialValue: _password,
                    maxLines: 1,
                     prefixIcon: const Icon(Icons.lock),
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  PrimaryButton(
                    title: 'Login',
                    onTap: () async {
                      await _login();
                    },
                  ),
                  const SizedBox(height: 16),
                 const CustomDivider(),
                  const SizedBox(height: 16),
                  TertiaryButton(
                    title: 'Register',
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                      '/register',
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _login() async {
    log("Email: $_email, Password: $_password");
    final error = _checkCredentials(
      email: _email,
      password: _password,
    );
    if (!mounted) {
      return;
    }
    if (error != null) {
      _showErrorDialog(context: context, error: error);
    } else {
      try {
        showProgressDialog(context);
        await _authService.signIn(
          email: _email!,
          password: _password!,
        );
        if (!mounted) {
          return;
        }
        hideProgressDialog(context);
        _hideKeyboard();
        Navigator.of(context).pushNamedAndRemoveUntil(
         '/home',
          (route) => false,
        );
      } on FirebaseAuthException catch (error) {
        hideProgressDialog(context);
        _showErrorDialog(
          context: context,
          error: Utilities.cleanErrorMessage(error.message),
        );
      }
    }
  }

  void _hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  String? _checkCredentials({
    required String? email,
    required String? password,
  }) {
    if (email?.isEmpty ?? true) {
      return 'Email cannot be empty.';
    }
    if (!Utilities.isValidEmail(email!)) {
      return 'Invalid email format.';
    }
    if (password?.isEmpty ?? true) {
      return 'Password cannot be empty.';
    }
    if (!Utilities.isValidPassword(password!)) {
      return 'Invalid password format.';
    }

    return null;
  }

  void _showErrorDialog({
    required BuildContext context,
    required String error,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return InfoDialog(
          title: "Error",
          content: error,
          confirmButtonTitle: "OK",
          onConfirm: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
