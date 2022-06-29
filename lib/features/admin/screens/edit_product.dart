import 'package:b2b/constants/global_variables.dart';
import 'package:b2b/features/admin/screens/product_screen.dart';

import 'package:b2b/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../../../constants/error_handling.dart';
import '../../../models/product.dart';
import '../services/admin_services.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = "/edit-product";
  final Product product;
  const EditProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final AdminService adminService = AdminService();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productCategoryController =
      TextEditingController();
  final TextEditingController productQuantityController =
      TextEditingController();

  final _editProductFormKey = GlobalKey<FormState>();
  final AdminService adminServices = AdminService();

  @override
  void initState() {
    productNameController.text = widget.product.name;
    productPriceController.text = widget.product.price.toString();
    productQuantityController.text = widget.product.quantity.toString();
    productCategoryController.text = widget.product.category;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    productQuantityController.dispose();
    productCategoryController.dispose();
    productPriceController.dispose();
  }

  void editProduct() {
    if (_editProductFormKey.currentState!.validate()) {
      adminService.editProduct(
          context: context,
          id: widget.product.id!,
          name: productNameController.text,
          price: double.parse(productPriceController.text),
          quantity: double.parse(productQuantityController.text),
          category: productCategoryController.text,
          onSuccess: () {
            showSnackBar(context, 'Product Updated Succesfully ');
            Navigator.popAndPushNamed(context, ProductScreen.routeName);
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
          'Edit Product',
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
            key: _editProductFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: productNameController,
                    hintText: 'Product Name',
                    label: 'Product Name',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: productPriceController,
                    hintText: 'Product Price',
                    label: 'Product Price',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: productQuantityController,
                    hintText: 'Product Quantity',
                    label: 'Product Quantity',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: productCategoryController,
                    hintText: 'Product Category',
                    label: 'Product Category',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () {
                      editProduct();
                    },
                    minWidth: double.infinity,
                    height: 60,
                    color: active,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(color: Colors.blue, width: 1)),
                    child: const Text(
                      "Save Product",
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
