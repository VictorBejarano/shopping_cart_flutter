import 'package:shopping_cart/features/cart/data/datasources/cart_data_source.dart';
import 'package:shopping_cart/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:shopping_cart/features/cart/domain/repositories/cart_repositoy.dart';
import 'package:shopping_cart/features/cart/domain/usecase/buy_products.dart';
import 'package:shopping_cart/features/cart/domain/usecase/create_cart.dart';
import 'package:shopping_cart/features/cart/infrastructure/product/bloc.dart';
import 'package:shopping_cart/injections/injections.dart';

Future<void> cartDI() async {
  // Bloc
  sl.registerFactory<CartBloc>(() => CartBloc(cart: sl(), buy: sl()));

  // Use cases
  sl.registerLazySingleton<CreateCart>(() => CreateCart(sl()));
  sl.registerLazySingleton<BuyProducts>(() => BuyProducts(sl()));

  // Repository
  sl.registerLazySingleton<CartRepository>(
    () {
      return CartRepositoryImpl(cartDataSource: sl());
    },
  );
  // Data sources
  sl.registerLazySingleton<CartDataSource>(
    () => CartDataSourceImpl(firebase: sl()),
  );
}
