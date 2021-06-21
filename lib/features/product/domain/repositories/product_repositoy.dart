import 'package:dartz/dartz.dart';
import 'package:shopping_cart/core/error/failures.dart';
import 'package:shopping_cart/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Stream<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, void>> createProduct(
    String name,
    String sku,
    String photoUrl,
    String description,
  );
}
