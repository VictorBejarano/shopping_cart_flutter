import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/features/cart/infrastructure/product/bloc.dart';
import 'package:shopping_cart/ui/pages/styles/styles.dart';

class CartPage extends StatefulWidget {
  static const String NAME = 'cart';
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de compras'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is Loaded) {
            return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            state.products[index].name,
                            style: styleTitle(),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Image.network(
                            state.products[index].photoUrl,
                            fit: BoxFit.fitWidth,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SKU:',
                                  style: styleSubtitle(),
                                ),
                                Text(
                                  state.products[index].sku,
                                  style: styleText(),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'Descripción:',
                                  style: styleSubtitle(),
                                ),
                                Text(
                                  state.products[index].description,
                                  style: styleText(),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {},
                                child: Text('Agregar al carrito'),
                              ),
                              SizedBox(width: 8),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
