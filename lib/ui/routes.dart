import 'package:flutter/material.dart';
import 'package:shopping_cart/ui/pages/home/home_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomePage.NAME: (_) => HomePage(),
};
