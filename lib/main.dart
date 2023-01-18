import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';

import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

import './providers/products.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      fontFamily: 'Lato',
      );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Products(),),
        ChangeNotifierProvider(create: (_) => Cart(),)
      ],
      child: MaterialApp(
          title: 'MyShop',
          theme: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: Colors.purple,
              secondary: Colors.orange,
              ),
          ),
          routes: {
            ProductDetailScreen.routeName:(context) => const ProductDetailScreen(),
            CartScreen.routeName:(context) => const CartScreen(),
          },
          home: const ProductsOverviewScreen(),
      )
    );
  }
}
