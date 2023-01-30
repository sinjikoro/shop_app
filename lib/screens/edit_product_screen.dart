import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = 'edit-product';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlControler = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: null, title: '', description: '', price: 0, imageUrl: '');

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlControler.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _form.currentState?.save();
    debugPrint(_editedProduct.title);
    debugPrint(_editedProduct.description);
    debugPrint(_editedProduct.price.toString());
    debugPrint(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_priceFocusNode),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please provide a value.' : null,
                  onSaved: (newValue) => _editedProduct = Product(
                      id: null,
                      title: newValue ?? '',
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) => FocusScope.of(context)
                      .requestFocus(_descriptionFocusNode),
                  onSaved: (newValue) => _editedProduct = Product(
                      id: null,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: double.parse(newValue ?? '0.0'),
                      imageUrl: _editedProduct.imageUrl),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  onSaved: (newValue) => _editedProduct = Product(
                      id: null,
                      title: _editedProduct.title,
                      description: newValue ?? '',
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      )),
                      child: _imageUrlControler.text.isEmpty
                          ? const Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlControler.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlControler,
                        onFieldSubmitted: (_) => _saveForm(),
                        onSaved: (newValue) => _editedProduct = Product(
                            id: null,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: newValue ?? ''),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
