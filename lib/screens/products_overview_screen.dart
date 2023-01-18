import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/widgets/badge.dart';
import '../widgets/product_grid.dart';

enum FilterOptions{
  favorite,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('shop app'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                if (value == FilterOptions.favorite) {
                  _showOnlyFavorite = true;
                } else {
                  _showOnlyFavorite = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(value: FilterOptions.favorite, child: Text('Only Favorites'),),
              const PopupMenuItem(value: FilterOptions.all, child: Text('Show All'),),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, chld)  => 
              Badge(
                value: cart.itemCount.toString(),
                child: chld!,
              ),
            child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  
                },
              ),
            ),
        ],
      ),
      body: ProductGrid(showOnlyFavorite: _showOnlyFavorite),
    );
  }
}
