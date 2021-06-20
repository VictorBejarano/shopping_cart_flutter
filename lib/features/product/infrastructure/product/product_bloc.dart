import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_cart/core/usecases/usecases_stream.dart';
import 'package:shopping_cart/features/product/domain/usecase/get_all_products.dart';

import 'bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts getAllProducts;

  ProductBloc({@required GetAllProducts allProducts})
      : assert(allProducts != null),
        getAllProducts = allProducts,
        super(Empty());

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is GetAllProductsEvent) {
      yield Loading();
      yield* getAllProducts(NoParams()).map((either) => either.fold(
          (failure) => Error(message: 'Surgio un error inesperado'),
          (products) => Loaded(products: products)));
    }
  }
}
