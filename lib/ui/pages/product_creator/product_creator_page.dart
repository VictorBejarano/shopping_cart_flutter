import 'package:flutter/material.dart';
import 'package:shopping_cart/ui/pages/widgets/widgets.dart';

class ProductCreatorPage extends StatefulWidget {
  static const String NAME = 'product_creator';
  ProductCreatorPage({Key key}) : super(key: key);

  @override
  _ProductCreatorPageState createState() => _ProductCreatorPageState();
}

class _ProductCreatorPageState extends State<ProductCreatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Producto'),
      ),
      drawer: ShoppingDrawer(),
      body: Container(),
    );
  }
}
