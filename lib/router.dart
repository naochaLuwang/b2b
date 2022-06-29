import 'package:b2b/features/account/screens/account.dart';
import 'package:b2b/features/admin/screens/order_screen.dart';
import 'package:b2b/features/admin/screens/out_of_stock.dart';
import 'package:b2b/features/admin/screens/user_screen.dart';
import 'package:b2b/features/auth/screens/auth_screen.dart';
import 'package:b2b/features/orders/screens/new_orders.dart';
import 'package:b2b/features/pdf/screens/pdf_screen.dart';
import 'package:b2b/features/products/screens/product_screen.dart';

import 'package:flutter/material.dart';

import 'features/account/screens/change_password.dart';
import 'features/address/screens/address_screen.dart';
import 'features/admin/screens/add_product.dart';
import 'features/admin/screens/add_user_screen.dart';
import 'features/admin/screens/edit_product.dart';
import 'features/admin/screens/product_screen.dart';
import 'features/dashboard/screens/dashboard_screen.dart';
import 'features/order_details/screens/order_details_screen.dart';
import 'features/orders/screens/orders_screen.dart';
import 'features/products/screens/product_details.dart';
import 'features/search/screens/search_screen.dart';
import 'models/order.dart';
import 'models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (context) => const AuthScreen());
    case Dashboard.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (context) => const Dashboard());
    case AccountScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (context) => const AccountScreen());
    case ProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (context) => const ProductScreen());
    case Products.routeName:
      // var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings, builder: (context) => const Products());
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
    case EditProductScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => EditProductScreen(
          product: product,
        ),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => const AddProductScreen());
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case NewOrder.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (context) => const NewOrder());
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );

    case OrderScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (context) => const OrderScreen());
    case OrdersScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (context) => const OrdersScreen());

    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );

    case UserScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (context) => const UserScreen());
    case AddUserScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (context) => const AddUserScreen());

    case ChangePassword.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => const ChangePassword());

    case OutOfStockScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => const OutOfStockScreen());

    case InvoicePage.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => InvoicePage(
                order: order,
              ));

    default:
      return MaterialPageRoute(
          builder: (context) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${routeSettings.name}'),
                ),
              ));
  }
}
