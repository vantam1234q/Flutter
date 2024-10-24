import 'package:flutter/material.dart';
import 'package:flutter_end/data/data_sources/remote/firebase/auth_service.dart';
import 'package:flutter_end/screens/start/start_screen.dart';
import 'package:flutter_end/widgets/app_bar.dart';
import 'package:flutter_end/widgets/confirm_dialog.dart';
import 'package:flutter_end/widgets/primary_button.dart';
import 'package:flutter_end/widgets/progess_dialog.dart';



class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PrimaryAppBar(
        title: 'Profile',
        
        onBack: () {
          Navigator.of(context).pop();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(),
              PrimaryButton(
                onTap: () async {
                  final isConfirmed = await _showLogoutConfirmationDialog(
                    context: context,
                  );
                  if (isConfirmed ?? false) {
                    await _logout();
                  }
                },
                title: 'Logout',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _logout() async {
    showProgressDialog(context);
    await AuthService().signOut();
    if (!mounted) {
      return;
    }
    hideProgressDialog(context);
    Navigator.of(context).pushNamedAndRemoveUntil(
      SplashScreen.routeName,
      (route) => false,
    );
  }

  Future<bool?> _showLogoutConfirmationDialog({
    required BuildContext context,
  }) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: 'Logout',
          content:
              'Are you sure you want to logout?',
          confirmButtonTitle: 'Logout',
          cancelButtonTitle: 'Cancel',
          onConfirm: () {
            Navigator.of(context).pop(true);
          },
          onCancel: () {
            Navigator.of(context).pop(false);
          },
        );
      },
    );
  }
}
