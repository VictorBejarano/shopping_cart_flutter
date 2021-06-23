import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:shopping_cart/core/error/failures.dart';
import 'package:shopping_cart/features/cart/domain/entities/product_quantity.dart';
import 'package:shopping_cart/features/cart/domain/usecase/buy_products.dart';
import 'package:shopping_cart/features/cart/domain/usecase/create_cart.dart'
    as create_cart_usecase;

import 'bloc.dart';

//TODO: revisar
const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class CartBloc extends Bloc<CartEvent, CartState> {
  final create_cart_usecase.CreateCart createCart;
  final BuyProducts buyProducts;

  CartBloc(
      {@required create_cart_usecase.CreateCart cart,
      @required BuyProducts buy})
      : assert(cart != null),
        createCart = cart,
        buyProducts = buy,
        super(Empty());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is CreateCartEvent) {
      final date = DateTime.now().millisecondsSinceEpoch.toString();
      final failureOrSetState = await createCart(
          create_cart_usecase.Params(id: date, status: 'PENDIENTE'));
      yield* _eitherLoadedOrErrorState(failureOrSetState, date);
    } else if (event is AddProductToCartEvent) {
      final loadedState = state as Loaded;
      yield Loaded(id: loadedState.id, products: [
        ...loadedState.products,
        ProductQuantity(product: event.product, quantity: 1)
      ]);
    } else if (event is SetQuantityProductEvent) {
      final loadedState = state as Loaded;
      var products = [...loadedState.products];
      products[event.index] = ProductQuantity(
          product: products[event.index].product, quantity: event.quantity);
      yield Loaded(id: loadedState.id, products: [...products]);
    } else if (event is DeleteProductEvent) {
      final loadedState = state as Loaded;
      var products = loadedState.products
          .where((product) => product != loadedState.products[event.index]);
      yield Loaded(id: loadedState.id, products: [...products]);
    } else if (event is BuyEvent) {
      final loadedState = state as Loaded;
      final failureOrSetState = await buyProducts(
          Params(id: loadedState.id, products: loadedState.products));
      yield* _eitherLoadedOrErrorState(failureOrSetState, loadedState.id);
      final failureOrSetStateCart = await createCart(
          create_cart_usecase.Params(id: loadedState.id, status: 'COMPLETADO'));
      yield* _eitherLoadedOrErrorState(failureOrSetStateCart, loadedState.id);
      add(CreateCartEvent());
    }
  }

  Stream<CartState> _eitherLoadedOrErrorState(
      Either<Failure, void> failureOrSetState, String id) async* {
    yield failureOrSetState.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (right) => Loaded(id: id, products: []),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
