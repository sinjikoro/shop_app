import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_priceFocusNode),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_descriptionFocusNode),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
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
                    decoration: const InputDecoration(labelText: 'Image URL'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlControler,
                    onEditingComplete: () {},
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
