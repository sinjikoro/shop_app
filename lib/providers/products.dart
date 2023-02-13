import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';
import 'dart:convert';

import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  String _authToken = '';
  set authToken(token) => _authToken = token;

  fetchAndSetProducts() async {
    final url =
        'https://shop-app-shinnaga-default-rtdb.firebaseio.com/product.json?auth=$_authToken';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> appProduct(Product product) async {
    try {
      const url =
          'https://shop-app-shinnaga-default-rtdb.firebaseio.com/product.json';
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
          },
        ),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) {
    final index = _items.indexWhere((product) => product.id == id);
    if (index >= 0) {
      final url =
          'https://shop-app-shinnaga-default-rtdb.firebaseio.com/product/$id.json';
      http.patch(
        Uri.parse(url),
        body: json.encode(
          {
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          },
        ),
      );
      _items[index] = newProduct;
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://shop-app-shinnaga-default-rtdb.firebaseio.com/product/$id.json';
    final existingProductionIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductionIndex];
    _items.removeAt(existingProductionIndex);
    notifyListeners();

    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(existingProductionIndex, existingProduct);
      notifyListeners();
      throw const HttpException('Could not delete product.');
    }
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
