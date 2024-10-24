import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_end/data/data_sources/remote/firebase/auth_service.dart';
import 'package:flutter_end/widgets/app_bar.dart';
import 'package:flutter_end/widgets/divider.dart';
import 'package:flutter_end/widgets/info_dialog.dart';
import 'package:flutter_end/widgets/input.dart';
import 'package:flutter_end/widgets/primary_button.dart';
import 'package:flutter_end/widgets/progess_dialog.dart';
import 'package:flutter_end/widgets/teriarybuton.dart';
import '../../utilities/utilities.dart';
import '../login/login_screen.dart';


class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _email;

  String? _password;

  String? _confirmPassword;
  

  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _hideKeyboard();
      },
      child: Scaffold(
        backgroundColor:Colors.white,
        appBar: PrimaryAppBar(
          title: '',
          onBack: () {
            Navigator.of(context).pop();
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 64,
                  ),
                  const Text(
                    textAlign: TextAlign.center,
                    ' Register ',
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
                      fontSize: 16,
                       fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  InputField(
                    initialValue: _email,
                    hintText: "Enter your email",
                    maxLines: 1,
                    prefixIcon:  const Icon(Icons.email),
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
                      fontSize: 16,
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
                    prefixIcon:  const Icon(Icons.lock),
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
               const   Text(
                    'Confirm Password',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                       fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  InputField(

                    hintText: "Enter your password",
                    initialValue: _confirmPassword,
                    maxLines: 1,
                     prefixIcon:  const Icon(Icons.lock),
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        _confirmPassword = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  PrimaryButton(
                    title: 'Register',
                    onTap: () async {
                      await _register();
                    },
                  ),
                  const SizedBox(height: 16),
                const  CustomDivider(),
                  const SizedBox(height: 16),
                  TertiaryButton(
                    title: 'Login',
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                        LoginScreen.routeName,
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

 

  Future<void> _register() async {
    log("Email: $_email, Password: $_password, Confirm Password: $_confirmPassword");
    final error = _checkCredentials(
      email: _email,
      password: _password,
      confirmPassword: _confirmPassword,
    );
    if (!mounted) {
      return;
    }
    if (error != null) {
      _showErrorDialog(context: context, error: error);
    } else {
      try {
        showProgressDialog(context);
        await _authService.createUser(
          email: _email!,
          password: _password!,
        );
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
    required String? confirmPassword,
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

    if (confirmPassword?.isEmpty ?? true) {
      return 'Confirm password cannot be empty.';
    }

    if (password != confirmPassword) {
      return 'Password and confirm password do not match.';
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
