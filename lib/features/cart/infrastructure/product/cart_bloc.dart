import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:shopping_cart/core/error/failures.dart';
import 'package:shopping_cart/features/cart/domain/usecase/create_cart.dart';

import 'bloc.dart';

//TODO: revisar
const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CreateCart createCart;

  CartBloc({@required CreateCart cart})
      : assert(cart != null),
        createCart = cart,
        super(Empty());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is CreateCartEvent) {
      final date = DateTime.now().millisecondsSinceEpoch.toString();
      final failureOrSetState =
          await createCart(Params(id: date, status: 'PENDIENTE'));
      yield* _eitherLoadedOrErrorState(failureOrSetState, date);
    } else if (event is AddProductToCartEvent) {
      final loadedState = state as Loaded;
      yield Loaded(
          id: loadedState.id,
          products: [...loadedState.products, event.product]);
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
