import 'package:dartz/dartz.dart';
import 'package:shopping_cart/core/error/failures.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> createCart(
    String id,
    String status,
  );
}
