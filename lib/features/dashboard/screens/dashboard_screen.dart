import 'package:b2b/features/account/screens/account.dart';
import 'package:b2b/features/account/screens/change_password.dart';
import 'package:b2b/features/orders/screens/orders_screen.dart';
import 'package:b2b/features/products/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../models/order.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/custom_text.dart';
import '../../account/services/account_services.dart';
import '../widgets/buttons.dart';

class Dashboard extends StatefulWidget {
  static const String routeName = "/dashboard";
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Order>? orders;
  List<Order>? confirmedOrders;
  List<Order>? pendingOrders;

  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
    fetchConfirmedOrders();
    fetchPendingOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  void fetchConfirmedOrders() async {
    confirmedOrders =
        await accountServices.fetchConfirmedOrders(context: context);
    setState(() {});
  }

  void fetchPendingOrders() async {
    pendingOrders = await accountServices.fetchPendingOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final screenSize = MediaQuery.of(context).size;

    var isActive = true;

    double width = MediaQuery.of(context).size.width;
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
                              ),
                            ),
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
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
                  SizedBox(
                    height: 230,
                    child: Column(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: isActive ? active : lightGrey,
                                        width: .5)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: 'Pending Orders',
                                      size: 18,
                                      weight: FontWeight.w500,
                                      // ignore: dead_code
                                      color: isActive ? active : lightGrey,
                                    ),
                                    CustomText(
                                      text: pendingOrders != null
                                          ? pendingOrders?.length.toString()
                                          : '0',
                                      size: 18,
                                      weight: FontWeight.bold,
                                      // ignore: dead_code
                                      color: isActive ? active : lightGrey,
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          height: width / 64,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        // ignore: dead_code
                                        color: isActive ? active : lightGrey,
                                        width: .5)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: 'Confirmed Orders',
                                      size: 18,
                                      weight: FontWeight.w500,
                                      // ignore: dead_code
                                      color: isActive ? active : lightGrey,
                                    ),
                                    CustomText(
                                      text: confirmedOrders != null
                                          ? confirmedOrders?.length.toString()
                                          : '0',
                                      size: 18,
                                      weight: FontWeight.bold,
                                      // ignore: dead_code
                                      color: isActive ? active : lightGrey,
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          height: width / 64,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: isActive ? active : lightGrey,
                                        width: .5)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: 'Total Orders',
                                      size: 18,
                                      weight: FontWeight.w500,
                                      // ignore: dead_code
                                      color: isActive ? active : lightGrey,
                                    ),
                                    CustomText(
                                      text: orders != null
                                          ? orders?.length.toString()
                                          : '0',
                                      size: 18,
                                      weight: FontWeight.bold,
                                      // ignore: dead_code
                                      color: isActive ? active : lightGrey,
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                                    context, Products.routeName);
                              },
                              child: const Buttons(
                                icon: Icon(Icons.add),
                                text: "Create",
                                second: "Order",
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ChangePassword.routeName);
                              },
                              child: const Buttons(
                                icon: Icon(Icons.lock_reset_outlined),
                                text: "Change",
                                second: "Password",
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, OrdersScreen.routeName);
                              },
                              child: const Buttons(
                                icon: Icon(Icons.file_copy),
                                text: "View",
                                second: "Orders",
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AccountScreen.routeName);
                              },
                              child: const Buttons(
                                icon: Icon(Icons.account_box),
                                text: "View",
                                second: "Account",
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
