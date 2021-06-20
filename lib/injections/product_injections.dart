import 'package:shopping_cart/features/product/data/datasources/product_data_source.dart';
import 'package:shopping_cart/features/product/data/repositories/product_repository_impl.dart';
import 'package:shopping_cart/features/product/domain/repositories/product_repositoy.dart';
import 'package:shopping_cart/features/product/domain/usecase/get_all_products.dart';
import 'package:shopping_cart/features/product/infrastructure/product/product_bloc.dart';
import 'package:shopping_cart/features/product/infrastructure/product_manager/product_manager_bloc.dart';
import 'package:shopping_cart/injections/injections.dart';

Future<void> productDI() async {
  // Bloc
  sl.registerFactory<ProductBloc>(() => ProductBloc(allProducts: sl()));
  sl.registerFactory<ProductManagerBloc>(() => ProductManagerBloc());

  // Use cases
  sl.registerLazySingleton<GetAllProducts>(() => GetAllProducts(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () {
      return ProductRepositoryImpl(productDataSource: sl());
    },
  );
  // Data sources
  sl.registerLazySingleton<ProductDataSource>(
    () => ProductDataSourceImpl(firebase: sl()),
  );
}
