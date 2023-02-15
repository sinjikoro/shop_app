import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helpers/custom_route.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/order_screen.dart';

import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/screens/splash_screen.dart';
import 'package:shop_app/screens/user_product_screen.dart';

import './providers/products.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      fontFamily: 'Lato',
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CustomPageTransitionBuilder(),
          TargetPlatform.iOS: CustomPageTransitionBuilder(),
        },
      ),
    );
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (_) => Products(),
            update: (_, auth, prod) => prod!
              ..authToken = auth.token
              ..userId = auth.userId,
          ),
          // builder: (context, auth, previousProducts) =>
          //     Products(userToken)),
          ChangeNotifierProvider(create: (_) => Cart()),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (_) => Orders(),
            update: (context, auth, order) => order!
              ..authToken = auth.token
              ..userId = auth.userId,
          ),
        ],
        child: Consumer<Auth>(
          builder: ((context, auth, _) => MaterialApp(
                title: 'MyShop',
                theme: theme.copyWith(
                  colorScheme: theme.colorScheme.copyWith(
                    primary: Colors.purple,
                    secondary: Colors.orange,
                  ),
                ),
                routes: {
                  ProductDetailScreen.routeName: (context) =>
                      const ProductDetailScreen(),
                  CartScreen.routeName: (context) => const CartScreen(),
                  OrderScreen.routeName: (context) => const OrderScreen(),
                  UserProductScreen.routeName: (context) =>
                      const UserProductScreen(),
                  EditProductScreen.routeName: (context) =>
                      const EditProductScreen(),
                },
                home: auth.isAuth
                    ? const ProductsOverviewScreen()
                    : FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: ((context, autoResultSnapshot) =>
                            autoResultSnapshot.connectionState ==
                                    ConnectionState.waiting
                                ? const SplashScreen()
                                : const AuthScreen()),
                      ),
              )),
        ));
  }
}
