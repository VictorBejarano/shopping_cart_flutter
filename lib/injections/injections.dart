import 'package:get_it/get_it.dart';
import 'package:shopping_cart/injections/file_injections.dart';
import 'package:shopping_cart/injections/product_injections.dart';

import 'cart_injections.dart';
import 'core_injections.dart';
import 'external_injections.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await coreDI();
  await externalDI();
  await productDI();
  await cartDI();
  await fileDI();
}
