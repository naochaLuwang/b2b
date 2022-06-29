import 'package:b2b/constants/error_handling.dart';
import 'package:b2b/constants/global_variables.dart';
import 'package:b2b/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_text_field.dart';
import '../../auth/service/auth_service.dart';

class ChangePassword extends StatefulWidget {
  static const String routeName = "/change-password";
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _newPasswordFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void changePassword() {
    if (_newPasswordFormKey.currentState!.validate()) {
      authService.updatePassword(
          context: context,
          password: passwordController.text,
          onSuccess: () {
            showSnackBar(context, 'Password Updated Successfully');
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: light,
          title: const Text('Change Password',
              style: TextStyle(fontSize: 20, color: Colors.black54)),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, size: 20, color: lightGrey))),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Form(
                  key: _newPasswordFormKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          hintText: 'Enter new password',
                          label: 'Enter new password',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: confirmPasswordController,
                          hintText: 'Confirm new password',
                          label: 'Confirm new password',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          onPressed: () {
                            changePassword();
                            Navigator.pushNamed(context, Dashboard.routeName);
                          },
                          minWidth: double.infinity,
                          height: 60,
                          color: active,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(
                                  color: Colors.blue, width: 1)),
                          child: const Text(
                            "Update Password",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Mulish',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
