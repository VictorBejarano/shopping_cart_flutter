import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/core/error/failures.dart';
import 'package:shopping_cart/core/usecases/usecases.dart';
import 'package:shopping_cart/features/cart/domain/entities/product_quantity.dart';
import 'package:shopping_cart/features/cart/domain/repositories/cart_repositoy.dart';

class BuyProducts implements UseCase<void, Params> {
  final CartRepository repository;

  BuyProducts(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return repository.buyProducts(params.id, params.products);
  }
}

class Params extends Equatable {
  final String id;
  final List<ProductQuantity> products;

  Params({
    this.id,
    this.products,
  });

  @override
  List<Object> get props => [
        id,
        products,
      ];
}
