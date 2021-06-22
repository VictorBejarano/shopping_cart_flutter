import 'package:flutter/material.dart';
import 'package:shopping_cart/ui/pages/cart/cart_page.dart';
import 'package:shopping_cart/ui/pages/home/home_page.dart';
import 'package:shopping_cart/ui/pages/product_creator/product_creator_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/${HomePage.NAME}': (_) => HomePage(),
  '/${ProductCreatorPage.NAME}': (_) => ProductCreatorPage(),
  '/${CartPage.NAME}': (_) => CartPage(),
};
