import 'package:shopping_cart/core/network/network_info.dart';
import 'package:shopping_cart/injections/injections.dart';

Future<void> coreDI() async {
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}
