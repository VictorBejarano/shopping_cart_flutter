import 'package:dartz/dartz.dart';
import 'package:shopping_cart/core/error/failures.dart';
import 'package:shopping_cart/features/cart/domain/entities/product_quantity.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> createCart(
    String id,
    String status,
  );
  Future<Either<Failure, void>> buyProducts(
    String id,
    List<ProductQuantity> products,
  );
}
