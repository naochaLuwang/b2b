import 'package:b2b/features/account/services/account_services.dart';
import 'package:b2b/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../models/order.dart';
import '../../../widgets/custom_text.dart';
import '../../order_details/screens/order_details_screen.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = "/orders";
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Dashboard.routeName);
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
                          // onFieldSubmitted: navigateToSearchScreen,
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
                              hintText: 'Search Orders',
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(
              //   height: 10,
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Orders',
                  style: TextStyle(
                      fontSize: 24,
                      color: active,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Mulish'),
                ),
              ),
              orders == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: orders!.length,
                          itemBuilder: (BuildContext context, index) {
                            final orderData = orders![index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  OrderDetailScreen.routeName,
                                  arguments: orderData,
                                );
                              },
                              child: Card(
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
                                            text: 'Order id : ${orderData.id}',
                                            size: 20,
                                          ),
                                          orderData.status >= 3
                                              ? const CustomText(
                                                  text:
                                                      'Order Status : Completed',
                                                  size: 20,
                                                  color: Colors.teal,
                                                )
                                              : const CustomText(
                                                  text:
                                                      'Order Status : Pending',
                                                  color: Colors.red,
                                                  size: 20,
                                                ),

                                          // const SizedBox(height: 8),
                                          // CustomText(
                                          //   text:
                                          //       'Product Price : Rs. ${productData.price}',
                                          //   size: 20,
                                          // ),
                                          // const SizedBox(height: 8),
                                          // CustomText(
                                          //   text:
                                          //       'Product Quantity : ${productData.quantity}',
                                          //   size: 20,
                                          // ),
                                          // const SizedBox(height: 8),
                                          // CustomText(
                                          //   text:
                                          //       'Product Category : ${productData.category}',
                                          //   size: 20,
                                          // ),
                                          const SizedBox(height: 8),
                                        ],
                                      )),
                                      // Column(
                                      //   children: [
                                      //     IconButton(
                                      //         onPressed: () {
                                      //           deleteProduct(productData, index);
                                      //         },
                                      //         icon: const Icon(
                                      //           Icons.delete,
                                      //           size: 40,
                                      //           color: Colors.red,
                                      //         ))
                                      //   ],
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
            ],
          ),
        )));
  }
}
