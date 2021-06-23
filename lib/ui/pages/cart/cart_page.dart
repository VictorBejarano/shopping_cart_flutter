import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/features/cart/infrastructure/product/bloc.dart';
import 'package:shopping_cart/ui/styles/styles.dart';
import 'package:shopping_cart/ui/widgets/widgets.dart';

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
      floatingActionButton: StadiumButton(
        enabled:
            (context.watch<CartBloc>().state as Loaded).products.isNotEmpty,
        text: 'Comprar',
        width: 100,
        onPressed: () {},
      ),
      appBar: AppBar(
        title: Text('Carrito de compras'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is Loaded) {
            if (state.products.isNotEmpty) {
              return ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  state.products[index].product.photoUrl,
                                  width: 100,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.products[index].product.name,
                                      style: styleTitle(),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'SKU:',
                                      style: styleSubtitle(),
                                    ),
                                    Text(
                                      state.products[index].product.sku,
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
                                      state.products[index].product.description,
                                      style: styleText(),
                                    ),
                                    Text(
                                      'Cantidad:',
                                      style: styleSubtitle(),
                                    ),
                                    Text(
                                      state.products[index].quantity.toString(),
                                      style: styleText(),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: 80,
                                    child: TextField(
                                      onChanged: (value) {
                                        if (value != '') {
                                          BlocProvider.of<CartBloc>(context)
                                              .add(SetQuantityProductEvent(
                                                  index: index,
                                                  quantity: int.parse(value)));
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0)),
                                        labelText: 'Cantidad',
                                      ),
                                    )),
                                TextButton(
                                  onPressed: () {
                                    BlocProvider.of<CartBloc>(context)
                                        .add(DeleteProductEvent(index: index));
                                  },
                                  child: Text('Eliminar'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text('Carrito vacio'),
              );
            }
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
