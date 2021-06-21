import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/core/error/failures.dart';
import 'package:shopping_cart/core/usecases/usecases.dart';
import 'package:shopping_cart/features/product/domain/entities/product.dart';
import 'package:shopping_cart/features/product/domain/repositories/product_repositoy.dart';

class CreateProduct implements UseCase<void, Params> {
  final ProductRepository repository;

  CreateProduct(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return repository.createProduct(
        params.name, params.sku, params.photoUrl, params.description);
  }
}

class Params extends Equatable {
  final String name;
  final String sku;
  final String photoUrl;
  final String description;

  Params({
    this.name,
    this.sku,
    this.photoUrl,
    this.description,
  });

  @override
  List<Object> get props => [name, sku, photoUrl, description];
}
