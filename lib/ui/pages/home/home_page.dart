import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/features/cart/infrastructure/product/bloc.dart'
    as cart_bloc;
import 'package:shopping_cart/features/product/infrastructure/product/bloc.dart';
import 'package:shopping_cart/ui/styles/styles.dart';
import 'package:shopping_cart/ui/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  static const String NAME = 'home';
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(GetAllProductsEvent());
    BlocProvider.of<cart_bloc.CartBloc>(context)
        .add(cart_bloc.CreateCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: ShoppingDrawer(
          quantity: quantityProducts(),
        ),
        appBar: AppBar(
          centerTitle: false,
          title: Text('Productos'),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is Loaded) {
              final cartState =
                  context.watch<cart_bloc.CartBloc>().state as cart_bloc.Loaded;
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
                            FadeInImage(
                              image:
                                  NetworkImage(state.products[index].photoUrl),
                              placeholder:
                                  AssetImage('assets/image/jar-loading.gif'),
                              fadeInDuration: Duration(milliseconds: 200),
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
                                    'Descripci??n:',
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
                                  onPressed: (cartState.products
                                          .where((item) =>
                                              item.product ==
                                              state.products[index])
                                          .isEmpty)
                                      ? () {
                                          BlocProvider.of<cart_bloc.CartBloc>(
                                                  context)
                                              .add(cart_bloc
                                                  .AddProductToCartEvent(
                                                      product: state
                                                          .products[index]));
                                          log(context
                                              .read<cart_bloc.CartBloc>()
                                              .state
                                              .toString());
                                        }
                                      : null,
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
        ));
  }

  int quantityProducts() {
    final state = context.watch<cart_bloc.CartBloc>().state;
    if (state is cart_bloc.Loaded) {
      return state.products.length;
    } else {
      return 0;
    }
  }
}
