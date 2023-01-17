import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/product_grid.dart';

enum FilterOptions{
  favorite,
  all,
}

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('shop app'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == FilterOptions.favorite) {products.showFavoriteOnly();}
              else {products.showAll();}
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(value: FilterOptions.favorite, child: Text('Only Favorites'),),
              const PopupMenuItem(value: FilterOptions.all, child: Text('Show All'),),
            ],
          ),
        ],
      ),
      body: const ProductGrid(),
    );
  }
}
