import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart.')),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Text('Total', style: TextStyle(fontSize: 20),),
              const SizedBox(width: 20,),
              const Spacer(),
              Chip(
                label: Text(cart.totalAmount.toString(), style: TextStyle(color: Theme.of(context).primaryTextTheme.titleMedium?.color),),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)),
                child: const Text('ORDER NOW'),
              ),
            ]),
          ),
        )
      ]),
    );
  }
}