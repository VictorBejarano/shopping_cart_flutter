import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/features/product/infrastructure/request/product_bloc.dart';
import 'package:shopping_cart/features/product/infrastructure/request/product_event.dart';
import 'package:shopping_cart/features/product/infrastructure/request/product_state.dart';
import 'package:shopping_cart/ui/pages/product_creator/product_creator_page.dart';
import 'package:shopping_cart/ui/pages/widgets/widgets.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) => {
        if (state is Loaded) {log(state.products.toString())}
      },
      child: Scaffold(
          drawer: ShoppingDrawer(),
          appBar: AppBar(
            title: Text('Material App Bar'),
          ),
          body: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is Loaded) {
                return ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return Text('Prueba');
                    });
              }
              return SizedBox.shrink();
            },
          )),
    );
  }
}
