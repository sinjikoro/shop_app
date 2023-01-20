import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return 
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () => product.toggleFavoriteStatus(),
              color: Theme.of(context).colorScheme.secondary,
              ),
            title: Text(product.title, textAlign: TextAlign.center,),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => cart.addItem(product.id, product.price, product.title),
              color: Theme.of(context).colorScheme.secondary,),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id);
            },
            child: Image.network(product.imageUrl, fit: BoxFit.cover,)
            ),
          ),
      );
  }
}