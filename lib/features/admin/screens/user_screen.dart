import 'package:b2b/features/auth/service/auth_service.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../models/user.dart';
import '../../../widgets/custom_text.dart';
import '../services/admin_services.dart';
import 'add_user_screen.dart';

class UserScreen extends StatefulWidget {
  static const String routeName = "/users";
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<User>? users;
  final AuthService authService = AuthService();
  final AdminService adminService = AdminService();

  @override
  void initState() {
    super.initState();
    getAllUsers();
  }

  getAllUsers() async {
    users = await authService.getAllUsers(context);
    setState(() {});
  }

  void deleteUser(User user, int index) {
    adminService.deleteUser(
      context: context,
      user: user,
      onSuccess: () {
        users!.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios,
                  size: 20, color: Colors.black),
            ),
            flexibleSpace: Container(
              color: light,
            ),
            title: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 42,
                    // margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(top: 10),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 1)),
                            hintText: 'Search Users',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            )),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            users == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: users!.length,
                        itemBuilder: (BuildContext context, index) {
                          final userData = users![index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      CustomText(
                                        text: 'User Name : ${userData.name}',
                                        size: 20,
                                      ),
                                      const SizedBox(height: 8),
                                      CustomText(
                                        text: 'Email : ${userData.email}',
                                        size: 20,
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  )),
                                  Column(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            deleteUser(userData, index);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            size: 40,
                                            color: Colors.red,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddUserScreen.routeName);
        },
      ),
    );
  }
}
