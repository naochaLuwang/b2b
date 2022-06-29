import 'package:b2b/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../models/product.dart';
import '../../../widgets/custom_text.dart';

class OutOfStockScreen extends StatefulWidget {
  static const String routeName = "/out-of-stock";
  const OutOfStockScreen({Key? key}) : super(key: key);

  @override
  State<OutOfStockScreen> createState() => _OutOfStockScreenState();
}

class _OutOfStockScreenState extends State<OutOfStockScreen> {
  List<Product>? outOfStock;
  final AdminService adminService = AdminService();

  @override
  void initState() {
    super.initState();
    fetchOutOfStockProducts();
  }

  fetchOutOfStockProducts() async {
    outOfStock = await adminService.fetchOutOfStockProducts(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Out Of Stock Products',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                fontFamily: 'Mulish',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            outOfStock == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: outOfStock!.length,
                        itemBuilder: (BuildContext context, index) {
                          final productData = outOfStock![index];
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
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
                                        text:
                                            'Product Name : ${productData.name}',
                                        size: 20,
                                      ),
                                      const SizedBox(height: 8),
                                      CustomText(
                                        text:
                                            'Product Price : Rs. ${productData.price}',
                                        size: 20,
                                      ),
                                      const SizedBox(height: 8),
                                      CustomText(
                                        text:
                                            'Product Quantity : ${productData.quantity}',
                                        size: 20,
                                      ),
                                      const SizedBox(height: 8),
                                      CustomText(
                                        text:
                                            'Product Category : ${productData.category}',
                                        size: 20,
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  )),
                                  Column(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.edit,
                                            size: 30,
                                            color: active,
                                          )),
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
    );
  }
}
