import 'package:b2b/constants/global_variables.dart';
import 'package:b2b/features/admin/screens/add_product.dart';
import 'package:b2b/features/admin/screens/admin_screen.dart';
import 'package:b2b/features/admin/services/admin_services.dart';
import 'package:b2b/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../search/screens/search_screen.dart';
import 'edit_product.dart';

class ProductScreen extends StatefulWidget {
  static const String routeName = "/products";
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product>? products;
  final AdminService adminService = AdminService();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminService.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminService.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
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
                Navigator.popAndPushNamed(context, AdminScreen.routeName);
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
                        onFieldSubmitted: navigateToSearchScreen,
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
                            hintText: 'Search Products',
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
            const Text(
              'Products',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                fontFamily: 'Mulish',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            products == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: products!.length,
                        itemBuilder: (BuildContext context, index) {
                          final productData = products![index];
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
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                EditProductScreen.routeName,
                                                arguments: productData);
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            size: 30,
                                            color: active,
                                          )),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            deleteProduct(productData, index);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            size: 30,
                                            color: Colors.red,
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddProductScreen.routeName);
        },
      ),
    );
  }
}
