import 'package:dartz/dartz.dart';
import 'package:shopping_cart/core/error/failures.dart';
import 'package:shopping_cart/core/usecases/usecases_stream.dart';
import 'package:shopping_cart/features/product/domain/entities/product.dart';
import 'package:shopping_cart/features/product/domain/repositories/product_repositoy.dart';

class GetAllProducts implements UseCase<List<Product>, NoParams> {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  @override
  Stream<Either<Failure, List<Product>>> call(NoParams params) async* {
    yield* repository.getAllProducts();
  }
}
