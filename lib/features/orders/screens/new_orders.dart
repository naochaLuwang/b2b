import 'package:b2b/constants/global_variables.dart';
import 'package:b2b/features/orders/widgets/cart_subtotal.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../address/screens/address_screen.dart';
import '../widgets/cart_product.dart';

class NewOrder extends StatefulWidget {
  static const String routeName = "/new-order";
  const NewOrder({Key? key}) : super(key: key);

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  void navigateToAddress(int sum) {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: sum.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();

    return Scaffold(
        backgroundColor: light,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: light,
            title: Text('Create New Order',
                style: TextStyle(color: active, fontSize: 20)),
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios,
                    color: Colors.black, size: 20))),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                'No of items: ${user.cart.length}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Mulish',
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: const [
                  Text('Sl No.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Mulish')),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Name',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Mulish')),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Price',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Mulish')),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Qty.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Mulish')),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Amnt.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Mulish')),
                ],
              ),
              const SizedBox(height: 5),
              Container(
                height: 3,
                width: MediaQuery.of(context).size.width - 60,
                color: Colors.black54,
              ),
              const SizedBox(height: 10),
              ListView.builder(
                  itemCount: user.cart.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CartProduct(
                      index: index,
                    );
                  }),
              const SizedBox(height: 30),
              const CartSubtotal(),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () {
                  navigateToAddress(sum);
                },
                minWidth: double.infinity,
                height: 60,
                color: active,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: light, width: 1)),
                child: const Text(
                  "Create Order",
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
        ));
  }
}
