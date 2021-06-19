import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/features/product/data/datasources/product_data_source.dart';
import 'package:shopping_cart/features/product/data/repositories/product_repository_impl.dart';
import 'package:shopping_cart/features/product/domain/repositories/product_repositoy.dart';
import 'package:shopping_cart/features/product/domain/usecase/get_all_products.dart';
import 'package:shopping_cart/features/product/infrastructure/request/bloc.dart';
import 'package:shopping_cart/injections/injections.dart';

Future<void> productDI() async {
  // Bloc
  sl.registerFactory<ProductBloc>(() => ProductBloc(allProducts: sl()));

  // Use cases
  sl.registerLazySingleton<GetAllProducts>(() => GetAllProducts(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () {
      return ProductRepositoryImpl(productDataSource: sl(), networkInfo: sl());
    },
  );
  // Data sources
  sl.registerLazySingleton<ProductDataSource>(
    () => ProductDataSourceImpl(firebase: sl()),
  );
  //! Core
}
