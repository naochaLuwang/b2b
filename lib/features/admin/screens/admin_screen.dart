import 'package:b2b/features/admin/screens/out_of_stock.dart';
import 'package:b2b/features/admin/screens/product_screen.dart';
import 'package:b2b/features/admin/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/custom_text.dart';
import '../../account/services/account_services.dart';
import '../../dashboard/widgets/buttons.dart';
import '../../dashboard/widgets/overviewcards.dart';
import 'order_screen.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = "/dashboard";
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: light,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
                width: screenSize.width,
                height: screenSize.height * 0.11,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hello',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Mulish'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              user.name,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                  fontFamily: 'Mulish'),
                            )
                          ]),
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                        radius: 40,
                      )
                    ],
                  )
                ]),
              ),
              Expanded(
                child: ListView(children: [
                  const Text("Today's Status",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  const OverviewCardsSmallScreen(),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: lightGrey, width: .5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: "To do",
                          size: 24,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, UserScreen.routeName);
                              },
                              child: const Buttons(
                                icon: Icon(Icons.add),
                                text: "Add",
                                second: "Customer",
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ProductScreen.routeName);
                              },
                              child: const Buttons(
                                icon: Icon(Icons.add),
                                text: "Add",
                                second: "Products",
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, OrderScreen.routeName);
                              },
                              child: const Buttons(
                                icon: Icon(Icons.folder),
                                text: "View",
                                second: "Orders",
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, OutOfStockScreen.routeName);
                              },
                              child: const Buttons(
                                icon: Icon(Icons.list_alt),
                                text: "Out",
                                second: "Of Stock",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                AccountServices().logOut(context);
                              },
                              child: const Buttons(
                                icon: Icon(Icons.logout),
                                text: "Log Out",
                                second: "",
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ]),
              )
            ],
          ),
        )));
  }
}
