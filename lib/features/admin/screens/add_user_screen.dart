import 'package:b2b/features/admin/screens/user_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../widgets/custom_text_field.dart';
import '../../auth/service/auth_service.dart';

class AddUserScreen extends StatefulWidget {
  static const String routeName = "/add-user";
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();
  final TextEditingController userCompanyNameController =
      TextEditingController();

  final _addUserFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    userEmailController.dispose();
    userPasswordController.dispose();
    userCompanyNameController.dispose();
  }

  void addUser() {
    if (_addUserFormKey.currentState!.validate()) {
      authService.signUpUser(
          context: context,
          email: userEmailController.text,
          password: userPasswordController.text,
          name: userNameController.text,
          companyName: userCompanyNameController.text,
          onSuccess: () {
            showSnackBar(context, 'User Succesfully Added');
            Navigator.popAndPushNamed(context, UserScreen.routeName);
            setState(() {});
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Add User',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: light,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios,
                size: 20, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _addUserFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: userNameController,
                    hintText: 'User Name',
                    label: 'User Name',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: userEmailController,
                    hintText: 'Email',
                    label: 'Email',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: userPasswordController,
                    hintText: 'Password',
                    label: 'Password',
                  ),
                  CustomTextField(
                    controller: userCompanyNameController,
                    hintText: 'Company Name',
                    label: 'Company Name',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () {
                      addUser();
                    },
                    minWidth: double.infinity,
                    height: 60,
                    color: active,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(color: Colors.blue, width: 1)),
                    child: const Text(
                      "Save User",
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
      ),
    );
  }
}
