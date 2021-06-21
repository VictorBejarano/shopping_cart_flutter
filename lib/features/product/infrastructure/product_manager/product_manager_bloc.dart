import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:shopping_cart/core/error/failures.dart';
import 'package:shopping_cart/features/product/domain/usecase/create_product.dart';

import 'bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class ProductManagerBloc
    extends Bloc<ProductManagerEvent, ProductManagerState> {
  final CreateProduct createProduct;
  ProductManagerBloc({@required this.createProduct})
      : super(ProductManagerState());

  @override
  Stream<ProductManagerState> mapEventToState(
    ProductManagerEvent event,
  ) async* {
    if (event is SetImageToUploadEvent) {
      yield state.copyWith(uploadImage: event.uploadImage);
    } else if (event is CreateProductEvent) {
      final failureOrSetState = await createProduct(Params(
          name: event.name,
          sku: event.sku,
          photoUrl: event.photoUrl,
          description: event.description));
      yield* _eitherLoadedOrErrorState(failureOrSetState);
    }
  }

  Stream<ProductManagerState> _eitherLoadedOrErrorState(
      Either<Failure, void> failureOrSetState) async* {
    yield failureOrSetState.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (right) => state,
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
