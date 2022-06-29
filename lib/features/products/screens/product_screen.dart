import 'package:b2b/features/orders/screens/new_orders.dart';
import 'package:b2b/features/products/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/custom_text.dart';

import '../../search/screens/search_screen.dart';
import '../services/product_service.dart';
import '../screens/product_details.dart';
import 'package:badges/badges.dart';

class Products extends StatefulWidget {
  static const String routeName = "/product";

  const Products({
    Key? key,
  }) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<Product>? products;
  final ProductService productService = ProductService();

  @override
  void initState() {
    super.initState();

    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await productService.fetchAllProducts(context);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  // void addToCart() {
  //   productService.addToCart(
  //     context: context,
  //     product: widget.product,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
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
                            enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                borderSide:
                                    BorderSide(color: active, width: 1)),
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Products',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.black)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: const [
                  Text('Name',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Mulish')),
                  SizedBox(width: 25),
                  Text('Price',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Mulish')),
                  SizedBox(width: 25),
                  Text('Quantity',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Mulish')),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CustomText(
                                        text: productData.name,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 25),
                                      CustomText(
                                        text: 'Rs. ${productData.price}',
                                        size: 20,
                                      ),
                                      const SizedBox(width: 20),
                                      CustomText(
                                        text: productData.category,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: active.withOpacity(.7),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.pushNamed(context,
                                                  ProductDetailScreen.routeName,
                                                  arguments: productData);
                                            },
                                            icon: Icon(
                                              Icons.add_outlined,
                                              size: 20,
                                              color: light,
                                            )),
                                      )
                                    ],
                                  ),
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
          onPressed: () {
            Navigator.pushNamed(
              context,
              NewOrder.routeName,
            );
          },
          child: Badge(
            badgeContent: Text(user.cart.length.toString()),
            badgeColor: Colors.white,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 30,
              color: light,
            ),
          )),
    );
  }
}
